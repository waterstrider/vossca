import QtQuick 2.3

Item {
    property var param
    property int textSize: 12
    property color textColor: "#202020"
    property var statusColors: {
        "" : "gray"
    }
    property alias label: widgetLabel.text
    property alias showLabel: widgetLabel.visible
    property alias labelWidth: widgetLabel.width
    property int gapWidth: 10
    property string _value: ""
    property string _bgColor: "gray"

    width: 113
    height: 15

    WidgetLabel {
        id: widgetLabel
        width: 120
        height: parent.height
        x: -(width + gapWidth)
        y: 0
        font.pixelSize: textSize
        horizontalAlignment: Text.AlignRight
        visible: true
        text: ""
    }
    Image {
        width: parent.width
        height: parent.height
        source: "images/status_bar_" + _bgColor + ".png"
    }
    WidgetLabel {
        width: parent.width
        height: parent.height
        font.pixelSize: textSize
        color: textColor
        text: _value
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
        if (!param.engValidity) {
            _value = ""
            _bgColor = statusColors[""]
        } else {
            _value = param.engValue
            var valUpper = _value.trim().toUpperCase()
            if (valUpper in statusColors)
                _bgColor = statusColors[valUpper]
            else
                _bgColor = statusColors[""]
        }
    }
}
