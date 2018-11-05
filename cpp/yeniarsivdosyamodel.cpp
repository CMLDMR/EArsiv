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

    QUrl url(str);
    if( !str.isEmpty() )
    {

        QJsonObject obj;

        obj.insert("url",url.toLocalFile());
        obj.insert("ocred",false);
        obj.insert("ocr","");

        mModel.append(obj);
        emit modelChanged();
    }


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

        QJsonObject obj;

        obj.insert("url",url.toLocalFile());
        obj.insert("ocred",false);
        obj.insert("ocr","");

        mModel.append(obj);
        emit modelChanged();
    }

}

void YeniArsivDosyaModel::setFileOcred(const int &index , const QString & ocrText )
{



    auto obj = mModel.at(index).toObject();

    obj.insert("ocred",true);
    obj.insert("ocr",ocrText);

    mModel.replace(index,obj);

    emit modelChanged();

}

void YeniArsivDosyaModel::setFileOcr(const int &index/*, const QString &ocrText*/)
{
    QString ocrText;
    qDebug() << "setfileOcr" << index << ocrText ;
    auto obj = mModel.at(index).toObject();

    obj.insert("ocr",ocrText);

//    mModel.replace(index,obj);

//    emit modelChanged();
}

QString YeniArsivDosyaModel::filename(const int &index)
{

    if( index >= 0 && index < mModel.count() )
    {
        QFileInfo info(this->mModel.at(index).toObject()["url"].toString() );
        return  info.baseName();
    }else{
        return "BilinmeyenDosyaAdı";
    }
}

QString YeniArsivDosyaModel::fileOcr(const int &index)
{
    if( this->mModel.at(index).toObject()["ocred"].toBool() )
    {
        return this->mModel.at(index).toObject()["ocr"].toString();
    }else{
        return "No OCR Exist";
    }

}

bool YeniArsivDosyaModel::isPDF(const int &index)
{
    if( index >= 0 && index < mModel.count() )
    {
        QFileInfo info(this->mModel.at(index).toObject()["url"].toString() );
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

