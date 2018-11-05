#include "utility.h"

#include <QDebug>

Utility::Utility(QObject *parent) : QObject(parent) , api(new tesseract::TessBaseAPI())
{
    if( api->Init(nullptr,"tur") ){
        initFalse = false;
    }else{
        initFalse = true;
    }
}

Utility::~Utility()
{
    api->End();

    delete api;
}

QString Utility::runTesseract(QString filename)
{


    if( !initFalse ){
        this->mExtractedText = "Failed OCR!";
        emit this->extractedTextChanged();
    }

    QFileInfo fileinfo(filename);

    qDebug() << fileinfo.suffix() ;
    qDebug() << fileinfo.absoluteFilePath();




    Pix* img = pixRead(filename.toStdString().c_str());

    api->SetImage(img);

    QString str = api->GetUTF8Text();


    pixDestroy(&img);

    this->mExtractedText = str;
    emit this->extractedTextChanged();
    return str;

}

QString Utility::extractedText() const
{
    return mExtractedText;
}
