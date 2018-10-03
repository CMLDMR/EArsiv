import QtQuick 2.11
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.0
import QtGraphicalEffects 1.0


import com.mongodb 0.7

import com.eArsiv 1.0



Item {


    id: item

    anchors.fill: parent

    Rectangle{

        anchors.fill: parent

        color: "red"

        Rectangle{

            width: parent.width > 950 ? 950 : parent.width

            height: parent.height

            color: "orange"


            Rectangle{
                width: parent.width
                height: 150
                Column{
                    anchors.fill: parent

                    // Kategori Seçimi , Arşiv Tipi Seçimi
                    Rectangle{
                        width: parent.width
                        height: 50
                        Row{
                            anchors.fill: parent
                            Rectangle{
                                width: parent.width/2
                                height: 50
                                color: "steelblue"
                                ComboBox{
                                    id: kategori
                                    property var mlist: new Array
                                    property var mOidlist: new Array
                                    model: ["Kategori1","Kategori2","Kategori3"]
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    Component.onCompleted: {

                                        var filter = QBSON.newBSON();

                                        filter.addString("birim",user.getElement("Birimi").String);

                                        filter.print();

                                        var list = db.find("ArsivKategori",filter,QBSON.newBSON());

                                        mlist = [];
                                        mOidlist = [];

                                        for( var ii = 0 ; ii < list.length ; ii++ )
                                        {
                                            var bson = list[ii];
                                            mlist[ii] = bson.getElement("kategoriAdi").String;
                                            mOidlist[ii] = bson.getElement("_id").Oid;
                                        }

                                        model = mlist;
                                    }

                                    onCurrentIndexChanged: {
                                        var filter = QBSON.newBSON();

                                        filter.addString("birim",user.getElement("Birimi").String);

                                        filter.addOid("kategorioid",kategori.mOidlist[kategori.currentIndex]);

                                        var list = db.find( "ArsivTip" , filter , QBSON.newBSON() );

                                        var mlist = new Array;

                                        for( var ii = 0 ; ii < list.length ; ii++ )
                                        {
                                            var bson = list[ii];
                                            mlist[ii] = bson.getElement("adi").String
                                            tipi.mOidlist[ii] = bson.getElement("_id").Oid;
                                        }

                                        tipi.model = mlist;
                                    }
                                }
                            }
                            Rectangle{
                                width: parent.width/2
                                height: 50
                                color: "DarkSlateGray"
                                ComboBox{
                                    id: tipi
                                    property var mOidlist: new Array
                                    anchors.centerIn: parent
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                }
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
                                color: "LightSlateGray"
                                TextInput{
                                    id: arsivadi
                                    width: parent.width
                                    height: parent.height
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    Text {
                                        text: qsTr("Arşiv Adını Giriniz");
                                        font : parent.font
                                        color: "#CCCCCC"
                                        visible: !parent.text
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        anchors.centerIn: parent
                                    }
                                    horizontalAlignment: TextInput.AlignHCenter
                                    verticalAlignment: TextInput.AlignVCenter
                                }
                            }
                            Rectangle{
                                width: parent.width/4
                                height: 50
                                color: "CadetBlue"
                                TextInput{
                                    id: sayiid
                                    width: parent.width
                                    height: parent.height
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    Text {
                                        text: qsTr("Sayı Giriniz");
                                        font : parent.font
                                        color: "#CCCCCC"
                                        visible: !parent.text
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        anchors.centerIn: parent
                                    }
                                    horizontalAlignment: TextInput.AlignHCenter
                                    verticalAlignment: TextInput.AlignVCenter
                                    validator: IntValidator{bottom: 0 ; top: 999999;}
                                }
                            }

                            Rectangle{
                                width: parent.width/4
                                height: 50
                                color: "MediumSlateBlue"
                                TextInput{
                                    id: yilid
                                    width: parent.width
                                    height: parent.height
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    Text {
                                        text: qsTr("Evrak Yılını Giriniz");
                                        font : parent.font
                                        color: "#CCCCCC"
                                        visible: !parent.text
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        anchors.centerIn: parent
                                    }
                                    horizontalAlignment: TextInput.AlignHCenter
                                    verticalAlignment: TextInput.AlignVCenter
                                    validator: IntValidator{bottom: 0 ; top: 999999;}
                                }
                            }
                        }
                    }

                    Rectangle{
                        width: parent.width
                        height: 50
                        Row{
                            anchors.fill: parent
                            Rectangle{
                                width: parent.width
                                height: 50
                                color: "DimGray"
                                TextInput{
                                    id: anahtarkelimeid
                                    width: parent.width
                                    height: parent.height
                                    font.bold: true
                                    font.pointSize: 10
                                    font.family: "Tahoma"
                                    color: "white"
                                    Text {
                                        text: qsTr("Anahtar Kelime Giriniz ( Aralarında Boşluk Bırakınız )");
                                        font : parent.font
                                        color: "#CCCCCC"
                                        visible: !parent.text
                                        horizontalAlignment: Text.AlignHCenter
                                        verticalAlignment: Text.AlignVCenter
                                        anchors.centerIn: parent
                                    }
                                    horizontalAlignment: TextInput.AlignHCenter
                                    verticalAlignment: TextInput.AlignVCenter
                                }
                            }
                        }
                    }

                }
            }

            Rectangle{
                id: rect
                anchors.fill: parent
                anchors.topMargin: 150
                anchors.bottomMargin: 50
                color: "Gainsboro"

                ArsivModel{
                    id: itemlist
                }

                ScrollView{
                    anchors.fill: parent
                    clip: true
                    Column{
                        anchors.fill: parent
                        spacing: 1
                        Repeater{
                            id: repeter
                            model: itemlist.model

                            Rectangle{
                                width: rect.width
                                height: 75
                                color: "LightSlateGray"
                                Row{
                                    anchors.fill: parent
                                    Rectangle{
                                        width: 75
                                        height: 75
                                        color: "orange"
                                        Text {
                                            id: indexText
                                            text: index
                                            anchors.centerIn: parent
                                            color: "black"
                                            font.bold: true
                                            font.pointSize: 10
                                            font.family: "Tahoma"
                                        }
                                    }

                                    Rectangle{
                                        width: rect.width-150
                                        height: 75
                                        color: "LightGray"
                                        clip: true
                                        Text {
                                            text: modelData
                                            font.bold: true
                                            font.family: "Tahoma"
                                            font.pointSize: 10
                                            color: "white"
                                            anchors.centerIn: parent
                                            width: parent.width
                                            wrapMode: Text.WordWrap
                                            horizontalAlignment: Text.AlignHCenter
                                            verticalAlignment: Text.AlignVCenter
                                        }
                                    }

//                                    Rectangle{
//                                        width: 75
//                                        height: 75
//                                        color: "ForestGreen"
//                                        Text {
//                                            text: qsTr("Ekle")
//                                            font.bold: true
//                                            font.family: "Tahoma"
//                                            font.pointSize: 10
//                                            color: "white"
//                                            anchors.centerIn: parent

//                                        }

//                                        FileDialog{
//                                            id: fileDialog
//                                                title: "Dosya Seç"
//                                                folder: shortcuts.home
//                                                onAccepted: {
//                                                    itemlist.addFile(fileDialog.fileUrl);
//                                                }
//                                                onRejected: {

//                                                }
//                                        }

//                                        MouseArea{
//                                            anchors.fill: parent
//                                            onClicked: {
//                                                fileDialog.open();
//                                            }
//                                        }
//                                    }

                                    Rectangle{
                                        width: 75
                                        height: 75
                                        color: "FireBrick"
                                        Text {
                                            text: qsTr("Sil")
                                            font.bold: true
                                            font.family: "Tahoma"
                                            font.pointSize: 10
                                            color: "white"
                                            anchors.centerIn: parent
                                        }
                                        MouseArea{
                                            anchors.fill: parent
                                            onClicked: {
                                                itemlist.remove(index);
                                            }
                                        }
                                    }
                                }


                            }
                        }

                        Rectangle{
                            width: rect.width
                            height: 75
                            color: "LightSlateGray"
                            Row{
                                anchors.fill: parent
                                Rectangle{
                                    width: rect.width
                                    height: 75
                                    color: "orange"
                                    Text {
                                        text: "Yeni Ekle"
                                        anchors.centerIn: parent
                                        color: "black"
                                        font.bold: true
                                        font.pointSize: 10
                                        font.family: "Tahoma"
                                    }
                                    FileDialog{
                                        id: fileDialog
                                            title: "Dosya Seç"
                                            folder: shortcuts.home
                                            selectMultiple: true
                                            nameFilters: [ "Resim (*.jpeg *.jpg *.png)", "PDF (*.pdf)" ]
                                            onAccepted: {
                                                for( var i = 0 ; i < fileDialog.fileUrls.length ; i++ )
                                                {
                                                    itemlist.addFile(fileDialog.fileUrls[i]);
                                                }
                                            }
                                            onRejected: {

                                            }
                                    }

                                    MouseArea{
                                        anchors.fill: parent
                                        onClicked: {
                                            fileDialog.open();
                                        }
                                    }
                                }

                            }


                        }

                    }
                }
            }


            Rectangle{
                width: parent.width
                height: 50
                color: "DarkSlateGray"
                anchors.bottom: parent.bottom
                Text {
                    text: qsTr("Kaydet")
                    font.bold: true
                    font.family: "Tahoma"
                    font.pointSize: 10
                    color: "white"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.centerIn: parent
                }
                MouseArea{
                    anchors.fill: parent
                    onClicked: {
                        if( tipi.currentText.length === 0 )
                        {
                            mesaj( " Arşiv Tipini Seçmediniz " );
                            return;
                        }

                        if( arsivadi.text.length === 0 )
                        {
                            mesaj(" Arşiv Adını Girmediniz ");
                            return;
                        }

                        if( anahtarkelimeid.text.length === 0 )
                        {
                            mesaj(" Anahtar Kelime Girilmesi Zorunlu ");
                            return;
                        }

                        if( itemlist.model.length === 0 )
                        {
                            mesaj(" Hiç Bir Dosya Seçmediniz ");
                            return;
                        }


                        var filearray = QArray.newArray();

                        var file = QBSON.newBSON();
                        for( var i = 0 ; i < itemlist.model.length ; i++ ){
                            file.removeAll();
                            QBSON.insertString(file,"adi",itemlist.filename(i));
                            if( itemlist.isPDF(i) )
                            {
                                QBSON.insertOid(file,"iconoid","5bb4c097e04f292980fd28f8");
                            }else{
                                QBSON.insertOid(file,"iconoid","5bb4c08ce04f292980fd28f6");
                            }
                            var e = db.uploadfile( itemlist.model[i] , itemlist.filename(i));
                            QBSON.insertOid(file,"oid",e.Oid);
                            filearray.insertBson(file)
                        }



                        var evrak = QBSON.newBSON();

                        QBSON.insertString( evrak , "Anahtar Kelimeler" , anahtarkelimeid.text );
                        QBSON.insertString( evrak , "Arşiv Adı" , arsivadi.text );
                        QBSON.insertString( evrak , "Birim" , user.getElement("Birimi").String );
                        QBSON.insertInt( evrak , "Sayı" , parseInt(sayiid.text) );
                        QBSON.insertOid( evrak , "tipoid" , tipi.mOidlist[tipi.currentIndex] );
                        QBSON.insertArray( evrak , "Dosyalar" , filearray );

                        if( db.insert_one("Arsiv",evrak) ){
                            mesaj("Dosya Kayıt Edildi");
                        }else{
                            mesaj("Dosya Arşive Kayıt Edilemedi");
                        }


                    }
                }
            }

        }
    }




    Rectangle{
        id: mesajrect
        width: parent.width
        height: parent.height
        color: "#CC000000"
        scale: 0.0
        anchors.centerIn: parent
        Rectangle{
            id: mrect
            width: parent.width > 600 ? 600 : parent.width
            height: 100
            anchors.centerIn: parent
            color: "MediumPurple"

            Column{
                anchors.fill: parent
                Rectangle{
                    width: parent.width
                    height: 50
                    color: "transparent"
                    Text {
                        id: mesajid
                        text: ""
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "white"
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors.centerIn: parent
                        horizontalAlignment: Text.AlignHCenter
                    }
                }



                Rectangle{
                    width: parent.width
                    height: 50
                    Text {
                        text: "Tamam"
                        font.bold: true
                        font.pointSize: 10
                        font.family: "Tahoma"
                        color: "black"
                        anchors.centerIn: parent
                    }
                    MouseArea{
                        anchors.fill: parent
                        onClicked: {
                            mesajrect.visible = false;
                        }
                    }
                }
            }


        }
    }




    PropertyAnimation{
        id: openmesaj
        target: mesajrect
        property: "scale"
        to: 1.0
        duration: 250
    }

    function mesaj(mesajtext){
        mesajrect.scale = 0.0
        mesajrect.visible = true;
        mesajid.text = mesajtext;
        openmesaj.start();
    }


}
