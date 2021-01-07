namespace Poppler {

class Document {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
%If(POPPLER_V0_22_0 -)
    enum FormType {
        NoForm,
        AcroForm,
        XfaForm,
    };
%End
    enum PageMode {
        UseNone,
        UseOutlines,
        UseThumbs,
        FullScreen,
        UseOC,
        UseAttach,
    };
    enum PageLayout {
        NoLayout,
        SinglePage,
        OneColumn,
        TwoColumnLeft,
        TwoColumnRight,
        TwoPageLeft,
        TwoPageRight,
    };
    enum RenderBackend {
        SplashBackend,
        ArthurBackend,
    };
    enum RenderHint {
        Antialiasing = 0x00000001,
        TextAntialiasing = 0x00000002,
        TextHinting = 0x00000004,
        TextSlightHinting = 0x00000008,
%If(POPPLER_V0_22_0 -)
        OverprintPreview = 0x00000010,
%End
%If(POPPLER_V0_24_0 -)
        ThinLineSolid = 0x00000020,
        ThinLineShape = 0x00000040,
%End
%If(POPPLER_V0_36_0 -)
        IgnorePaperColor = 0x00000080,
%End
%If(POPPLER_V0_60_0 -)
        HideAnnotations = 0x00000100,
%End
    };
    typedef QFlags<Poppler::Document::RenderHint> RenderHints;

    void setColorDisplayProfile(void *outputProfileA);
    void setColorDisplayProfileName(const QString &name);
    void* colorRgbProfile() const;
    void* colorDisplayProfile() const;
    static Poppler::Document *load(const QString & filePath,
                            const QByteArray &ownerPassword=QByteArray(),
                            const QByteArray &userPassword=QByteArray()) /Factory, ReleaseGIL/;
%If(POPPLER_V0_85_0 -)
    static Poppler::Document *load (QIODevice *device,
                            const QByteArray &ownerPassword=QByteArray(),
                            const QByteArray &userPassword=QByteArray()) /Factory, ReleaseGIL/;
%End
    static Poppler::Document *loadFromData(const QByteArray &fileContents,
                            const QByteArray &ownerPassword=QByteArray(),
                            const QByteArray &userPassword=QByteArray()) /Factory, ReleaseGIL/;
    Poppler::Page *page(int index) const /Factory/;
    Poppler::Page *__getitem__(int index) const /Factory/;
%MethodCode
    SIP_SSIZE_T i = sipConvertFromSequenceIndex(a0, sipCpp->numPages());
    if (i < 0)
        sipIsErr = 1;
    else
        sipRes = sipCpp->page((int)i);
%End
    Poppler::Page *page(const QString &label) const /Factory/;
    int numPages() const /__len__/;
    int __bool__() const;
%MethodCode
    sipRes = 1;
%End
    PageMode pageMode() const;
    PageLayout pageLayout() const;
%If(POPPLER_V0_28_0 -)
    Qt::LayoutDirection textDirection() const;
%End
    bool unlock(const QByteArray &ownerPassword, const QByteArray &userPassword);
    bool isLocked() const;
    QDateTime date( const QString & data ) const;
    bool setDate( const QString & key, const QDateTime & val );
    QDateTime creationDate() const;
    bool setCreationDate( const QDateTime & val );
    QDateTime modificationDate() const;
    bool setModificationDate( const QDateTime & val );
    QString info( const QString & data ) const;
    bool setInfo( const QString & key, const QString & val );
    QString title() const;
    bool setTitle( const QString & val );
    QString author() const;
    bool setAuthor( const QString & val );
    QString subject() const;
    bool setSubject( const QString & val );
    QString keywords() const;
    bool setKeywords( const QString & val );
    QString creator() const;
    bool setCreator( const QString & val );
    QString producer() const;
    bool setProducer( const QString & val );
    QStringList infoKeys() const;
    bool removeInfo();
    bool isEncrypted() const;
    bool isLinearized() const;
    bool okToPrint() const;
    bool okToPrintHighRes() const;
    bool okToChange() const;
    bool okToCopy() const;
    bool okToAddNotes() const;
    bool okToFillForm() const;
    bool okToCreateFormFields() const;
    bool okToExtractForAccessibility() const;
    bool okToAssemble() const;
    void getPdfVersion(int *major, int *minor) const;
    QList<Poppler::FontInfo> fonts() const /ReleaseGIL/;
    Poppler::FontIterator* newFontIterator( int startPage = 0 ) const /Factory/;
    QByteArray fontData(const Poppler::FontInfo &font) const;
    QList<Poppler::EmbeddedFile*> embeddedFiles() const;
    bool hasEmbeddedFiles() const;
%If(QTXML_AVAILABLE)
    QDomDocument *toc() const;
%End
    Poppler::LinkDestination *linkDestination( const QString &name ) /Factory, ReleaseGIL/;
    void setPaperColor(const QColor &color);
    QColor paperColor() const;
    void setRenderBackend( RenderBackend backend );
    RenderBackend renderBackend() const;
    static QSet<Poppler::Document::RenderBackend> availableRenderBackends();
    void setRenderHint( RenderHint hint, bool on = true );
    RenderHints renderHints() const;
    Poppler::PSConverter *psConverter() const /Factory/;
    Poppler::PDFConverter *pdfConverter() const /Factory/;
    QString metadata() const;
    bool hasOptionalContent() const;
    Poppler::OptContentModel *optionalContentModel() /Factory/;
    QStringList scripts() const;
    bool getPdfId(QByteArray *permanentId, QByteArray *updateId) const;
%If(POPPLER_V0_22_0 -)
    FormType formType() const;
%End
%If(POPPLER_V0_60_0 -)
    QVector<int> formCalculateOrder() const;
%End

private:
    Document();
    Document(const Poppler::Document &);

}; // class Document

}; // namespace Poppler
