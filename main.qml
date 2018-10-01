import QtQuick 2.11
import QtQuick.Window 2.11

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("E-Arşiv - 2018 Serik Belediyesi")



    Rectangle{
        width: parent.width
        height: parent.height
        color: "transparent"



        Rectangle{
            id: mainrect
            width: parent.width
            height: parent.height


            Component.onCompleted: {
                var com = Qt.createComponent("qrc:/LoginScreen.qml");

                if( com.status === Component.Ready )
                {
                    var e = com.createObject(mainrect);
                }
            }
        }



    }


}
