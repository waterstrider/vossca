import QtQuick 2.0

Item {

    property var param
    property int textSize: 22
    property color textColor: "#DDDDDD"
    property var statusColors: {"":"gray", "NORMAL":"blue", "NOT_NORMAL":"orange", "OUT_OF_RANGE":"red" }
    property int precision: 0
    property double min: 0
    property double max: 1
    property double minNorm: 0
    property double maxNorm: 1
    property string _value: ""
    Image {
        x: 5; y: -64
        source:"images/widget_circle.png"
    }
    WidgetLabel {
        x: -21; y: 49
        width: 113; height: 15
        font.pixelSize: textSize
        font.family: "Digital-7"
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
        if(!param.engValidity || isNaN(param.engValue))
            _value = "";
        else
            _value = Number(param.engValue).toFixed(precision);
    }

}
