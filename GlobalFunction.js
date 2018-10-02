.pragma library



function uyari(mesaj){

    var component = Qt.createComponent("qrc:/Uyari.qml");

    if( component.status === Component.Ready )
    {
        var e = component.createObject(mainrect,{"mesaj":mesaj});
    }
}

function responsive( totalwidth , width )
{
    var mod = totalwidth / width;
    var ouput = width + ( mod - Math.floor(mod) ) * width / Math.floor(mod);
    return ouput;
}
