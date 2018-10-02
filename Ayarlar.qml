import QtQuick 2.11


import com.mongodb 0.7

import "qrc:/GlobalFunction.js" as Global

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

                            Row{
                                anchors.fill: parent
                                Rectangle{
                                    width: parent.width-30
                                    height: parent.height
                                    Text {
                                        text: modelData.getElement("kategoriAdi").String
                                        anchors.centerIn: parent
                                    }

                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            var filter = QBSON.newBSON();
                                            QBSON.insertOid(filter,"kategorioid",modelData.getElement("_id").Oid);
                                            repeaterTip.model = db.find("ArsivTip",filter,QBSON.newBSON());
                                            tipRect.currentKategoriOid = modelData.getElement("_id").Oid;
                                            tipTitle.text = "\"" + modelData.getElement("kategoriAdi").String +  "\" Arşiv Tipleri"
                                        }
                                    }
                                }

                                Rectangle{
                                    width: 30
                                    height: 30
                                    color: "orange"
                                    Text {
                                        text: qsTr("Sil")
                                        font.bold: true
                                        font.family: "Tahoma"
                                        font.pointSize: 10
                                        color: "DarkSlateGray"
                                        anchors.centerIn: parent
                                    }
                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {

                                            var filter = QBSON.newBSON();

                                            QBSON.insertOid(filter,"kategorioid",modelData.getElement("_id").Oid);

                                            var count = db.count("ArsivTip",filter);

                                            if( count !== 0 )
                                            {
                                                Global.uyari("Bu Kategoriye Bağlı Arşiv Tipleri Var. Önce Arşiv Tiplerini Siliniz");

                                            }else{
                                                var filter = QBSON.newBSON();

                                                QBSON.insertString(filter,"kategoriAdi",modelData.getElement("kategoriAdi").String);
                                                QBSON.insertString(filter,"birim",user.getElement("Birimi").String);

                                                if( db.delete_one("ArsivKategori",filter) )
                                                {
                                                    filter.removeAll();
                                                    QBSON.insertString(filter,"birim",user.getElement("Birimi").String);
                                                    repeater.model = db.find("ArsivKategori",filter,QBSON.newBSON());
                                                }
                                            }

                                        }
                                    }
                                }
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

                    Rectangle{
                        width: parent.width
                        height: 50
                        color: "#CC777777"
                        Text {
                            text: qsTr("Yeni Kategori Ekle")
                            font.bold: true
                            font.pointSize: 10
                            font.family: "Tahoma"
                            anchors.centerIn: parent
                            color: "white"
                        }

                        MouseArea{
                            anchors.fill: parent
                            onClicked: {
                                print( "Yeni Kategori Ekle" );
                                var component = Qt.createComponent("qrc:/YeniKategori.qml");

                                if( component.status === Component.Ready )
                                {
                                    var e = component.createObject(mainrect);

                                    e.newKategori.connect(function(newname){

                                        var insertobj = QBSON.newBSON();

                                        QBSON.insertString(insertobj,"kategoriAdi",newname);
                                        QBSON.insertString(insertobj,"birim",user.getElement("Birimi").String);

                                        if( db.insert_one("ArsivKategori",insertobj) )
                                        {
                                            var filter2 = QBSON.newBSON();
                                            QBSON.insertString(filter2,"birim",user.getElement("Birimi").String);
                                            repeater.model = db.find("ArsivKategori",filter2,QBSON.newBSON());
                                            e.destroy();
                                        }


                                    });

                                }
                            }
                        }
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
                    property string currentKategoriOid: ""
                    Column{
                        spacing: 2
                        anchors.fill: parent
                        Rectangle{
                            width: tipRect.width
                            height: 50
                            Text {
                                id: tipTitle
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
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        width: parent.width - 30
                                        height: 30
                                        Text {
                                            text: modelData.getElement("adi").String
                                            anchors.centerIn: parent
                                            color: "black"
                                        }
                                    }
                                    Rectangle{
                                        width: 30
                                        height: 30
                                        color: "DarkSlateGray"
                                        Text {
                                            text: "Sil"
                                            anchors.centerIn: parent
                                            color: "white"
                                            font.bold: true
                                            font.pointSize: 10
                                            horizontalAlignment: Text.AlignHCenter
                                        }
                                        MouseArea{
                                            anchors.fill: parent
                                            onClicked: {
                                                print( "Sil" );
                                                var filter = QBSON.newBSON();
                                                QBSON.insertOid(filter,"tipoid",modelData.getElement("_id").Oid);

                                                var count = db.count("Arsiv",filter);

                                                if( count !== 0 )
                                                {
                                                    Global.uyari("Bu Arşiv Tipi " + count + " Adet Arşivlenmiş Dosyaya Bağlı");
                                                }else{
                                                    filter.removeAll();
                                                    filter.addOid("_id",modelData.getElement("_id").Oid);
                                                    if( db.delete_one("ArsivTip",filter) )
                                                    {
                                                        Global.uyari("Arşiv Tipi Silindi");
                                                        filter.removeAll();
                                                        QBSON.insertOid(filter,"kategorioid",tipRect.currentKategoriOid);
                                                        repeaterTip.model = db.find("ArsivTip",filter,QBSON.newBSON() );

                                                    }
                                                }
                                            }
                                        }
                                    }
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
                            repeaterTip.model = db.find("ArsivTip",filter,QBSON.newBSON());
                        }

                        Rectangle{
                            width: parent.width
                            height: 50
                            color: "#666666"
                            Text {
                                text: qsTr("Yeni Tip Ekle")
                                font.bold: true
                                font.family: "Tahoma"
                                font.pointSize: 10
                                color: "white"
                                anchors.centerIn: parent
                            }
                            MouseArea{
                                anchors.fill: parent
                                onClicked: {
                                    var component = Qt.createComponent("qrc:/YeniTip.qml");

                                    if( component.status === Component.Ready )
                                    {
                                        var e = component.createObject(mainrect);

                                        e.newTip.connect(function(newtip){
                                            var obj = QBSON.newBSON();
                                            QBSON.insertString(obj,"birim",user.getElement("Birimi").String);
                                            QBSON.insertString(obj,"adi",newtip);
                                            QBSON.insertOid(obj,"kategorioid",tipRect.currentKategoriOid);
                                            if( db.insert_one("ArsivTip",obj) )
                                            {
                                                Global.uyari("Arşiv Tipi Eklendi");
                                                var filter = QBSON.newBSON();
                                                QBSON.insertOid(filter,"kategorioid",tipRect.currentKategoriOid);
                                                repeaterTip.model = db.find("ArsivTip",filter,QBSON.newBSON());
                                            }else{
                                                Global.uyari("Arşiv Tipi Eklenemedi");
                                            }

                                            e.destroy();
                                        });
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
