import QtQuick 2.11
import QtQuick.Window 2.11
import QtGraphicalEffects 1.0

import com.mongodb 0.7

Window {

    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("E-Arşiv - 2018 Serik Belediyesi")


    MongoDB{
        id: db
    }


    Rectangle{
        id: rectangle
        width: parent.width
        height: parent.height
        color: "gray"


        Rectangle{
            id: header
            width: parent.width > 1024 ? 1024 : parent.width
            height: 120
            color: "transparent"
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top

            Rectangle{
                id: userohoto
                width: 100
                height: 120
                color: "transparent"
                anchors.left: parent.left
                Image {
                    id: userimg
                    source: "file"
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectFit
                }
            }

            Rectangle{
                anchors.left: userohoto.right
                anchors.right: parent.right
                anchors.top: parent.top
                height: 50
                color: "DarkSlateGray"
                Column{
                    anchors.fill: parent
                    Text {
                        id: adsoyad
                        text: qsTr("")
                        font.bold: true
                        font.family: "Tahoma"
                        font.pointSize: 10
                        color: "white"
                    }
                    Text {
                        id: birim
                        text: qsTr("")
                        font.bold: false
                        font.family: "Gothic"
                        font.pointSize: 10
                        color: "white"
                    }
                }

                Rectangle{
                    anchors.bottom: parent.bottom
                    height: 2
                    color: "white"
                    width: parent.width
                }
            }

            DropShadow {
                anchors.fill: userohoto
                horizontalOffset: 0
                verticalOffset: 0
                radius: 8.0
                samples: 17
                color: "#FF000000"
                source: userohoto
            }
        }



        Rectangle{
            id: mainrect
            width: parent.width
            anchors.top: header.bottom
            anchors.bottom: parent.bottom
            color: "transparent"

            LoginScreen{
                id: user
                onLoginSucces: {
                    visible = false;
                    userimg.source = db.fileurl(user.kullanici.getElement("fotooid").Oid);
                    adsoyad.text = user.kullanici.getElement("ad soyad").String
                    birim.text = user.kullanici.getElement("Birimi").String
                }
            }
        }






    }


}
