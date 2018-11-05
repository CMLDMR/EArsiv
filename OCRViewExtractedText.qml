import QtQuick 2.11
import QtQuick.Controls 2.4


Item {

    id : item

    property string ocr: ""
    anchors.fill: parent



    Rectangle {
        width: parent.width
        height: parent.height
        color: "#CC000000"

        MouseArea{
            anchors.fill: parent
        }


        Rectangle {
            width: parent.width
            height: parent.height
            color: "transparent"

            Column{
                anchors.fill: parent

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkGray"
                    Text {
                        text: qsTr("OCR Metni")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }


                Rectangle {
                    width: parent.width
                    height: parent.height-100
                    color: "DarkGray"
                    ScrollView{
                        id: scrollView
                        width: parent.width
                        height: parent.height
                        clip: true
                        Column{
                            anchors.fill: parent
                            Rectangle {
                                width: scrollView.width
                                color: "DarkSlateGray"
                                id: ocrtextRect
                                Text {
                                    id: ocrText
                                    text: ocr
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    width: parent.width
                                    wrapMode: Text.WordWrap
                                    horizontalAlignment: Text.AlignHCenter
                                }
                                height: ocrText.height
                            }
                        }
                    }

                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "Brown"
                    Text {
                        text: qsTr("Kapat")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
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
