The CI setup is made of this directory (`ci/`) as well as the GitHub workflow
definition in `.github/workflows/`.

This CI builds wheels (precompiled packages) of python-poppler-qt5, currently
only for Linux. These wheels can be used on any reasonably recent Linux
system.

Building the wheels is an involved process. First, we need to get a version of
PyQt5 that can be used for compilation, i.e., it must contain the C++ headers
and CMake helper files. Unfortunately, this is not the case of the PyQt5-Qt5
distribution on PyPI. This is why we use Conda to get Qt5 (as well as other
stuff).

Since Linux binaries link to the system glibc, which is binary
backwards-compatible but not forwards-compatible, getting a wheel that is
actually compatible with many Linux systems requires compiling against an old
glibc. This is also nicely achieved by using the libc in Conda's build
environment.

(Note that this assumes that the compiler and compiler flags in use in the Conda
environment are ABI-compatible with the PyQt5-Qt5 wheels on PyPI. If by
misfortune that ceases being the case in the future, we will need to find
another strategy.)

We build Poppler itself from source because it links to a large number of
external libraries by default and it would be impractical to bundle them all in
the wheels: not only would it increase the size, but for some of these
libraries, it is questionable that bundling them is the right thing to do (e.g.,
graphics libraries that might need to be system-dependent). By turning off lots
of features, we reduce the set of external libraries to link to only libjpeg and
libopenjp2.

Note: Searching for fonts on the system (for PDFs that don't embed their own
fonts, which are rare) is disabled since it would require also shipping
libfontconfig. Users who want this feature should get a different build of
python-poppler-qt5.
