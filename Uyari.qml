import QtQuick 2.0

Item {

    anchors.fill: parent
    id: item


    property string mesaj: ""

    Rectangle{
        anchors.fill: parent
        color: "#CC000000"

        Rectangle{
            width: parent.width > 400 ? 400 : parent.width
            height: 100
            anchors.centerIn: parent
            Column{
                anchors.fill: parent
                Rectangle{
                    id: firstRect
                    width: parent.width
                    color: "#AAAAAA"
                    Text {
                        id: mesajid
                        text: mesaj
                        font.bold: true
                        font.family: "Tahoma"
                        font.pointSize: 10
                        color: "white"
                        anchors.centerIn: parent
                        width: parent.width
                        wrapMode: Text.WordWrap
                        horizontalAlignment: Text.AlignHCenter
                    }
                    height: mesajid.height > 50 ? mesajid.height : 50
                }
                Rectangle{
                    width: parent.width
                    height: 100 - firstRect.height
                    color: "DarkSlateGray"
                    Text {
                        text: "Tamam"
                        font.bold: true
                        font.family: "Tahoma"
                        font.pointSize: 10
                        color: "white"
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            item.destroy();
                        }
                    }
                }
            }
        }
    }

}
