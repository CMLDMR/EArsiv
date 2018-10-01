import QtQuick 2.11


import com.mongodb 0.7

Item {

    anchors.fill: parent
    id: item

    Rectangle{

        anchors.fill: parent

        color: "transparent"

        Row{
            spacing: 5
            anchors.fill: parent
            Rectangle{
                id: kategoriRect
                width: item.width/2
                height: item.height
                Column{
                    spacing: 2
                    anchors.fill: parent
                    Rectangle{
                        width: kategoriRect.width
                        height: 50
                        Text {
                            text: qsTr("Kategoriler")
                            anchors.centerIn: parent
                            font.bold: true
                            font.family: "Tahoma"
                            color: "white"
                        }
                        color: "steelblue"
                    }
                    Repeater{
                        id: repeater
                        Rectangle{
                            width: kategoriRect.width
                            height: 30
                            Text {
                                text: modelData.getElement("kategoriAdi").String
                                anchors.centerIn: parent
                            }
                            Rectangle{
                                width: parent.width
                                height: 1
                                color: "gray"
                                anchors.bottom: parent.bottom
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    var filter = QBSON.newBSON();
                                    QBSON.insertOid(filter,"kategorioid",modelData.getElement("_id").Oid);
                                    repeaterTip.model = db.find("ArsivTip",filter,QBSON.newBSON());
                                }
                            }
                        }
                    }
                    Component.onCompleted: {
                        var filter = QBSON.newBSON();
                        QBSON.insertString(filter,"birim",user.getElement("Birimi").String);
                        repeater.model = db.find("ArsivKategori",filter,QBSON.newBSON());
                    }
                }
            }

            Rectangle{
                width: item.width/2
                height: item.height
                Rectangle{
                    id: tipRect
                    width: item.width/2
                    height: item.height
                    Column{
                        spacing: 2
                        anchors.fill: parent
                        Rectangle{
                            width: tipRect.width
                            height: 50
                            Text {
                                text: qsTr("Arşiv Tipi")
                                anchors.centerIn: parent
                                font.bold: true
                                font.family: "Tahoma"
                                color: "white"
                            }
                            color: "steelblue"
                        }
                        Repeater{
                            id: repeaterTip
                            Rectangle{
                                width: tipRect.width
                                height: 30
                                Text {
                                    text: modelData.getElement("adi").String
                                    anchors.centerIn: parent
                                    color: "black"
                                }
                                Rectangle{
                                    width: parent.width
                                    height: 1
                                    color: "gray"
                                    anchors.bottom: parent.bottom
                                }
                            }
                        }
                        Component.onCompleted: {
                            var filter = QBSON.newBSON();
                            QBSON.insertString(filter,"birim",user.getElement("Birimi").String);
                            repeater.model = db.find("ArsivKategori",filter,QBSON.newBSON());
                        }
                    }
                }
            }
        }





    }

}
