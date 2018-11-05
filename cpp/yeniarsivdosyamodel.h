#ifndef YENIARSIVDOSYAMODEL_H
#define YENIARSIVDOSYAMODEL_H

#include <QtCore/QObject>
#include <QtCore/qglobal.h>
#include <QJsonArray>
#include <QJsonValue>
#include <QJsonObject>

class YeniArsivDosyaModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY( QJsonArray model READ model WRITE setModel NOTIFY modelChanged )
public:
    explicit YeniArsivDosyaModel(QObject *parent = nullptr);


    QJsonArray model() const;
    void setModel( const QJsonArray &model );

    Q_INVOKABLE void append( QString str );
    Q_INVOKABLE void remove( int index );

    Q_INVOKABLE void addFile(QString fileUrls);

    Q_INVOKABLE void setFileOcred( const int &index );

    Q_INVOKABLE void setfileOcr( const int &index , QString ocrText );

    Q_INVOKABLE QString filename(const int& index);

    Q_INVOKABLE bool isPDF(const int& index);

    Q_INVOKABLE qint64 getJulianDate(const int& year);

    Q_INVOKABLE void clear();



signals:
    void modelChanged();
public slots:

private:
    QJsonArray mModel;
};

#endif // YENIARSIVDOSYAMODEL_H
