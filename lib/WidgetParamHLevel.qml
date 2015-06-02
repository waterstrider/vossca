import QtQuick 2.0

Item {
    property var param
    property double _value: 0.5
    property double min: 0.0
    property double max: 1.0
    Image {
        source:"images/widget_hlevel_off.png"
    }

    Item {
        x:0; y: 0
        width: 110*((Math.min(_value,max)-min)/(max-min))
        height: 15
        transformOrigin: Item.Center
        clip: true

        Image {
            x: 0; y: 0
            anchors.right: parent.right
            anchors.rightMargin: -55
            sourceSize.width: 122
            source:"images/widget_hlevel_on.png"
        }
    }
    Image {
        y:3
        x:110*((Math.min(_value,max)-min)/(max-min))-5
        source:"images/widget_hlevel_arrow.png"
        visible: param.engValidity
    }
    Component.onCompleted: {
        updateValue();
    }
    onParamChanged: {
        param.nameChanged.connect(updateValue);
        param.engValidityChanged.connect(updateValue);
        param.engValueChanged.connect(updateValue);
    }
    function updateValue() {
        if(!param.engValidity || isNaN(param.engValue))
            _value = 0;
        else
            _value = Number(param.engValue);
    }
}
