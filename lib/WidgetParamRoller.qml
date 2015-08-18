import QtQuick 2.3

Item {
    property var param
    property double _value: 0.5
    property double min: 0.0
    property double max: 1.0
    property int precision: 0
    property int textSize: 24
    property color textColor: "#FFFFFF"

    Image {
        x: -10
        y: 1
        rotation: 0
        source: "images/widget_roller_border.png"
        Image {
            visible: param.engValidity
            rotation: -310 + (310 * ((Math.min(_value,
                                               max) - min) / (max - min)))
            source: "images/arrows/widget_roller_arrow.png"
            Behavior on rotation {
                enabled: true
                SpringAnimation {
                    spring: 1.4
                    damping: .05
                }
            }
        }
    }
    WidgetLabel {
        x: -4
        y: 24
        width: 75
        height: 33
        font.pixelSize: textSize
        color: textColor
        text: param.engValidity ? _value.toFixed(precision) : ""
        horizontalAlignment: Text.AlignHCenter
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
        if (!param.engValidity || isNaN(param.engValue))
            _value = 0
        else
            _value = Number(param.engValue)
    }
}
