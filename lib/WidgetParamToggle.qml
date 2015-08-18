import QtQuick 2.3

Item {
    property var param
    property var onValues: ["ON"]
    property alias label: widgetLabel.text
    property alias showLabel: widgetLabel.visible
    property string _value: "off"
    WidgetLabel {
        id: widgetLabel
        x: 0
        y: -15
        width: 64
        height: 13
        horizontalAlignment: Text.AlignHCenter
        visible: true
        text: ""
    }

    Image {
        source: "images/widget_toggle_" + _value + ".png"
    }

    Component.onCompleted: {
        updateValue()
    }

    onParamChanged: {
        param.nameChanged.connect(updateValue)
        param.engValidityChanged.connect(updateValue)
        param.engValueChanged.connect(updateValue)
    }

    function updateValue() {
        if (!param.engValidity)
            _value = "disabled"
        else {
            var valUpper = param.engValue.trim().toUpperCase()
            if (onValues.indexOf(valUpper) > -1)
                _value = "on"
            else
                _value = "off"
        }
    }
}
