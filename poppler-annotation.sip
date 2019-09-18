namespace Poppler
{

class AnnotationUtils
{
%Docstring
Helper class for (recursive) Annotation retrieval/storage.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
%If(QTXML_AVAILABLE)
    static Poppler::Annotation * createAnnotation( const QDomElement & annElement );
%Docstring
Restore an ``Annotation`` (with revisions if needed) from the DOM element
``annElement``.

Returns the complete Annotation or None if element is invalid.
%End
    static void storeAnnotation( const Poppler::Annotation * ann,
        QDomElement & annElement, QDomDocument & document );
    static QDomElement findChildElement( const QDomNode & parentNode,
        const QString & name );
%End
}; // class AnnotationUtils


class Annotation
{
%Docstring
Annotation class holding properties shared by all annotations.
%End

%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
    enum SubType
    {
        AText = 1,
        ALine = 2,
        AGeom = 3,
        AHighlight = 4,
        AStamp = 5,
        AInk = 6,
        ALink = 7,
        ACaret = 8,
        AFileAttachment = 9,
        ASound = 10,
        AMovie = 11,
%If(POPPLER_V0_20_0 -)
        AScreen = 12,
%End
%If(POPPLER_V0_22_0 -)
        AWidget = 13,
%End
%If(POPPLER_V0_36_0 -)
        ARichMedia = 14,
%End
        A_BASE = 0
    };
    enum Flag
    {
        Hidden = 1,
        FixedSize = 2,
        FixedRotation = 4,
        DenyPrint = 8,
        DenyWrite = 16,
        DenyDelete = 32,
        ToggleHidingOnMouse = 64,
        External = 128
    };
    enum LineStyle
    {
         Solid = 1,
         Dashed = 2,
         Beveled = 4,
         Inset = 8,
         Underline = 16
    };
    enum LineEffect
    {
        NoEffect = 1,
        Cloudy = 2
    };
    enum RevScope
    {
%If(POPPLER_V0_20_0 -)
        Root = 0,
%End
        Reply = 1,
        Group = 2,
        Delete = 4
    };
    enum RevType
    {
        None = 1,
        Marked = 2,
        Unmarked = 4,
        Accepted = 8,
        Rejected = 16,
        Cancelled = 32,
        Completed = 64
    };
    QString author() const;
    void setAuthor( const QString &author );
    QString contents() const;
    void setContents( const QString &contents );
    QString uniqueName() const;
    void setUniqueName( const QString &uniqueName );
    QDateTime modificationDate() const;
    void setModificationDate( const QDateTime &date );
    QDateTime creationDate() const;
    void setCreationDate( const QDateTime &date );
    int flags() const;
    void setFlags( int flags );
    QRectF boundary() const;
    void setBoundary( const QRectF &boundary );

%If(POPPLER_V0_20_0 -)
    class Style
    {
    public:
        Style();
        Style( const Poppler::Annotation::Style &other );
        //Style& operator=( const Style &other );
        ~Style();
        
        // appearance properties
        QColor color() const;                     // black
        void setColor(const QColor &color);
        double opacity() const;                   // 1.0
        void setOpacity(double opacity);

        // pen properties
        double width() const;                     // 1.0
        void setWidth(double width);
        Poppler::Annotation::LineStyle lineStyle() const;              // LineStyle::Solid
        void setLineStyle(Poppler::Annotation::LineStyle style);
        double xCorners() const;                  // 0.0
        void setXCorners(double radius);
        double yCorners() const;                  // 0.0
        void setYCorners(double radius);
        const QVector<double>& dashArray() const; // [ 3 ]
        void setDashArray(const QVector<double> &array);

        // pen effects
        Poppler::Annotation::LineEffect lineEffect() const;            // LineEffect::NoEffect
        void setLineEffect(Poppler::Annotation::LineEffect effect);
        double effectIntensity() const;           // 1.0
        void setEffectIntensity(double intens);

    };

    Poppler::Annotation::Style style() const;
    void setStyle( const Poppler::Annotation::Style& style );
%End
    
%If(POPPLER_V0_20_0 -)
    class Popup
    {
%Docstring
Container class for Annotation pop-up window information
%End
    public:
        Popup();
        Popup( const Poppler::Annotation::Popup &other );
        //Popup& operator=( const Popup &other );
        ~Popup();

        // window state (Hidden, FixedRotation, Deny* flags allowed)
        int flags() const;       // -1 (never initialized) -> 0 (if inited and shown)
        void setFlags( int flags );

        // geometric properties
        QRectF geometry() const; // no default
        void setGeometry( const QRectF &geom );

        // window contens/override properties
        QString title() const;   // '' text in the titlebar (overrides author)
        void setTitle( const QString &title );
        QString summary() const; // '' short description (displayed if not empty)
        void setSummary( const QString &summary );
        QString text() const;    // '' text for the window (overrides annot->contents)
        void setText( const QString &text );

    };

    Poppler::Annotation::Popup popup() const;
    void setPopup( const Poppler::Annotation::Popup& popup );
%Docstring
Warning: Currently does nothing
%End
%End

%If(POPPLER_V0_20_0 -)
    RevScope revisionScope() const; // Root
    RevType revisionType() const;   // None
%End

%If(POPPLER_V0_20_0 -)
    /**
     * Returns the revisions of this annotation
     *
     * \note The caller owns the returned annotations and they should
     *       be deleted when no longer required.
     *
     * \since 0.20
     */
    QList<Poppler::Annotation*> revisions() const;
%End

    /**
     * The type of the annotation.
     */
    virtual SubType subType() const = 0;

    /**
     * Destructor.
     */
    virtual ~Annotation();

%If(POPPLER_V0_22_0 -)
    /**
     * Describes the flags from an annotations 'AA' dictionary.
     *
     * This flag is used by the additionalAction() method for ScreenAnnotation
     * and WidgetAnnotation.
     *
     * \since 0.22
     */
    enum AdditionalActionType
    {
        CursorEnteringAction, ///< Performed when the cursor enters the annotation's active area
        CursorLeavingAction,  ///< Performed when the cursor exists the annotation's active area
        MousePressedAction,   ///< Performed when the mouse button is pressed inside the annotation's active area
        MouseReleasedAction,  ///< Performed when the mouse button is released inside the annotation's active area
        FocusInAction,        ///< Performed when the annotation receives the input focus
        FocusOutAction,       ///< Performed when the annotation loses the input focus
        PageOpeningAction,    ///< Performed when the page containing the annotation is opened
        PageClosingAction,    ///< Performed when the page containing the annotation is closed
        PageVisibleAction,    ///< Performed when the page containing the annotation becomes visible
        PageInvisibleAction   ///< Performed when the page containing the annotation becomes invisible
    };
%End

protected:
%If(QTXML_AVAILABLE)
    void storeBaseAnnotationProperties( QDomNode & parentNode, QDomDocument & document ) const;
%End

private:
    Annotation(const Poppler::Annotation&);
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode & parentNode, QDomDocument & document ) const;
%End

%If(- POPPLER_V0_36_0)
%ConvertToSubClassCode
    switch (sipCpp->subType()) {
        case Poppler::Annotation::AText:
            sipType = sipType_Poppler_TextAnnotation;
            break;
        case Poppler::Annotation::ALine:
            sipType = sipType_Poppler_LineAnnotation;
            break;
        case Poppler::Annotation::AGeom:
            sipType = sipType_Poppler_GeomAnnotation;
            break;
        case Poppler::Annotation::AHighlight:
            sipType = sipType_Poppler_HighlightAnnotation;
            break;
        case Poppler::Annotation::AStamp:
            sipType = sipType_Poppler_StampAnnotation;
            break;
        case Poppler::Annotation::AInk:
            sipType = sipType_Poppler_InkAnnotation;
            break;
        case Poppler::Annotation::ALink:
            sipType = sipType_Poppler_LinkAnnotation;
            break;
        case Poppler::Annotation::ACaret:
            sipType = sipType_Poppler_CaretAnnotation;
            break;
        case Poppler::Annotation::AFileAttachment:
            sipType = sipType_Poppler_FileAttachmentAnnotation;
            break;
        case Poppler::Annotation::ASound:
            sipType = sipType_Poppler_SoundAnnotation;
            break;
        case Poppler::Annotation::AMovie:
            sipType = sipType_Poppler_MovieAnnotation;
            break;
        case Poppler::Annotation::AScreen:
            sipType = sipType_Poppler_ScreenAnnotation;
            break;
        case Poppler::Annotation::AWidget:
            sipType = sipType_Poppler_WidgetAnnotation;
            break;
        default:
            sipType = sipType_Poppler_Annotation;
    }
%End
%End
%If(POPPLER_V0_36_0 -)
%ConvertToSubClassCode
    switch (sipCpp->subType()) {
        case Poppler::Annotation::AText:
            sipType = sipType_Poppler_TextAnnotation;
            break;
        case Poppler::Annotation::ALine:
            sipType = sipType_Poppler_LineAnnotation;
            break;
        case Poppler::Annotation::AGeom:
            sipType = sipType_Poppler_GeomAnnotation;
            break;
        case Poppler::Annotation::AHighlight:
            sipType = sipType_Poppler_HighlightAnnotation;
            break;
        case Poppler::Annotation::AStamp:
            sipType = sipType_Poppler_StampAnnotation;
            break;
        case Poppler::Annotation::AInk:
            sipType = sipType_Poppler_InkAnnotation;
            break;
        case Poppler::Annotation::ALink:
            sipType = sipType_Poppler_LinkAnnotation;
            break;
        case Poppler::Annotation::ACaret:
            sipType = sipType_Poppler_CaretAnnotation;
            break;
        case Poppler::Annotation::AFileAttachment:
            sipType = sipType_Poppler_FileAttachmentAnnotation;
            break;
        case Poppler::Annotation::ASound:
            sipType = sipType_Poppler_SoundAnnotation;
            break;
        case Poppler::Annotation::AMovie:
            sipType = sipType_Poppler_MovieAnnotation;
            break;
        case Poppler::Annotation::AScreen:
            sipType = sipType_Poppler_ScreenAnnotation;
            break;
        case Poppler::Annotation::AWidget:
            sipType = sipType_Poppler_WidgetAnnotation;
            break;
        case Poppler::Annotation::ARichMedia:
            sipType = sipType_Poppler_RichMediaAnnotation;
            break;
        default:
            sipType = sipType_Poppler_Annotation;
    }
%End
%End

}; // class Annotation


class TextAnnotation : Poppler::Annotation
{
%Docstring
Annotation containing text.

A text annotation is an object showing some text directly on the page, or
linked to the contents using an icon shown on a page.
%End

%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    // local enums
    enum TextType
    {
        Linked,
        InPlace
    };
    enum InplaceIntent
    {
        Unknown,
        Callout,
        TypeWriter
    };

    TextAnnotation( TextType type );
    virtual ~TextAnnotation();
    virtual SubType subType() const;

    /**
       The type of text annotation represented by this object
    */
    TextType textType() const;

    /**
       The name of the icon for this text annotation.

       Standard names for text annotation icons are:
       - Comment
       - Help
       - Insert
       - Key
       - NewParagraph
       - Note (this is the default icon to use)
       - Paragraph
    */
    QString textIcon() const;

    /**
       Set the name of the icon to use for this text annotation.

       \sa textIcon for the list of standard names
    */
    void setTextIcon( const QString &icon );

    QFont textFont() const;
    void setTextFont( const QFont &font );

    int inplaceAlign() const;
    void setInplaceAlign( int align );

    QPointF calloutPoint( int id ) const;
%If(POPPLER_V0_20_0 -)
    QVector<QPointF> calloutPoints() const;
    void setCalloutPoints( const QVector<QPointF> &points );
%End

    InplaceIntent inplaceIntent() const;
    void setInplaceIntent( InplaceIntent intent );

private:
%If(QTXML_AVAILABLE)
    TextAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
    void setTextType( TextType type );
    
}; // class TextAnnotation


class LineAnnotation : Poppler::Annotation
{
%Docstring
Polygon/polyline annotation.

This annotation represents a polygon (or polyline) to be drawn on a page.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    // local enums
%If(POPPLER_V0_20_0 -)
    enum LineType
    {
        StraightLine,
        Polyline
    };
%End
    enum TermStyle
    {
        Square,
        Circle,
        Diamond,
        OpenArrow,
        ClosedArrow,
        None,
        Butt,
        ROpenArrow,
        RClosedArrow,
        Slash
     };
    enum LineIntent
    {
        Unknown,
        Arrow,
        Dimension,
        PolygonCloud
    };

%If(POPPLER_V0_20_0 -)
    LineAnnotation( LineType type );
%End
    virtual ~LineAnnotation();
    virtual SubType subType() const;

%If(POPPLER_V0_20_0 -)
    LineType lineType() const;
%End

    QLinkedList<QPointF> linePoints() const;
    void setLinePoints( const QLinkedList<QPointF> &points );

    TermStyle lineStartStyle() const;
    void setLineStartStyle( TermStyle style );

    TermStyle lineEndStyle() const;
    void setLineEndStyle( TermStyle style );

    bool isLineClosed() const;
    void setLineClosed( bool closed );

    QColor lineInnerColor() const;
    void setLineInnerColor( const QColor &color );

    double lineLeadingForwardPoint() const;
    void setLineLeadingForwardPoint( double point );

    double lineLeadingBackPoint() const;
    void setLineLeadingBackPoint( double point );

    bool lineShowCaption() const;
    void setLineShowCaption( bool show );

    LineIntent lineIntent() const;
    void setLineIntent( LineIntent intent );

  private:
%If(QTXML_AVAILABLE)
    LineAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End

    void setLineType( LineType type );


}; // class LineAnnotation


class GeomAnnotation : Poppler::Annotation
{
%Docstring
Geometric annotation.

The geometric annotation represents a geometric figure, like a rectangle or
an ellipse.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    GeomAnnotation();
    virtual ~GeomAnnotation();
    virtual SubType subType() const;

    // common enums
    enum GeomType
    {
        InscribedSquare,
        InscribedCircle
    };

    GeomType geomType() const;
    void setGeomType( GeomType style );

    QColor geomInnerColor() const;
    void setGeomInnerColor( const QColor &color );

  private:
%If(QTXML_AVAILABLE)
    GeomAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
    
}; // class GeomAnnotation


class HighlightAnnotation : Poppler::Annotation
{
%Docstring
Text highlight annotation.

The highlight annotation represents some areas of text being "highlighted".
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    HighlightAnnotation();
    virtual ~HighlightAnnotation();
    virtual SubType subType() const;

    /**
       The type of highlight
    */
    enum HighlightType
    {
        Highlight,
        Squiggly,
        Underline,
        StrikeOut,
    };
    
    /**
       Structure corresponding to a QuadPoints array. This matches a
       quadrilateral that describes the area around a word (or set of
       words) that are to be highlighted.
    */
    struct Quad {
        QPointF *    points
        {
            %GetCode
                sipPy = PyList_New(4);
                PyObject* obj;
                for (SIP_SSIZE_T i = 0; i < 4; ++i)
                {
                    QPointF *point = new QPointF(sipCpp->points[i]);
                    obj = sipConvertFromNewType(point, sipType_QPointF, NULL);
                    PyList_SET_ITEM(sipPy, i, obj);
                }
            %End
            %SetCode
                SIP_SSIZE_T len;
                if (!PySequence_Check(sipPy) || (len = PySequence_Size(sipPy)) != 4)
                    sipErr = 1;
                else
                {
                    for (SIP_SSIZE_T i = 0; i < 4; ++i)
                    {
                        PyObject *itm = PySequence_ITEM(sipPy, i);
                        bool ok = (itm && sipCanConvertToType(itm, sipType_QPointF, SIP_NOT_NONE));
                        Py_XDECREF(itm);

                        if (!ok)
                        {
                            sipErr = 1;
                            break;
                        }
                    }
                }
                
                if (sipErr == 1)
                    PyErr_SetString(PyExc_ValueError, "Quad.points must be a sequence of exactly 4 QPointF() instances");
                else
                {
                    int iserr = 0;
                    for (SIP_SSIZE_T i = 0; i < 4; ++i)
                    {
                        PyObject *itm = PySequence_ITEM(sipPy, i);
                        QPointF *point = reinterpret_cast<QPointF *>(sipConvertToType(itm, sipType_QPointF, 0, 0, 0, &iserr));
                        sipCpp->points[i] = *point;
                        Py_DECREF(itm);
                    }
                }
            %End
        };
        bool            capStart;
        bool            capEnd;
        double          feather;
    };
    /**
       The type (style) of highlighting to use for this area
       or these areas.
    */
    HighlightType highlightType() const;

    /**
       Set the type of highlighting to use for the given area
       or areas.
    */
    void setHighlightType( HighlightType type );

    /**
       The list of areas to highlight.
    */
    QList< Poppler::HighlightAnnotation::Quad > highlightQuads() const;

    /**
       Set the areas to highlight.
    */
    void setHighlightQuads( const QList< Poppler::HighlightAnnotation::Quad > &quads );

  private:
%If(QTXML_AVAILABLE)
    HighlightAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
    
}; // class HighlightAnnotation


class StampAnnotation : Poppler::Annotation
{
%Docstring
Stamp annotation.

A simple annotation drawing a stamp on a page.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    StampAnnotation();
    virtual ~StampAnnotation();
    virtual SubType subType() const;

    /**
       The name of the icon for this stamp annotation.

       Standard names for stamp annotation icons are:
       - Approved
       - AsIs
       - Confidential
       - Departmental
       - Draft (this is the default icon type)
       - Experimental
       - Expired
       - Final
       - ForComment
       - ForPublicRelease
       - NotApproved
       - NotForPublicRelease
       - Sold
       - TopSecret
    */
    QString stampIconName() const;

    /**
       Set the icon type for this stamp annotation.

       \sa stampIconName for the list of standard icon names
    */
    void setStampIconName( const QString &name );

  private:
%If(QTXML_AVAILABLE)
    StampAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End

}; // class StampAnnotation


class InkAnnotation : Poppler::Annotation
{
%Docstring
Ink Annotation.

Annotation representing an ink path on a page.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    InkAnnotation();
    virtual ~InkAnnotation();
    virtual SubType subType() const;

    QList< QLinkedList<QPointF> > inkPaths() const;
    void setInkPaths( const QList< QLinkedList<QPointF> > &paths );

  private:
%If(QTXML_AVAILABLE)
    InkAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End

}; // class InkAnnotation


class LinkAnnotation : Poppler::Annotation
{
%Docstring
Link Annotation.

Annotation representing a link on a page.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    virtual ~LinkAnnotation();
    virtual SubType subType() const;

    // local enums
    enum HighlightMode
    {
        None,
        Invert,
        Outline,
        Push
    };

%If(POPPLER_V0_20_0 -)
    Poppler::Link* linkDestination() const;
    void setLinkDestination( Poppler::Link *link );
%End

    HighlightMode linkHighlightMode() const;
    void setLinkHighlightMode( HighlightMode mode );

    QPointF linkRegionPoint( int id ) const;
    void setLinkRegionPoint( int id, const QPointF &point );

  private:
    LinkAnnotation();
%If(QTXML_AVAILABLE)
    LinkAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End

}; // class LinkAnnotation


class CaretAnnotation : Poppler::Annotation
{
%Docstring
Caret annotation.

The caret annotation represents a symbol to indicate the presence of text.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    CaretAnnotation();
    virtual ~CaretAnnotation();
    virtual SubType subType() const;

    /**
     * The symbols for the caret annotation.
     */
    enum CaretSymbol
    {
        None,
        P
    };

    CaretSymbol caretSymbol() const;
    void setCaretSymbol( CaretSymbol symbol );

  private:
%If(QTXML_AVAILABLE)
    CaretAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End

}; // class CaretAnnotation


class FileAttachmentAnnotation : Poppler::Annotation
{
%Docstring
File attachment annotation.

The file attachment annotation represents a file embedded in the document.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    virtual ~FileAttachmentAnnotation();
    virtual SubType subType() const;

    /**
     * Returns the name of the icon of this annotation.
     */
    QString fileIconName() const;
    /**
     * Sets a new name for the icon of this annotation.
     */
    void setFileIconName( const QString &icon );

    /**
     * Returns the EmbeddedFile of this annotation.
     */
    Poppler::EmbeddedFile* embeddedFile() const;
    /**
     * Sets a new EmbeddedFile for this annotation.
     *
     * \note FileAttachmentAnnotation takes ownership of the object
     */
    void setEmbeddedFile( Poppler::EmbeddedFile *ef );

  private:
    FileAttachmentAnnotation();
%If(QTXML_AVAILABLE)
    FileAttachmentAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
    
}; // class FileAttachmentAnnotation


class SoundAnnotation : Poppler::Annotation
{
%Docstring
Sound annotation.

The sound annotation represents a sound to be played when activated.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    virtual ~SoundAnnotation();
    virtual SubType subType() const;

    /**
     * Returns the name of the icon of this annotation.
     */
    QString soundIconName() const;
    /**
     * Sets a new name for the icon of this annotation.
     */
    void setSoundIconName( const QString &icon );

    /**
     * Returns the SoundObject of this annotation.
     */
    Poppler::SoundObject* sound() const;
    /**
     * Sets a new SoundObject for this annotation.
     *
     * \note SoundAnnotation takes ownership of the object
     */
    void setSound( Poppler::SoundObject *ef );

  private:
    SoundAnnotation();
%If(QTXML_AVAILABLE)
    SoundAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
  
}; // class SoundAnnotation


class MovieAnnotation : Poppler::Annotation
{
%Docstring
Movie annotation.

The movie annotation represents a movie to be played when activated.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    virtual ~MovieAnnotation();
    virtual SubType subType() const;

    /**
     * Returns the MovieObject of this annotation.
     */
    Poppler::MovieObject* movie() const;
    /**
     * Sets a new MovieObject for this annotation.
     *
     * \note MovieAnnotation takes ownership of the object
     */
    void setMovie( Poppler::MovieObject *movie );

    /**
     * Returns the title of the movie of this annotation.
     */
    QString movieTitle() const;
    /**
     * Sets a new title for the movie of this annotation.
     */
    void setMovieTitle( const QString &title );

  private:
    MovieAnnotation();
%If(QTXML_AVAILABLE)
    MovieAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
   
}; // class MovieAnnotation


class  ScreenAnnotation : Poppler::Annotation
{
%Docstring
Screen annotation.

The screen annotation represents a screen to be played when activated.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    virtual ~ScreenAnnotation();

    virtual SubType subType() const;

    /**
     * Returns the LinkRendition of this annotation.
     */
    Poppler::LinkRendition* action() const;

    /**
     * Sets a new LinkRendition for this annotation.
     *
     * \note ScreenAnnotation takes ownership of the object
     */
    void setAction( Poppler::LinkRendition *action );

    /**
     * Returns the title of the screen of this annotation.
     */
    QString screenTitle() const;

    /**
     * Sets a new title for the screen of this annotation.
     */
    void setScreenTitle( const QString &title );

    /**
     * Returns the additional action of the given @p type fo the annotation or
     * @c 0 if no action has been defined.
     *
     * \since 0.22
     */
%If(POPPLER_V0_22_0 -)
    Poppler::Link* additionalAction( AdditionalActionType type ) const;
%End

  private:
    ScreenAnnotation();
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const; // stub
%End

}; // class ScreenAnnotation


class WidgetAnnotation : Poppler::Annotation
{
%Docstring
Widget annotation.

The widget annotation represents a widget (form field) on a page.

Note: this class is just provided for consistency of the annotation API,
use the FormField classes to get all the form-related information.
%End
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

  public:
    virtual ~WidgetAnnotation();

    virtual SubType subType() const;

    /**
     * Returns the additional action of the given @p type fo the annotation or
     * @c 0 if no action has been defined.
     *
     * \since 0.22
     */
%If(POPPLER_V0_22_0 -)
    Poppler::Link* additionalAction( AdditionalActionType type ) const;
%End

  private:
    WidgetAnnotation();
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const; // stub
%End

}; // class WidgetAnnotation

%If(POPPLER_V0_36_0 -)
class RichMediaAnnotation : Poppler::Annotation
{
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End
  public:
    ~RichMediaAnnotation();

    SubType subType() const;
    class Params
    {
      public:
        Params();
        ~Params();

        /**
         * Returns the parameters for the flash player.
         */
        QString flashVars() const;

    };
    class Instance
    {
      public:
        enum Type
        {
          Type3D,     ///< A 3D media file.
          TypeFlash,  ///< A Flash media file.
          TypeSound,  ///< A sound media file.
          TypeVideo   ///< A video media file.
        };

        Instance();
        ~Instance();
        Type type() const;
        Poppler::RichMediaAnnotation::Params* params() const;
    };
    class Configuration
    {
      public:
        enum Type
        {
          Type3D,     ///< A 3D media file.
          TypeFlash,  ///< A Flash media file.
          TypeSound,  ///< A sound media file.
          TypeVideo   ///< A video media file.
        };

        Configuration();
        ~Configuration();
        Type type() const;
        QString name() const;
        QList< Poppler::RichMediaAnnotation::Instance* > instances() const;
    };

    class Asset
    {
      public:
        Asset();
        ~Asset();
        QString name() const;
        EmbeddedFile* embeddedFile() const;
    };
    class Content
    {
      public:
        Content();
        ~Content();
        QList< Poppler::RichMediaAnnotation::Configuration* > configurations() const;
        QList< Poppler::RichMediaAnnotation::Asset* > assets() const;
    };
    class Activation
    {
      public:
        enum Condition {
          PageOpened,   ///< Activate when page is opened.
          PageVisible,  ///< Activate when page becomes visible.
          UserAction    ///< Activate when user interacts with the annotation.
        };
        Activation();
        ~Activation();
        Condition condition() const;
    };
    class Deactivation
    {
      public:
        enum Condition {
          PageClosed,     ///< Deactivate when page is closed.
          PageInvisible,  ///< Deactivate when page becomes invisible.
          UserAction      ///< Deactivate when user interacts with the annotation.
        };

        Deactivation();
        ~Deactivation();
        Condition condition() const;
    };
    class Settings
    {
      public:
        Poppler::RichMediaAnnotation::Activation* activation() const;
        Poppler::RichMediaAnnotation::Deactivation* deactivation() const;
      private:
        Settings();
        ~Settings();
    };
    Poppler::RichMediaAnnotation::Settings* settings() const;
    Poppler::RichMediaAnnotation::Content* content() const;
  
  private:
    RichMediaAnnotation();

}; // class RichMediaAnnotation
%End



}; // namespace Poppler

/* kate: indent-width 4; space-indent on; hl c++; indent-mode cstyle; */
