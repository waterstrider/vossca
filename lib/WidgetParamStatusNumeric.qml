import QtQuick 2.0

Item {
    property var param
    property int textSize: 12
    property color textColor: "#101010"
    property var statusColors: {"":"gray", "NORMAL":"blue", "NOT_NORMAL":"orange", "OUT_OF_RANGE":"red" }
    property int precision: 0
    property double min: 0
    property double max: 1
    property double minNorm: 0
    property double maxNorm: 1
    property alias label: widgetLabel.text
    property alias showLabel: widgetLabel.visible
    property alias labelWidth: widgetLabel.width
    property int gapWidth: 10
    property string _value: ""
    property string _bgColor: "gray"

    width: 113; height: 15

    WidgetLabel {
        id: widgetLabel
        width: 120; height: parent.height
        x: -(width+gapWidth); y: 0
        font.pixelSize: textSize
        horizontalAlignment: Text.AlignRight
        visible: true
        text: ""
    }
    Image {
        width: parent.width; height: parent.height
        source:"images/status_bar_"+_bgColor+".png"
    }
    WidgetLabel {
        width: parent.width; height: parent.height
        font.family: "Digital-7"
        font.pixelSize: textSize * 1.4
        color: textColor
        text: _value
        horizontalAlignment: Text.AlignHCenter
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
        if(!param.engValidity || isNaN(param.engValue)) {
            _value = "";
            _bgColor = statusColors[""];
        } else {
            _value = Number(param.engValue).toFixed(precision);
            if((param.engValue < min) || (param.engValue > max))
                _bgColor = statusColors["OUT_OF_RANGE"];
            else if((param.engValue < minNorm) || (param.engValue > maxNorm))
                _bgColor = statusColors["NOT_NORMAL"];
            else
                _bgColor = statusColors["NORMAL"];
        }
    }
}

