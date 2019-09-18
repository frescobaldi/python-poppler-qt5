namespace Poppler {

class Page {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
    ~Page();
    enum Rotation {
        Rotate0 = 0,
        Rotate90 = 1,
        Rotate180 = 2,
        Rotate270 = 3,
    };
    enum PageAction {
        Opening,
        Closing,
    };
    enum TextLayout {
        PhysicalLayout,
        RawOrderLayout,
    };
    enum PainterFlag {
        DontSaveAndRestore = 0x00000001,
    };
    typedef QFlags<Poppler::Page::PainterFlag> PainterFlags;
    QImage renderToImage(double xres=72.0, double yres=72.0, int x=-1, int y=-1, int w=-1, int h=-1, Rotation rotate = Rotate0) const /ReleaseGIL/;
    bool renderToPainter(QPainter* painter, double xres=72.0, double yres=72.0, int x=-1, int y=-1, int w=-1, int h=-1,
                         Rotation rotate = Rotate0, PainterFlags flags = 0) const /ReleaseGIL/;
    QImage thumbnail() const;
    QString text(const QRectF &rect, TextLayout textLayout) const;
    QString text(const QRectF &rect) const;
    enum SearchDirection {
        FromTop,
        NextResult,
        PreviousResult,
    };
    enum SearchMode {
        CaseSensitive,
        CaseInsensitive,
    };
%If(POPPLER_V0_31_0 -)
    enum SearchFlag {
%If(POPPLER_V0_60_0 -)
        NoSearchFlags = 0x00000000,
%End
        IgnoreCase = 0x00000001,
        WholeWords = 0x00000002,
%If(POPPLER_V0_74_0 -)
        IgnoreDiacritics = 0x00000004,
%End
    };
    typedef QFlags<Poppler::Page::SearchFlag> SearchFlags;
%End
    bool search(const QString &text, double &rectLeft, double &rectTop, double &rectRight, double &rectBottom, SearchDirection direction, SearchMode caseSensitive, Rotation rotate = Rotate0) const /Deprecated, ReleaseGIL/;
    bool search(const QString &text, double &rectLeft, double &rectTop, double &rectRight, double &rectBottom, SearchDirection direction, SearchFlags flags = 0, Rotation rotate = Rotate0) const /ReleaseGIL/;
%If(POPPLER_V0_22_0 -)
    QList<QRectF> search(const QString &text, SearchMode caseSensitive, Rotation rotate = Rotate0) const /Deprecated, ReleaseGIL/;
%End
%If(POPPLER_V0_31_0 -)
    QList<QRectF> search(const QString &text, SearchFlags flags = 0, Rotation rotate = Rotate0) const /ReleaseGIL/;
%End
    QList<Poppler::TextBox*> textList(Rotation rotate = Rotate0) const;
    QSizeF pageSizeF() const;
    QSize pageSize() const;
    Poppler::PageTransition *transition() const;
    Poppler::Link *action( PageAction act ) const;
    enum Orientation {
        Landscape,
        Portrait,
        Seascape,
        UpsideDown,
    };
    Orientation orientation() const;
    void defaultCTM(double *CTM, double dpiX, double dpiY, int rotate, bool upsideDown);
    QList<Poppler::Link*> links() const;
    QList<Poppler::Annotation*> annotations() const /Factory/;
%If(POPPLER_V0_28_0 -)
    QList<Poppler::Annotation*> annotations(const QSet<Poppler::Annotation::SubType> &subtypes) const /Factory/;
%End
%If(POPPLER_V0_20_0 -)
    void addAnnotation( const Annotation *ann );
    void removeAnnotation( const Annotation *ann );
%End
    QList<Poppler::FormField*> formFields() const;
    double duration() const;
    QString label() const;

private:
    Page();
    Page( const Poppler::Page & );
    
}; // class Page

}; // namespace Poppler
