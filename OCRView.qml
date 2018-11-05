import QtQuick 2.11
import QtQuick.Controls 2.4



Item {

    id: item
    anchors.fill: parent

    property string imgpath: ""

    signal sakla(string ocr);


    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        Rectangle {
            id: uyaritext
            width: 0
            height: parent.height
            color: "#CC000000"
            clip: true
            anchors.centerIn: parent

            MouseArea{
                anchors.fill: parent
            }

            Rectangle {
                id: colomRect
                width: parent.width > 1024 ? 1024 : parent.width
                height: parent.height
                color: "transparent"
                anchors.centerIn: parent
                Column{
                    anchors.fill: parent
                    Rectangle {
                        width: parent.width
                        height: 50
                        color: "Gray"
                        Text {
                            text: qsTr("OCR")
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            anchors.centerIn: parent
                        }
                    }

                    Rectangle {
                        id: contentRect
                        width: parent.width
                        height: colomRect.height-150
                        color: "DarkSlateGray"
                        ScrollView{
                            width: parent.width
                            height: parent.height
                            clip: true
                            Column{
                                anchors.fill: parent
                                Rectangle {
                                    width: contentRect.width
                                    color: "DarkSlateGray"
                                    id: ocrtextRect
                                    height: 550
                                    Text {
                                        id: ocrText
                                        text: "OCR Çalışıyor, Lütfen Bekleyiniz"
                                        font.bold: true
                                        font.pointSize: 10
                                        font.family: "Tahoma"
                                        color: "white"
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        horizontalAlignment: Text.AlignHCenter
                                    }
                                }
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 50
                        color: "CornflowerBlue "
                        anchors.bottomMargin: 50
                        Text {
                            text: qsTr("Bu Metni Sakla")
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            color: "white"
                            anchors.centerIn: parent
                        }
                        MouseArea{
                            anchors.fill: parent
                            onClicked: {


                                sakla(ocrText.text);

                                closeupuyari.start();
                            }
                        }
                    }

                    Rectangle {
                        width: parent.width
                        height: 50
                        color: "DarkGray"
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
                                closeupuyari.start();
                            }
                        }
                    }
                }
            }


            Connections {
                target: Utility
                onExtractedTextChanged: {
//                    print ("PROPERTY ANIMATION STARTED");
//                    openupuyari.start();
                }
            }






        }



    }

    Component.onCompleted: {
        openupuyari.start();
    }


    PropertyAnimation{
        id: openupuyari
        target: uyaritext
        property: "width"
        to: item.width
        duration: 250
        onStopped: {
            ocrText.text = Utility.runTesseract(imgpath)
            ocrtextRect.height = ocrText.height;
        }
    }

    PropertyAnimation{
        id: closeupuyari
        target: uyaritext
        property: "width"
        to: 0
        duration: 250
        onStopped: {
            item.destroy();
        }
    }



    function closeView(){

        closeupuyari.start();

    }
}
