namespace Poppler {

class AnnotationUtils {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(QTXML_AVAILABLE)
    static Poppler::Annotation * createAnnotation( const QDomElement & annElement );
    static void storeAnnotation( const Poppler::Annotation * ann,
        QDomElement & annElement, QDomDocument & document );
    static QDomElement findChildElement( const QDomNode & parentNode,
        const QString & name );
%End
}; // class AnnotationUtils


class Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
    enum SubType { AText = 1, ALine = 2, AGeom = 3, AHighlight = 4, AStamp = 5,
                   AInk = 6, ALink = 7, ACaret = 8, AFileAttachment = 9, ASound = 10,
                   AMovie = 11, A_BASE = 0 };
    enum Flag { Hidden = 1, FixedSize = 2, FixedRotation = 4, DenyPrint = 8,
                DenyWrite = 16, DenyDelete = 32, ToggleHidingOnMouse = 64, External = 128 };
    enum LineStyle { Solid = 1, Dashed = 2, Beveled = 4, Inset = 8, Underline = 16 };
    enum LineEffect { NoEffect = 1, Cloudy = 2};
    enum RevScope { Reply = 1, Group = 2, Delete = 4 };
    enum RevType { None = 1,  Marked = 2, Unmarked = 4,  Accepted = 8, Rejected = 16, Cancelled = 32, Completed = 64 };
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
%If(- POPPLER_V0_18_0)
    struct Style {
        // appearance properties
        QColor          color;              // black
        double          opacity;            // 1.0
        // pen properties
        double          width;              // 1.0
        Poppler::Annotation::LineStyle       style;              // LineStyle::Solid
        double          xCorners;           // 0.0
        double          yCorners;           // 0.0
        int             marks;              // 3
        int             spaces;             // 0
        // pen effects
        Poppler::Annotation::LineEffect      effect;             // LineEffect::NoEffect
        double          effectIntensity;    // 1.0
        // default initializer
        Style();
    };
    Style style;

    struct Window {
        // window state (Hidden, FixedRotation, Deny* flags allowed)
        int             flags;              // -1 (never initialized) -> 0 (if inited and shown)
        // geometric properties
        QPointF         topLeft;            // no default, inited to boundary.topLeft
        int             width;              // no default
        int             height;             // no default
        // window contens/override properties
        QString         title;              // '' text in the titlebar (overrides author)
        QString         summary;            // '' short description (displayed if not empty)
        QString         text;               // '' text for the window (overrides annot->contents)
        // default initializer
        Window();
    };
    Window window;

    struct Revision {
        // child revision
        Poppler::Annotation *    annotation;         // not null
        // scope and type of revision
        Poppler::Annotation::RevScope        scope;              // Reply
        Poppler::Annotation::RevType         type;               // None
        // default initializer
        Revision();
    };

//    QLinkedList< Poppler::Annotation::Revision >& revisions();
    const QLinkedList< Poppler::Annotation::Revision >& revisions() const;
%End
    virtual SubType subType() const = 0;
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode & parentNode, QDomDocument & document ) const;
%End
%End
    virtual ~Annotation();

private:
    Annotation(const Poppler::Annotation&);
%If(POPPLER_V0_20_0 -)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode & parentNode, QDomDocument & document ) const;
%End
%End

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
        default:
            sipType = sipType_Poppler_Annotation;
    }

%End


}; // class Annotation


class TextAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    TextAnnotation();
%If(QTXML_AVAILABLE)
    TextAnnotation( const QDomNode &node );
%End
%End
    virtual ~TextAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;
    
    enum TextType { Linked, InPlace };
    enum InplaceIntent { Unknown, Callout, TypeWriter };
    
    TextType textType() const;
%If(- POPPLER_V0_18_0)
    void setTextType( TextType type );
%End
    
    QString textIcon() const;
    void setTextIcon( const QString &icon );
    
    QFont textFont() const;
    void setTextFont( const QFont &font );
    
    int inplaceAlign() const;
    void setInplaceAlign( int align );
    
    QString inplaceText() const;
    void setInplaceText( const QString &text );
    
    QPointF calloutPoint( int id ) const;
%If(- POPPLER_V0_18_0)
    void setCalloutPoint( int id, const QPointF &point );
%End

    InplaceIntent inplaceIntent() const;
    void setInplaceIntent( InplaceIntent intent );

private:
%If(POPPLER_V0_20_0 -)
    TextAnnotation();
%If(QTXML_AVAILABLE)
    TextAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
    void setTextType( TextType type );
%End
    TextAnnotation(const Poppler::TextAnnotation&);
    
}; // class TextAnnotation


class LineAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    LineAnnotation();
%If(QTXML_AVAILABLE)
    LineAnnotation( const QDomNode &node );
%End
%End
    virtual ~LineAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;

    enum TermStyle { Square, Circle, Diamond, OpenArrow, ClosedArrow, None,
                     Butt, ROpenArrow, RClosedArrow, Slash };
    enum LineIntent { Unknown, Arrow, Dimension, PolygonCloud };

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
%If(POPPLER_V0_20_0 -)
    LineAnnotation();
%If(QTXML_AVAILABLE)
    LineAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    LineAnnotation(const Poppler::LineAnnotation&);
    
}; // class LineAnnotation


class GeomAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    GeomAnnotation();
%If(QTXML_AVAILABLE)
    GeomAnnotation( const QDomNode &node );
%End
%End
    virtual ~GeomAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;

    enum GeomType { InscribedSquare, InscribedCircle };

    GeomType geomType() const;
    void setGeomType( GeomType style );

    QColor geomInnerColor() const;
    void setGeomInnerColor( const QColor &color );

%If(- POPPLER_V0_18_0)
    int geomPointWidth() const;
    void setGeomPointWidth( int width );
%End

private:
%If(POPPLER_V0_20_0 -)
    GeomAnnotation();
%If(QTXML_AVAILABLE)
    GeomAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    GeomAnnotation(const Poppler::GeomAnnotation&);
    
}; // class GeomAnnotation


class HighlightAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    HighlightAnnotation();
%If(QTXML_AVAILABLE)
    HighlightAnnotation( const QDomNode &node );
%End
%End
    virtual ~HighlightAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;
    enum HighlightType {
        Highlight,
        Squiggly,
        Underline,
        StrikeOut,
    };
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
    HighlightType highlightType() const;
    void setHighlightType( HighlightType type );
    QList< Poppler::HighlightAnnotation::Quad > highlightQuads() const;
    void setHighlightQuads( const QList< Poppler::HighlightAnnotation::Quad > &quads );

private:
%If(POPPLER_V0_20_0 -)
    HighlightAnnotation();
%If(QTXML_AVAILABLE)
    HighlightAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    HighlightAnnotation(const Poppler::HighlightAnnotation&);
    
}; // class HighlightAnnotation


class StampAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    StampAnnotation();
%If(QTXML_AVAILABLE)
    StampAnnotation( const QDomNode &node );
%End
%End
    virtual ~StampAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;
    QString stampIconName() const;
    void setStampIconName( const QString &name );

private:
%If(POPPLER_V0_20_0 -)
    StampAnnotation();
%If(QTXML_AVAILABLE)
    StampAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End

}; // class StampAnnotation


class InkAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    InkAnnotation();
%If(QTXML_AVAILABLE)
    InkAnnotation( const QDomNode &node );
%End
%End
    virtual ~InkAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;
    QList< QLinkedList<QPointF> > inkPaths() const;
    void setInkPaths( const QList< QLinkedList<QPointF> > &paths );

private:
%If(POPPLER_V0_20_0 -)
    InkAnnotation();
%If(QTXML_AVAILABLE)
    InkAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    InkAnnotation(const Poppler::InkAnnotation&);
    
}; // class InkAnnotation


class LinkAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    LinkAnnotation();
%If(QTXML_AVAILABLE)
    LinkAnnotation( const QDomNode &node );
%End
%End
    virtual ~LinkAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;

    enum HighlightMode { None, Invert, Outline, Push };

%If(- POPPLER_V0_18_0)
    Poppler::Link* linkDestionation() const;
%End
%If(POPPLER_V0_20_0 -)
    Poppler::Link* linkDestination() const;
%End
    void setLinkDestination( Poppler::Link *link );

    HighlightMode linkHighlightMode() const;
    void setLinkHighlightMode( HighlightMode mode );

    QPointF linkRegionPoint( int id ) const;
    void setLinkRegionPoint( int id, const QPointF &point );

private:
%If(POPPLER_V0_20_0 -)
    LinkAnnotation();
%If(QTXML_AVAILABLE)
    LinkAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    LinkAnnotation(const Poppler::LinkAnnotation&);
    
}; // class LinkAnnotation


class CaretAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    CaretAnnotation();
%If(QTXML_AVAILABLE)
    CaretAnnotation( const QDomNode &node );
%End
%End
    virtual ~CaretAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;
    enum CaretSymbol { None, P };
    CaretSymbol caretSymbol() const;
    void setCaretSymbol( CaretSymbol symbol );

private:
%If(POPPLER_V0_20_0 -)
    CaretAnnotation();
%If(QTXML_AVAILABLE)
    CaretAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    CaretAnnotation(const Poppler::CaretAnnotation&);
    
}; // class CaretAnnotation


class FileAttachmentAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    FileAttachmentAnnotation();
%If(QTXML_AVAILABLE)
    FileAttachmentAnnotation( const QDomNode &node );
%End
%End
    virtual ~FileAttachmentAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;
    QString fileIconName() const;
    void setFileIconName( const QString &icon );
    Poppler::EmbeddedFile* embeddedFile() const;
    void setEmbeddedFile( Poppler::EmbeddedFile *ef );

private:
%If(POPPLER_V0_20_0 -)
    FileAttachmentAnnotation();
%If(QTXML_AVAILABLE)
    FileAttachmentAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    FileAttachmentAnnotation(const Poppler::FileAttachmentAnnotation&);
    
}; // class FileAttachmentAnnotation


class SoundAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    SoundAnnotation();
%If(QTXML_AVAILABLE)
    SoundAnnotation( const QDomNode &node );
%End
%End
    virtual ~SoundAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;
    QString soundIconName() const;
    void setSoundIconName( const QString &icon );
    Poppler::SoundObject* sound() const;
    void setSound( Poppler::SoundObject *ef );

private:
%If(POPPLER_V0_20_0 -)
    SoundAnnotation();
%If(QTXML_AVAILABLE)
    SoundAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    SoundAnnotation(const Poppler::SoundAnnotation&);
    
}; // class SoundAnnotation


class MovieAnnotation : Poppler::Annotation {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-annotation.h>
%End

public:
%If(- POPPLER_V0_18_0)
    MovieAnnotation();
%If(QTXML_AVAILABLE)
    MovieAnnotation( const QDomNode &node );
%End
%End
    virtual ~MovieAnnotation();
%If(- POPPLER_V0_18_0)
%If(QTXML_AVAILABLE)
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    virtual SubType subType() const;

    Poppler::MovieObject* movie() const;
    void setMovie( Poppler::MovieObject *movie );
    QString movieTitle() const;
    void setMovieTitle( const QString &title );

private:
%If(POPPLER_V0_20_0 -)
    MovieAnnotation();
%If(QTXML_AVAILABLE)
    MovieAnnotation( const QDomNode &node );
    virtual void store( QDomNode &parentNode, QDomDocument &document ) const;
%End
%End
    MovieAnnotation(const Poppler::MovieAnnotation&);
    
}; // class MovieAnnotation


}; // namespace Poppler

/* kate: indent-width 4; space-indent on; hl c++; indent-mode cstyle; */
