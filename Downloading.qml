import QtQuick 2.0

Item {

    anchors.fill: parent

    property int current: 0
    property int total: 0

    Rectangle {
        width: parent.width
        height: parent.height
        color: "#CC000000"
        MouseArea {
            anchors.fill: parent
        }

        Rectangle {
            width: parent.width > 400 ? 400 : parent.width
            height: 100
            color: "transparent"
            anchors.centerIn: parent

            Column {
                anchors.fill: parent
                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DimGray"
                    Text {
                        text: qsTr("Evrak İndiriliyor " + current + "/" + total)
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        anchors.centerIn: parent
                    }
                }

                Rectangle {
                    width: parent.width
                    height: 50
                    color: "DarkSlateGray"
                    Rectangle {
                        width: parent.width * current / total
                        height: 10
                        color: "white"
                        anchors.left: parent.left
                        //                        verticalCenter: parent
                    }
                }
            }
        }
    }
}
