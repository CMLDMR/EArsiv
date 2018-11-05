import QtQuick 2.9
import QtGraphicalEffects 1.0

import com.mongodb 0.7

Item {

    anchors.fill: parent
    id: item

    property QMLBSON kullanici

    signal loginSucces

    Rectangle {
        anchors.fill: parent
        color: "#88000000"

        DropShadow {
            anchors.fill: inputrectangle
            horizontalOffset: 0
            verticalOffset: 0
            radius: 8.0
            samples: 17
            color: "#80000000"
            source: inputrectangle
        }

        Rectangle {
            id: inputrectangle
            width: parent.width > 400 ? 400 : parent.width
            height: parent.height > 200 ? 200 : parent.height
            color: "#88000000"
            anchors.centerIn: parent

            Column {
                anchors.fill: parent

                Rectangle {
                    color: "gray"
                    width: parent.width
                    height: 50
                    Text {
                        text: qsTr("T.C. Serik Belediyesi E-Arşiv")
                        color: "white"
                        font.bold: false
                        font.family: "Gothic"
                        font.pointSize: 11
                        anchors.centerIn: parent
                        font.letterSpacing: 3
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkSlateGray"
                    TextInput {
                        id: telnoinput
                        width: parent.width
                        height: parent.height
                        verticalAlignment: TextInput.AlignVCenter
                        horizontalAlignment: TextInput.AlignHCenter
                        focus: true
                        font.bold: true
                        font.pointSize: 12
                        font.family: "Tahoma"
                        color: "white"
                        //                        text: "05325995488"
                        Text {
                            text: qsTr("Telefon Numarasını Giriniz ( 05321234567 )")
                            font.bold: true
                            font.pointSize: 12
                            color: "#88888888"
                            font.family: "Tahoma"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            visible: !parent.text
                            anchors.centerIn: parent
                        }
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkSlateGray"
                    TextInput {
                        id: sifreinput
                        width: parent.width
                        height: parent.height
                        verticalAlignment: TextInput.AlignVCenter
                        horizontalAlignment: TextInput.AlignHCenter
                        focus: true
                        font.bold: true
                        font.pointSize: 12
                        font.family: "Tahoma"
                        color: "white"
                        echoMode: TextInput.PasswordEchoOnEdit
                        //                        text: "mm"
                        Text {
                            text: qsTr("Şifrenizi Giriniz")
                            font.bold: true
                            font.pointSize: 12
                            color: "#88888888"
                            font.family: "Tahoma"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            visible: !parent.text
                            anchors.centerIn: parent
                        }
                    }
                }

                Rectangle {
                    color: "#1a0000"
                    width: parent.width
                    height: 50
                    Text {
                        text: qsTr("Giriş")
                        color: "white"
                        font.bold: true
                        font.family: "Tahoma"
                        font.pointSize: 11
                        anchors.centerIn: parent
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            var filter = QBSON.newBSON()

                            QBSON.insertString(filter, "telefon",
                                               telnoinput.text)
                            QBSON.insertString(filter, "password",
                                               sifreinput.text)

                            user = db.find_one("Personel", filter,
                                               QBSON.newBSON())

                            if (user.getElement(
                                        "telefon").String === telnoinput.text
                                    && user.getElement(
                                        "telefon").String.length) {
                                //                                user.print();
                                loginSucces()
                            }
                        }
                    }
                }
            }
        }
    }
}
