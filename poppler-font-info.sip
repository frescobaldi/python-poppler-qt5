namespace Poppler {

class FontInfo {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
%End

public:
    enum Type {
        unknown,
        Type1,
        Type1C,
        Type1COT,
        Type3,
        TrueType,
        TrueTypeOT,
        CIDType0,
        CIDType0C,
        CIDType0COT,
        CIDTrueType,
        CIDTrueTypeOT,
    };
    FontInfo();
//     FontInfo( const FontInfoData &fid );
    FontInfo( const Poppler::FontInfo &fi );
    ~FontInfo();
    QString name() const;
    QString file() const;
    bool isEmbedded() const;
    bool isSubset() const;
    Type type() const;
    QString typeName() const;

}; // class FontInfo

}; // namespace Poppler
