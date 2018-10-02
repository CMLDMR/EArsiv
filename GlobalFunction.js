.pragma library



function uyari(mesaj){

    var component = Qt.createComponent("qrc:/Uyari.qml");

    if( component.status === Component.Ready )
    {
        var e = component.createObject(mainrect,{"mesaj":mesaj});
    }

}
