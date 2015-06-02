import QtQuick 2.0

Item {
    property var param
    property int textSize: 18
    property color textColor: "#DDDDDD"
    property int precision: 0
    property alias label: widgetLabel.text
    property alias showLabel: widgetLabel.visible
    property string _value: ""

    width: 84; height: 39

    WidgetLabel {
        id: widgetLabel
        x:0; y: -25
        width: parent.width; height: 15
        horizontalAlignment: Text.AlignHCenter
        visible: true
        text: ""
    }
    Image {
        source:"images/widget_border.png"
        width: parent.width; height: parent.height
    }
    WidgetLabel {
        width: parent.width; height: parent.height
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
        param.engValueChanged.connect(updateValue);
    }
    function updateValue() {
        if(!param.engValidity || isNaN(param.engValue))
            _value = "";
        else
            _value = Number(param.engValue).toFixed(precision);
    }
}







