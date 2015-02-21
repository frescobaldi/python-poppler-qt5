namespace Poppler {

class FontIterator {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
    ~FontIterator();
    QList<Poppler::FontInfo> next();
    bool hasNext() const;
    int currentPage() const;

    Poppler::FontIterator * __iter__();
%MethodCode
    sipRes = sipCpp;
%End
    SIP_PYOBJECT __next__();
%MethodCode
    if (sipCpp->hasNext()) {
        QList<Poppler::FontInfo> next = sipCpp->next();
        sipRes = sipConvertFromType(&next, sipFindType("QList<Poppler::FontInfo>"), Py_None);
    } else {
        PyErr_SetNone(PyExc_StopIteration);
    }
%End

private:
    FontIterator(const Poppler::FontIterator&);
//     FontIterator( int, DocumentData *dd );
}; // class FontIterator

}; // namespace Poppler
