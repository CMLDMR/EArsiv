import QtQuick 2.11
import QtGraphicalEffects 1.0

Item {


    anchors.fill: parent
    id: item

    signal newKategori(string kat);

    Rectangle{
        anchors.fill: parent
        color: "#CC000000"



        Rectangle{
            id: rect
            width: parent.width > 400 ? 400 : parent.width
            height: 100
            anchors.centerIn: parent
            Column{
                anchors.fill: parent

                Rectangle{
                    width: parent.width
                    height: 50
                    TextInput{
                        id: newkategoriinput
                        width: parent.width
                        height: parent.height
                        font.bold: true
                        font.family: "Tahoma"
                        font.pointSize: 10
                        color: "black"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        Text {
                            text: qsTr("Yeni Kategori Adını Giriniz");
                            visible: !parent.text
                            font.bold: true
                            font.family: "Tahoma"
                            font.pointSize: 10
                            color: "#999999"
                            anchors.centerIn: parent
                        }
                    }
                }

                Rectangle{
                    width: parent.width
                    height: 50
                    Row{
                        anchors.fill: parent
                        Rectangle{
                            width: parent.width/2
                            height: 50
                            color: "orange"
                            Text {
                                text: qsTr("Ekle")
                                font.bold: true
                                font.family: "Tahoma"
                                font.pointSize: 10
                                color: "DarkSlateGray"
                                anchors.centerIn: parent
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    newKategori(newkategoriinput.text);
                                }
                            }
                        }
                        Rectangle{
                            width: parent.width/2
                            height: 50
                            color: "steelblue"
                            Text {
                                text: qsTr("İptal")
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
    }

}
