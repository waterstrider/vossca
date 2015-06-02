import QtQuick 2.0

Item {
    property var param
    property int precision: 0
    property double min: 0
    property double max: 1
    property double minNorm: 0
    property double maxNorm: 1
    property var statusColors: {"":"gray", "NORMAL":"white", "NOT_NORMAL":"orange", "OUT_OF_RANGE":"red" }
    property string _value: ""

    WidgetLabel {
        id: widgetValue
        x: 0; y: 0
        width: 60; height: 26
        font.pixelSize: 26
        font.family: "Digital-7"
        horizontalAlignment: Text.AlignHCenter
        visible: true
        text: _value
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
        if(!param.engValidity ||isNaN(param.engValue)) {
            _value = "";
            widgetValue.color = statusColors[""];
        } else {
            _value = Number(param.engValue).toFixed(precision); 
            if((param.engValue < min) || (param.engValue > max))
                widgetValue.color = statusColors["OUT_OF_RANGE"];
            else if((param.engValue < minNorm) || (param.engValue > maxNorm))
                widgetValue.color = statusColors["NOT_NORMAL"];
            else
                widgetValue.color = statusColors["NORMAL"];
        }
    }
}
