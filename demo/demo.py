import sys
from PyQt5 import QtGui, QtWidgets
import popplerqt5

usage = """
Demo to load a PDF and display the first page.

Usage:

    python demo.py file.pdf

"""


def pdf_view(filename):
    """Return a Scrollarea showing the first page of the specified PDF file."""
    
    label = QtWidgets.QLabel()
    
    doc = popplerqt5.Poppler.Document.load(filename)
    doc.setRenderHint(popplerqt5.Poppler.Document.Antialiasing)
    doc.setRenderHint(popplerqt5.Poppler.Document.TextAntialiasing)
    
    page = doc.page(0)
    image = page.renderToImage()
    
    label.setPixmap(QtGui.QPixmap.fromImage(image))
    
    area = QtWidgets.QScrollArea()
    area.setWidget(label)
    area.setWindowTitle(filename)
    return area


def main():
    app = QtWidgets.QApplication(sys.argv)
    argv = QtWidgets.QApplication.arguments()
    if len(argv) < 2:
        sys.stderr.write(usage)
        sys.exit(2)
    
    filename = argv[-1]
    view = pdf_view(filename)
    view.show()
    sys.exit(app.exec_())


if __name__ == "__main__":
    main()
