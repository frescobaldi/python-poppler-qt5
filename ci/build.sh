#!/bin/bash

set -eu # exit on error
set -o xtrace # show each command before running

# Sync with pyproject.toml. POPPLER_VERSION is for the download of Poppler and may contain
# leading zeroes, while PYTHON_POPPLER_QT5_VERSION does not.
POPPLER_VERSION="21.03.0"
PYTHON_POPPLER_QT5_VERSION="21.3.0"

# These compiler flags add an RPATH entry with value $ORIGIN (literally),
# to make the built shared libraries search for Qt and Poppler in the
# same directory instead of using the system ones. --disable-new-dtags
# is to generate an RPATH and not a RUNPATH; the latter doesn't apply
# to transitive dependencies.
RPATH_OPTION="-Wl,-rpath,'\$ORIGIN',--disable-new-dtags"
# Shell quoting madness to survive through qmake and make ...
RPATH_OPTION_2="-Wl,-rpath,'\\'\\\$\\\$ORIGIN\\'',--disable-new-dtags"

if [ "$OSTYPE" == "linux-gnu" ]; then
    export LIBRARY_PATH=$CONDA_BUILD_SYSROOT/lib:$CONDA_PREFIX/lib
else # macOS
    export LIBRARY_PATH=$CONDA_PREFIX/lib
    export MACOSX_DEPLOYMENT_TARGET=11.0
fi

# Download and extract the Poppler source code

POPPLER=poppler-$POPPLER_VERSION
curl -O https://poppler.freedesktop.org/$POPPLER.tar.xz
tar -xvf $POPPLER.tar.xz
# Patch Poppler to avoid building the tests. Newer Poppler versions have a config
# variable for this.
sed -iback 's/add_subdirectory(test)//g' $POPPLER/CMakeLists.txt


pushd $POPPLER

# Construct build options

CMAKE_OPTIONS=
# We don't need the Qt6, GLib (GTK) and C++ wrappers, only the Qt5 one.
CMAKE_OPTIONS+="-DENABLE_QT5=ON"
CMAKE_OPTIONS+=" -DENABLE_QT6=OFF"
CMAKE_OPTIONS+=" -DENABLE_GLIB=OFF"
CMAKE_OPTIONS+=" -DENABLE_CPP=OFF"
# We don't need the command line utilities (pdfimages, pdfattach, etc.)
CMAKE_OPTIONS+=" -DENABLE_UTILS=OFF"
# We don't need libpng or libtiff. Apparently, only they're used in pdfimages.
# However, the build is not smart enough to avoid searching them if the utilities
# aren't built.
CMAKE_OPTIONS+=" -DWITH_PNG=OFF"
CMAKE_OPTIONS+=" -DWITH_TIFF=OFF"
# Disable network stuff that's apparently used to validate signatures and the like.
# We don't need this.
CMAKE_OPTIONS+=" -DWITH_NSS3=OFF"
CMAKE_OPTIONS+=" -DENABLE_LIBCURL=OFF"
# Disable the use of Little CMS. (TODO: maybe this would actually be
# useful? Investigate.)
CMAKE_OPTIONS+=" -DENABLE_CMS=none"
# Disable Cairo backend, it's (famously) not supported in the Qt5 wrapper anyway.
CMAKE_OPTIONS+=" -DWITH_Cairo=OFF"
# Disable the use of Fontconfig, it's only needed for PDFs that use external
# fonts. We don't care to support these.
CMAKE_OPTIONS+=" -DFONT_CONFIGURATION=generic"
# Don't build the tests.
CMAKE_OPTIONS+=" -DBUILD_QT5_TESTS=OFF"
# Install locally
CMAKE_OPTIONS+=" -DCMAKE_INSTALL_PREFIX==../../../installed-poppler"

if [ "$OSTYPE" == "linux-gnu" ]; then
    export LDFLAGS=$RPATH_OPTION
fi

# Generate Poppler Makefile
PKG_CONFIG_LIBDIR=$CONDA_PREFIX/lib/pkgconfig \
    cmake -S . -B build $CMAKE_OPTIONS

# Build Poppler
pushd build
make -j$(nproc)
make install
popd

export -n LDFLAGS

popd

# Now build python-poppler-qt5. Add a RUNPATH just like for poppler.
if [ "$OSTYPE" == "linux-gnu" ]; then
    SIP_EXTRA_ARGS="--link-args=$RPATH_OPTION_2"
    POPPLER_LIB_DIR=installed-poppler/lib64
else
    SIP_EXTRA_ARGS=
    POPPLER_LIB_DIR=installed-poppler/lib
fi

PKG_CONFIG_LIBDIR=$POPPLER_LIB_DIR/pkgconfig:$CONDA_PREFIX/lib/pkgconfig \
    sip-wheel --verbose $SIP_EXTRA_ARGS --build-dir=build

# Unpack wheel to tinker with it
WHEEL=(python_poppler_qt5*.whl)
wheel unpack "$WHEEL"
pushd python_poppler_qt5-$PYTHON_POPPLER_QT5_VERSION

# Vendor libopenjp2 and libjpeg
if [ "$OSTYPE" == "linux-gnu" ]; then
    LIB_FILES="../$POPPLER_LIB_DIR/*.so* $CONDA_PREFIX/lib/libopenjp2.so* $CONDA_PREFIX/lib/libjpeg.so*"
else
    LIB_FILES="../$POPPLER_LIB_DIR/*.dylib* $CONDA_PREFIX/lib/libopenjp2.dylib* $CONDA_PREFIX/lib/libjpeg.dylib*"
fi

cp $LIB_FILES PyQt5/Qt5/lib/

pushd PyQt5/Qt5/lib
if [ "$OSTYPE" != "linux-gnu" ]; then
    for file in _popplerqt5*.so libpoppler*.dylib; do
        install_name_tool -delete_rpath "$CONDA_PREFIX/lib" "$file"
        install_name_tool -add_rpath "@loader_path" "$file"
    done
fi
popd

# Repack the wheel
popd
mkdir fixed-wheel
wheel pack --dest-dir=fixed-wheel python_poppler_qt5-$PYTHON_POPPLER_QT5_VERSION
