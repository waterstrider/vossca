import QtQuick 2.0

Item {
    property var param
    property double _value: 0.5
    property double min: 0.0
    property double max: 1.0
    property int precision: 0
    property alias label: widgetLabel.text
    property alias showLabel: widgetLabel.visible

    WidgetLabel {
        id: widgetLabel
        x:0; y: -10
        width: 60
        horizontalAlignment: Text.AlignHCenter
        visible: true
        text: ""
    }

    Image {
        x: 8; y: 20
        source:"images/widget_vlevel_inactive.png"
        Item {
            x: 1
            y: 165-165*((Math.min(_value,max)-min)/(max-min))
            width: img.width
            height: 165*((Math.min(_value,max)-min)/(max-min))
            clip: true
            Image {
                id: img
                y: -(165-165*((Math.min(_value,max)-min)/(max-min)))
                source : "images/widget_vlevel_active.png"
            }
        }
    }
    Image {
        x: 0; y: 67
        source : "images/widget_vlevel_circle.png"
        WidgetLabel {
            x: 6; y: 103
            width: 48; height: 34
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
            text: param.engValidity?_value.toFixed(precision):""
        }
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
