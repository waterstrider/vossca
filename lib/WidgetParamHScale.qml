import QtQuick 2.0

Item {
    property var param
    property double min: 0.0
    property double max: 1.0
    property alias label: widgetLabel.text
    property alias showLabel: widgetLabel.visible
    property double _value: min

    Image {
        x: 0; y: 0
        clip: true
        width: 125*((_value-min)/(max-min))+3
        height: 15
        Image {
            id: imgScale
            x:1; y:1
            source:"images/widget_hscale.png"
        }
    }
    Image {
        id: imgBorder
        source:"images/widget_hscale_border.png"
    }
    Image {
        x: imgBorder.width*((_value-min)/(max-min))
        y: 18
        source:"images/arrow_yellow.png"
        visible: param.engValidity
    }
    WidgetLabel {
        id: widgetLabel
        x: 0; y: -19
        width: 125; height: 15
        font.pixelSize: 13
        horizontalAlignment: Text.AlignHCenter
        visible: true
        text: ""
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
            _value = min;
        else
            _value = Number(param.engValue);
    }
}
