QT += quick core
CONFIG += c++14

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += \
        main.cpp \
    cpp/yeniarsivdosyamodel.cpp \
    cpp/utility.cpp

RESOURCES += qml.qrc \
    resource.qrc


RC_FILE = app.rc


# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target



win32{

    gcc{
        message("* using settings for windows gcc 5.30");
        win32:CONFIG(release, debug|release): LIBS += -L$$PWD/mingw32-windows-release-v0.7/lib/ -lQMongoDB
        else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/mingw32-windows-release-v0.7/lib/ -lQMongoDBd
        else:unix: LIBS += -L$$PWD/mingw32-windows-release-v0.7/lib/ -lQMongoDB

        INCLUDEPATH += $$PWD/mingw32-windows-release-v0.7/include
        DEPENDPATH += $$PWD/mingw32-windows-release-v0.7/include
    }

    msvc{

        message("* using settings for windows msvc2015x64");

        win32:CONFIG(release, debug|release): LIBS += -L$$PWD/msvc-2015-x64-release-v0.7/lib/ -lQMongoDB
        else:win32:CONFIG(debug, debug|release): LIBS += -L$$PWD/msvc-2015-x64-release-v0.7/lib/ -lQMongoDBd
        else:unix: LIBS += -L$$PWD/msvc-2015-x64-release-v0.7/lib/ -lQMongoDB

        INCLUDEPATH += $$PWD/msvc-2015-x64-release-v0.7/include
        DEPENDPATH += $$PWD/msvc-2015-x64-release-v0.7/include


        win32: LIBS += -L$$PWD/tesseract-msvc-2015-x64/lib/ -lleptonica-1.76.0

        INCLUDEPATH += $$PWD/tesseract-msvc-2015-x64/include
        DEPENDPATH += $$PWD/tesseract-msvc-2015-x64/include

        win32: LIBS += -L$$PWD/tesseract-msvc-2015-x64/lib/ -ltesseract40

    }


}




HEADERS += \
    cpp/yeniarsivdosyamodel.h \
    cpp/utility.h




