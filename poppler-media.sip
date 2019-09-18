%If(POPPLER_V0_22_0 -)

namespace Poppler {
    
class MediaRendition {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-media.h>
%End

  public:
    ~MediaRendition();
    bool isValid() const;
    QString contentType() const;
    QString fileName() const;
    bool isEmbedded() const;
    QByteArray data() const;
    bool autoPlay() const;
    bool showControls() const;
    float repeatCount() const;
    QSize size() const;

  private:
    MediaRendition(Poppler::MediaRendition *rendition);
    MediaRendition(const Poppler::MediaRendition&);

}; // class MediaRendition

    
}; // namespace Poppler

%End

/* kate: indent-width 4; space-indent on; hl c++; indent-mode cstyle; */
    
