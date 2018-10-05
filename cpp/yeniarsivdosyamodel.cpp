#include "yeniarsivdosyamodel.h"
#include <QDir>
#include <QFile>
#include <QUrl>
#include <QImage>
#include <QDate>

#include <QDebug>

YeniArsivDosyaModel::YeniArsivDosyaModel(QObject *parent) : QObject(parent)
{

}

QJsonArray YeniArsivDosyaModel::model() const
{
    return mModel;
}

void YeniArsivDosyaModel::setModel(const QJsonArray &model)
{
    mModel = model;
}

void YeniArsivDosyaModel::append(QString str)
{
    mModel.append(str);
    emit modelChanged();
}

void YeniArsivDosyaModel::remove(int index)
{
    if( mModel.count() )
    {
        if( index >= mModel.count() || index < 0 )
        {

        }else{
            mModel.removeAt(index);
            emit modelChanged();
        }
    }
}

void YeniArsivDosyaModel::addFile(QString fileUrl)
{

    QUrl url(fileUrl);
    if( !fileUrl.isEmpty() )
    {
        mModel.append(url.toLocalFile());
        emit modelChanged();
    }

}

QString YeniArsivDosyaModel::filename(const int &index)
{

    if( index >= 0 && index < mModel.count() )
    {
        QFileInfo info(this->mModel.at(index).toString() );
        return  info.baseName();
    }else{
        return "BilinmeyenDosyaAdı";
    }
}

bool YeniArsivDosyaModel::isPDF(const int &index)
{
    if( index >= 0 && index < mModel.count() )
    {
        QFileInfo info(this->mModel.at(index).toString() );
        return  info.suffix() == "pdf";
    }else{
        return false;
    }
}

qint64 YeniArsivDosyaModel::getJulianDate(const int &year)
{
    return QDate::fromString(QString::number(year),"yyyy").toJulianDay();
}

void YeniArsivDosyaModel::clear()
{
    while( this->mModel.count()  )
    {
        this->mModel.removeAt(0);
    }
    emit modelChanged();
}

