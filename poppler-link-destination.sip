namespace Poppler {

class LinkDestination {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-link.h>
%End

public:
    enum Kind {
        destXYZ = 1,
        destFit = 2,
        destFitH = 3,
        destFitV = 4,
        destFitR = 5,
        destFitB = 6,
        destFitBH = 7,
        destFitBV = 8,
    };
    LinkDestination(const QString &description);
    LinkDestination(const Poppler::LinkDestination &other);
    ~LinkDestination();
    Kind kind() const;
    int pageNumber() const;
    double left() const;
    double bottom() const;
    double right() const;
    double top() const;
    double zoom() const;
    bool isChangeLeft() const;
    bool isChangeTop() const;
    bool isChangeZoom() const;
    QString toString() const;
    QString destinationName() const;
}; // class LinkDestination

}; // namespace Poppler
