namespace Poppler {

class OptContentModel : QAbstractItemModel {
%TypeHeaderCode
#include <qt5/poppler-qt5.h>
#include <qt5/poppler-optcontent.h>
%End

public:
    virtual ~OptContentModel();

    QModelIndex index(int row, int column, const QModelIndex &parent) const;
    QModelIndex parent(const QModelIndex &child) const;

    int rowCount(const QModelIndex &parent = QModelIndex()) const;
    int columnCount(const QModelIndex &parent) const;

    QVariant data(const QModelIndex &index, int role) const;
    virtual bool setData ( const QModelIndex & index, const QVariant & value, int role = Qt::EditRole );

    Qt::ItemFlags flags ( const QModelIndex & index ) const;

    virtual QVariant headerData( int section, Qt::Orientation orientation, int role = Qt::DisplayRole ) const;

%If(POPPLER_V0_50_0 -)
    void applyLink( LinkOCGState *link );
%End

private:
    OptContentModel(const Poppler::OptContentModel&);
}; // class OptContentModel

}; // namespace Poppler
