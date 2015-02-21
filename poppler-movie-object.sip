namespace Poppler {

class MovieObject {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
    enum PlayMode {
        PlayOnce,
        PlayOpen,
        PlayRepeat,
        PlayPalindrome,
    };
    ~MovieObject();
    QString url() const;
    QSize size() const;
    int rotation() const;
    bool showControls() const;
    PlayMode playMode() const;

private:
    MovieObject(const Poppler::MovieObject&);
}; // class MovieObject

}; // namespace Poppler
