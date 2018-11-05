#ifndef UTILITY_H
#define UTILITY_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>
#include <QProcess>
#include <QFile>
#include <QFileInfo>

#include <tesseract/baseapi.h>
#include <leptonica/allheaders.h>

#pragma comment(lib, "ws2_32.lib")


class Utility : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString extractedText READ extractedText NOTIFY extractedTextChanged)
public:
    explicit Utility(QObject *parent = nullptr);

    ~Utility();


    Q_INVOKABLE QString runTesseract(QString filename);


    QString extractedText() const;

    void extractTags( const QString &ocrText );

signals:
    void extractedTextChanged();

public slots:

private:
    tesseract::TessBaseAPI *api;

    bool initFalse;


    QString mExtractedText;

};

#endif // UTILITY_H
