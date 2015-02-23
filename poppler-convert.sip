namespace Poppler {

class BaseConverter {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
    virtual ~BaseConverter();
    void setOutputFileName(const QString &outputFileName);
    void setOutputDevice(QIODevice *device);
    virtual bool convert() = 0;
    enum Error
    {
        NoError,
        FileLockedError,
        OpenOutputError,
        NotSupportedInputFileError,
    };
    Error lastError() const;
private:
    BaseConverter(const Poppler::BaseConverter&);
}; // class BaseConverter


class PSConverter : Poppler::BaseConverter {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
    enum PSOption {
        Printing = 0x00000001,
        StrictMargins = 0x00000002,
        ForceRasterization = 0x00000004,
    };
    typedef QFlags<Poppler::PSConverter::PSOption> PSOptions;
    ~PSConverter();
    void setPageList(const QList<int> &pageList);
    void setTitle(const QString &title);
    void setHDPI(double hDPI);
    void setVDPI(double vDPI);
    void setRotate(int rotate);
    void setPaperWidth(int paperWidth);
    void setPaperHeight(int paperHeight);
    void setRightMargin(int marginRight);
    void setBottomMargin(int marginBottom);
    void setLeftMargin(int marginLeft);
    void setTopMargin(int marginTop);
    void setStrictMargins(bool strictMargins);
    void setForceRasterize(bool forceRasterize);
    void setPSOptions(PSOptions options);
    PSOptions psOptions() const;
    bool convert();

private:
    PSConverter(const Poppler::PSConverter&);
}; // class PSConverter


class PDFConverter : Poppler::BaseConverter {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
    enum PDFOption {
        WithChanges = 0x00000001,
    };
    typedef QFlags<Poppler::PDFConverter::PDFOption> PDFOptions;
    virtual ~PDFConverter();
    void setPDFOptions(PDFOptions options);
    PDFOptions pdfOptions() const;
    bool convert();

private:
    PDFConverter(const Poppler::PDFConverter&);
}; // class PDFConverter


}; // namespace Poppler

/* kate: indent-width 4; space-indent on; hl c++; indent-mode cstyle; */
