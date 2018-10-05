import QtQuick 2.11
import QtQuick.Controls 2.2
import com.mongodb 0.7

Item {

    anchors.fill: parent
    id: item

    property string oid: ""
    property int itemHeight: 25

    Rectangle {
        width: parent.width
        height: parent.height
        color: "transparent"

        Rectangle {
            width: parent.width
            height: 50
            color: "DarkSlateGray"
            anchors.bottom: parent.bottom
            Text {
                text: qsTr("Kapat")
                font.bold: true
                font.pointSize: 10
                font.family: "Tahoma"
                color: "white"
                anchors.centerIn: parent
            }
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    item.destroy()
                }
            }
        }

        Rectangle {
            anchors.fill: parent
            color: "DimGray"
            anchors.bottomMargin: 50

            Column {
                anchors.fill: parent
                Rectangle {
                    width: parent.width
                    height: itemHeight
                    color: "transparent"
                    Text {
                        id: evrakbasligi
                        text: qsTr("...")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    width: parent.width
                    height: itemHeight
                    color: "transparent"
                    Text {
                        id: evrakBirimi
                        text: qsTr("...")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    width: parent.width
                    height: itemHeight
                    color: "transparent"
                    Text {
                        id: evrakKategori
                        text: qsTr("...")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    width: parent.width
                    height: itemHeight
                    color: "transparent"
                    Text {
                        id: evrakTipi
                        text: qsTr("...")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    width: parent.width
                    height: itemHeight
                    color: "transparent"
                    Text {
                        id: evrakAnahtar
                        text: qsTr("...")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    width: parent.width
                    height: itemHeight
                    color: "transparent"
                    Text {
                        id: evrakSayi
                        text: qsTr("...")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }
                Rectangle {
                    width: parent.width
                    height: itemHeight
                    color: "transparent"
                    Text {
                        //                        id: evrakSayi
                        text: qsTr("...")
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: parent.width
                    height: parent.height - 7 * itemHeight
                    color: "white"
                    id: dosyalarid
                    ScrollView {
                        anchors.fill: parent
                        clip: true
                        Column {
                            spacing: 15
                            anchors.fill: parent
                            Repeater {
                                id: repeater
                                property var array: new Array
                                Rectangle {
                                    width: dosyalarid.width
                                    height: dosyalarid.height / 595 * 842
                                    color: "#cc000000"

                                    Image {
                                        anchors.fill: parent
                                        source: modelData["icon"]
                                        fillMode: Image.PreserveAspectFit
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                Qt.openUrlExternally(
                                                            modelData["url"])
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            Component.onCompleted: {
                var filter = QBSON.newBSON()

                filter.addOid("_id", oid)

                var evrak = db.find_one("Arsiv", filter, QBSON.newBSON())

                evrakbasligi.text = evrak.getElement("Arşiv Adı").String
                evrakBirimi.text = evrak.getElement("Birim").String
                evrakAnahtar.text = "Anahtar Kelimer: " + evrak.getElement(
                            "Anahtar Kelimeler").String
                evrakSayi.text = "Sayı: " + evrak.getElement("Sayı").Int

                filter.removeAll()

                filter.addOid("_id", evrak.getElement("tipoid").Oid)

                var tip = db.find_one("ArsivTip", filter, QBSON.newBSON())

                evrakTipi.text = "Arşiv Tipi: " + tip.getElement("adi").String

                filter.removeAll()

                filter.addOid("_id", tip.getElement("kategorioid").Oid)

                var kategori = db.find_one("ArsivKategori", filter,
                                           QBSON.newBSON())

                evrakKategori.text = "Kategori: " + kategori.getElement(
                            "kategoriAdi").String

                var list = evrak.getElement("Dosyalar").Array

                var com = Qt.createComponent("qrc:/Downloading.qml")

                if (com.status === Component.Ready) {
                    var e = com.createObject(item, {
                                                 "total": list.count
                                             })

                    e.Component.onCompleted.connect(function () {

                        delay(100, function () {

                            var array = new Array
                            for (var i = 0; i < list.count; i++) {

                                print("i. " + i)

                                e.current = i

                                var _url = db.fileurl(list.getElement(
                                                          i).Bson.getElement(
                                                          "oid").Oid)

                                var obj = {

                                }

                                obj["url"] = _url

                                var extension = _url.split('.').pop()

                                if (extension === "pdf") {
                                    obj["icon"] = "qrc:/icon/pdf.png"
                                } else if (extension === "tif"
                                           || extension === "tiff") {
                                    obj["icon"] = "qrc:/icon/tif.png"
                                } else if (extension === "xls"
                                           || extension === "xlsx") {
                                    obj["icon"] = "qrc:/icon/xls.png"
                                } else if (extension === "doc"
                                           || extension === "docx") {
                                    obj["icon"] = "qrc:/icon/doc.png"
                                }else {
                                    obj["icon"] = _url
                                }
                                array[i] = obj
                            }
                            repeater.model = array
                            e.destroy()
                        })
                    })
                } else {
                    print("Compoınent Not Ready")
                }
            }
        }
    }

    Timer {
        id: timer
    }
    function delay(delayTime, cb) {
        timer.interval = delayTime
        timer.repeat = false
        timer.triggered.connect(cb)
        timer.start()
    }
}
