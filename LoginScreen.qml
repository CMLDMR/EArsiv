import QtQuick 2.9

Item {

    anchors.fill: parent

    Rectangle{
        anchors.fill: parent
        color: "#88000000"


        Rectangle{
            width: parent.width > 400 ? 400 : parent.width
            height: parent.height > 200 ? 200 : parent.height
            color: "#88000000"
            anchors.centerIn: parent

            Column{
                anchors.fill: parent

                Rectangle{
                    color: "gray"
                    width: parent.width
                    height: 50
                    Text {
                        text: qsTr("T.C. Serik Belediyesi E-Arşiv");
                        color: "white"
                        font.bold: false
                        font.family: "Gothic"
                        font.pointSize: 11
                        anchors.centerIn: parent
                        font.letterSpacing: 3
                    }
                }

                Rectangle{
                    width: parent.width
                    height: 50
                    color: "DarkSlateGray"
                    TextInput{
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
//                        validator: IntValidator{bottom:500000000; top:5999999999}
                        Text {
                            text: qsTr("Telefon Numarasını Giriniz ( 05321234567 )");
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

                Rectangle{
                    width: parent.width
                    height: 50
                    color: "DarkSlateGray"
                    TextInput{
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
                        Text {
                            text: qsTr("Şifrenizi Giriniz");
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

                Rectangle{
                    color: "#1a0000"
                    width: parent.width
                    height: 50
                    Text {
                        text: qsTr("Giriş");
                        color: "white"
                        font.bold: true
                        font.family: "Tahoma"
                        font.pointSize: 11
                        anchors.centerIn: parent
                    }
                }
            }
        }
    }

}
