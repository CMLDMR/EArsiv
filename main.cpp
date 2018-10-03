#include <QtCore/qglobal.h>
#if QT_VERSION >= 0x050000
#include <QtGui/QGuiApplication>
#include <QtQml/QQmlApplicationEngine>
#else
#endif

#include <QQmlContext>

#include "qmlmongodb.h"
#include "../url.h"
#include "cpp/yeniarsivdosyamodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QMLMongoDB::instance(url,dbname);

    qmlRegisterType<YeniArsivDosyaModel>("com.eArsiv", 1, 0, "ArsivModel");

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("db",new QMLMongoDB());

    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
