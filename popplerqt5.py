# The actual popplerqt5 lives under next to Qt libraries, because that
# is the most portable way of making it find those libraries instead
# of system ones.  This wrapper module just reexports the actual
# module.

from PyQt5.Qt5.lib._popplerqt5 import *
