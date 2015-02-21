namespace Poppler {

class SoundObject {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
    enum SoundType {
        External,
        Embedded,
    };
    enum SoundEncoding {
        Raw,
        Signed,
        muLaw,
        ALaw,
    };
//     SoundObject(Sound *popplersound);
    ~SoundObject();
    SoundType soundType() const;
    QString url() const;
    QByteArray data() const;
    double samplingRate() const;
    int channels() const;
    int bitsPerSample() const;
    SoundEncoding soundEncoding() const;
    
private:
    SoundObject(const Poppler::SoundObject&);
}; // class SoundObject

}; // namespace Poppler
