namespace Poppler {

class EmbeddedFile {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
//     EmbeddedFile(EmbFile *embfile);
    ~EmbeddedFile();
    QString name() const;
    QString description() const;
    int size() const;
    QDateTime modDate() const;
    QDateTime createDate() const;
    QByteArray checksum() const;
    QString mimeType() const;
    QByteArray data();
    bool isValid() const;

private:    
    EmbeddedFile(const Poppler::EmbeddedFile&);
}; // class EmbeddedFile

}; // namespace Poppler
