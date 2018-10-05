import QtQuick 2.11
import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0

import com.mongodb 0.7

import "qrc:/GlobalFunction.js" as Global

Item {

    anchors.fill: parent
    id: item

    property int limit: 21
    property int itemcount: 0

    Rectangle {
        anchors.fill: parent
        color: "orange"

        Rectangle {
            id: searchCriteriaid
            width: parent.width
            height: 150
            color: "purple"
            Column {
                anchors.fill: parent

                Rectangle {
                    width: parent.width
                    height: 50
                    Row {
                        anchors.fill: parent
                        Rectangle {
                            width: parent.width / 2
                            height: 50
                            border.width: 1
                            border.color: "black"
                            TextInput {
                                id: arsivadiinput
                                width: parent.width
                                height: parent.height
                                color: "black"
                                horizontalAlignment: TextInput.AlignHCenter
                                verticalAlignment: TextInput.AlignVCenter
                                font.bold: true
                                font.family: "Tahoma"
                                font.pointSize: 10
                                Text {
                                    text: qsTr("Arşiv Adı Giriniz")
                                    color: "#BBBBBB"
                                    font.bold: true
                                    font.family: "Tahoma"
                                    font.pointSize: 10
                                    anchors.centerIn: parent
                                    visible: !parent.text
                                }
                            }
                        }
                        Rectangle {
                            width: parent.width / 2
                            height: 50
                            border.width: 1
                            border.color: "black"
                            TextInput {
                                id: anahtarkelimeinput
                                width: parent.width
                                height: parent.height
                                color: "black"
                                horizontalAlignment: TextInput.AlignHCenter
                                verticalAlignment: TextInput.AlignVCenter
                                font.bold: true
                                font.family: "Tahoma"
                                font.pointSize: 10
                                Text {
                                    text: qsTr("Anahtar Kelime Giriniz")
                                    color: "#BBBBBB"
                                    font.bold: true
                                    font.family: "Tahoma"
                                    font.pointSize: 10
                                    anchors.centerIn: parent
                                    visible: !parent.text
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    Row {
                        anchors.fill: parent
                        Rectangle {
                            width: parent.width / 2
                            height: 50
                            border.width: 1
                            border.color: "black"
                            TextInput {
                                id: sayiinput
                                width: parent.width
                                height: parent.height
                                color: "black"
                                horizontalAlignment: TextInput.AlignHCenter
                                verticalAlignment: TextInput.AlignVCenter
                                font.bold: true
                                font.family: "Tahoma"
                                font.pointSize: 10
                                validator: IntValidator {
                                    bottom: 0
                                    top: 999999999
                                }
                                Text {
                                    text: qsTr("Sayı Giriniz")
                                    color: "#BBBBBB"
                                    font.bold: true
                                    font.family: "Tahoma"
                                    font.pointSize: 10
                                    anchors.centerIn: parent
                                    visible: !parent.text
                                }
                            }
                        }
                        Rectangle {
                            width: parent.width / 2
                            height: 50
                            border.width: 1
                            border.color: "black"
                            TextInput {
                                width: parent.width
                                height: parent.height
                                color: "black"
                                horizontalAlignment: TextInput.AlignHCenter
                                verticalAlignment: TextInput.AlignVCenter
                                font.bold: true
                                font.family: "Tahoma"
                                font.pointSize: 10
                                Text {
                                    text: qsTr("Açıklama İçinde Kelime Giriniz")
                                    color: "#BBBBBB"
                                    font.bold: true
                                    font.family: "Tahoma"
                                    font.pointSize: 10
                                    anchors.centerIn: parent
                                    visible: !parent.text
                                }
                            }
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    Row {
                        anchors.fill: parent
                        Rectangle {
                            id: araRect
                            width: parent.width / 2
                            height: 50
                            color: "DarkSlateGray"
                            Text {
                                id: araText
                                text: qsTr("Ara")
                                font.bold: true
                                font.pointSize: 11
                                font.family: "Tahoma"
                                color: "white"
                                anchors.centerIn: parent
                            }
                            MouseArea {
                                anchors.fill: parent
                                onPressed: {
                                    araText.color = "black"
                                    araRect.color = "white"
                                }
                                onReleased: {
                                    araText.color = "white"
                                    araRect.color = "DarkSlateGray"
                                    pageid.model = ["0"]
                                    loadArsiv()
                                }
                            }
                        }
                        Rectangle {
                            width: parent.width / 4
                            height: 50
                            color: "DeepPink"
                            ComboBox {
                                id: pageid
                                anchors.fill: parent
                                Component.onCompleted: {
                                    model = ["0"]
                                }
                                onCurrentIndexChanged: {
                                    loadArsiv()
                                }
                            }
                        }
                        Rectangle {
                            width: parent.width / 4
                            height: 50
                            color: "DeepPink"
                            Rectangle {
                                width: parent.width
                                height: parent.height
                                Row {
                                    anchors.fill: parent
                                    Rectangle {
                                        width: parent.width / 2
                                        height: 50
                                        color: "DarkSlateBlue"
                                        Text {
                                            text: qsTr("<")
                                            font.bold: true
                                            font.pointSize: 14
                                            color: "white"
                                            anchors.centerIn: parent
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                if (pageid.currentIndex > 0) {
                                                    pageid.currentIndex-- // This is available in all editors.
                                                    loadArsiv()
                                                }
                                            }
                                        }
                                    }
                                    Rectangle {
                                        width: parent.width / 2
                                        height: 50
                                        color: "DarkSlateBlue"
                                        Text {
                                            text: qsTr(">")
                                            font.bold: true
                                            font.pointSize: 14
                                            color: "white"
                                            anchors.centerIn: parent //itemcount
                                        }
                                        MouseArea {
                                            anchors.fill: parent
                                            onClicked: {
                                                //                                                print( itemcount/limit + " - " + pageid.currentIndex );
                                                if (pageid.currentIndex < (itemcount / limit - 1)) {
                                                    pageid.currentIndex++ // This is available in all editors.
                                                    loadArsiv()
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            width: parent.width
            height: parent.height - searchCriteriaid.height
            anchors.top: searchCriteriaid.bottom
            color: "gray"

            ScrollView {
                width: parent.width
                height: parent.height
                clip: true
                Component.onCompleted: {
                    print("sWidth: " + width)
                }

                onWidthChanged: {
                    flow.width = width
                }

                Flow {
                    id: flow
                    width: parent.width
                    property int validWidth: 250
                    onWidthChanged: {

                        if (width > validWidth) {
                            repeater.itemwidth = Global.responsive(width,
                                                                   validWidth)
                        } else {
                            repeater.width = width
                        }
                    }

                    Repeater {
                        id: repeater
                        property int itemwidth: validWidth

                        Rectangle {
                            width: repeater.itemwidth
                            height: 120
                            color: "transparent"

                            Rectangle {
                                id: itemrect
                                width: parent.width - 10
                                height: parent.height - 10
                                color: "LightSlateGray"
                                clip: true

                                Column {
                                    anchors.fill: parent
                                    Text {
                                        text: modelData.getElement(
                                                  "Arşiv Adı").String
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        horizontalAlignment: Text.AlignHCenter
                                        color: "white"
                                        font.pointSize: 10
                                        font.bold: true
                                    }
                                    Text {
                                        text: modelData.getElement(
                                                  "Sayı").Int + " : " + modelData.getElement(
                                                  "Dosyalar").Array.count
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        horizontalAlignment: Text.AlignHCenter
                                        color: "white"
                                        font.pointSize: 10
                                    }

                                    Text {
                                        text: modelData.getElement(
                                                  "Anahtar Kelimeler").String
                                        width: parent.width
                                        wrapMode: Text.WordWrap
                                        horizontalAlignment: Text.AlignHCenter
                                        color: "#DDDDDD"
                                        font.pointSize: 10
                                    }
                                }
                            }

                            DropShadow {
                                anchors.fill: itemrect
                                samples: 16
                                radius: 8
                                color: "black"
                                source: itemrect
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    print("OID: " + modelData.getElement(
                                              "_id").Oid)
                                    var com = Qt.createComponent(
                                                "qrc:/ArsivGoruntule.qml")

                                    if (com.status === Component.Ready) {
                                        var e = com.createObject(item, {
                                                                     "oid": modelData.getElement(
                                                                                "_id").Oid
                                                                 })
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    function loadArsiv() {

        var filter = QBSON.newBSON()

        filter.addString("Birim", user.getElement("Birimi").String)

        if (anahtarkelimeinput.text.length > 2) {

            var anahtar = QArray.newArray()

            var countCN = 0
            var cnlist = new Array

            var keywords = anahtarkelimeinput.text

            for (var ii = 0; ii < keywords.length; ii++) {
                if (keywords.charAt(ii) === "\"") {
                    var n = keywords.indexOf("\"", ii + 1)
                    if (n !== -1) {
                        var str = keywords.slice(ii + 1, n)
                        keywords = keywords.replace(str, "")
                        cnlist[countCN] = str
                        countCN++
                    }
                }
            }

            var slist = keywords.split(" ")

            for (ii = 0; ii < slist.length; ii++) {
                if (!slist[ii].includes("\"")) {
                    cnlist[countCN] = slist[ii]
                    countCN++
                }
            }

            for (ii = 0; ii < cnlist.length; ii++) {
                var reg = QBSON.newBSON()
                reg.addString("$regex", cnlist[ii])
                reg.addString("$options", "i")
                var regx = QBSON.newBSON()
                regx.addBson("Anahtar Kelimeler", reg)
                anahtar.insertBson(regx)
            }

            filter.addArray("$or", anahtar)
        }

        var sayi = parseInt(sayiinput.text)
        if (sayi) {
            filter.addInt("Sayı", sayi)
        }

        //        print( "Sayı " + parseInt(sayiinput.text));
        var regex = QBSON.newBSON()

        regex.addString("$regex", arsivadiinput.text)
        regex.addString("$options", "i")

        filter.addBson("Arşiv Adı", regex)

        itemcount = db.count("Arsiv", filter)

        var pagecount = itemcount / limit

        if (pagecount > 1) {
            var arlist = new Array
            for (var i = 0; i < pagecount; i++) {
                var bottom = i * limit
                var top = 0
                if (i == (pagecount - 1)) {
                    top = itemcount - bottom
                } else {
                    top = bottom + limit
                }

                arlist[i] = bottom + " - " + top
            }
            pageid.model = arlist
        } else {
            pageid.model = ["1 - " + itemcount]
        }

        var option = QBSON.newBSON()

        option.addInt("limit", limit)

        option.addInt("skip", limit * pageid.currentIndex)

        //        filter.print();
        repeater.model = db.find("Arsiv", filter, option)
    }
}
