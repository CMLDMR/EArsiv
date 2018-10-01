import QtQuick 2.11
import com.mongodb 0.7

import QtQuick.Controls 2.2
import QtGraphicalEffects 1.0



Item {

    anchors.fill: parent

    property int currentSayfa: 0

    Rectangle{
        width: parent.width > 1024 ? 1024 : parent.width
        height: parent.height
        anchors.centerIn: parent
        color: "#55555555"
        clip: true
        Row{
            anchors.fill: parent
            spacing: 5
            Rectangle{
                id: rectangle
                width: 200
                height: parent.height
                color: "transparent"

                ScrollView{
                    width: parent.width
                    height: parent.height
                    anchors.topMargin: 65
                    anchors.top: parent.top

                    Column {

                        id: column
                        width: parent.width

                        Rectangle{
                            id: aramaYap
                            width: 200
                            height: 50
                            color: "white"
                            Text {
                                id: aramatext
                                text: qsTr("Arama")
                                font.bold: true
                                font.family: "Tahoma"
                                color: "black"
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
                                onPressed: {
                                    aramatext.color = "white";
                                    aramaYap.color = "black"
                                }
                                onReleased: {
                                    aramatext.color = "black";
                                    aramaYap.color = "white"
                                }
                            }
                        }



                        Rectangle{
                            id: yuklemeYap
                            width: parent.width
                            height: 50
                            color: "white"
                            Text {
                                id: yeniekletext
                                text: qsTr("Yeni Ekle")
                                font.bold: true
                                font.family: "Tahoma"
                                color: "black"
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
                                onPressed: {
                                    yeniekletext.color = "white";
                                    yuklemeYap.color = "black"
                                }
                                onReleased: {
                                    yeniekletext.color = "black";
                                    yuklemeYap.color = "white"
                                }
                            }
                        }




                        Rectangle{
                            id: ayarlar
                            width: parent.width
                            height: 50
                            color: "white"
                            Text {
                                id: ayarlartext
                                text: qsTr("Ayarlar")
                                font.bold: true
                                font.family: "Tahoma"
                                color: "black"
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
                                onPressed: {
                                    ayarlartext.color = "white";
                                    ayarlar.color = "black"
                                }
                                onReleased: {
                                    ayarlartext.color = "black";
                                    ayarlar.color = "white"
                                    loadAyarlar();
                                }
                            }
                        }



//                        DropShadow {
//                            anchors.fill: ayarlar
//                            horizontalOffset: 0
//                            verticalOffset: 0
//                            radius: 8.0
//                            samples: 17
//                            color: "#FF000000"
//                            source: ayarlar
//                        }




                    }

                }
            }

            Rectangle{
                id: content
                width: parent.width-200
                height: parent.height
                color: "transparent"
            }
        }
    }


    function loadAyarlar(){



        if( currentSayfa !== 1 )
        {
            for( var ii = 0 ; ii < content.children.length ; ii++ )
            {
                content.children[ii].destroy();
            }


            var component = Qt.createComponent("qrc:/Ayarlar.qml");

            if( component.status === Component.Ready )
            {
                var e = component.createObject(content);

                if( e !== null )
                {
                    currentSayfa = 1;
                }
            }
        }



    }
}
