import QtQuick 2.0

Item {
    property var param
    property var lockValues: ["LOCK"]
    property alias label: widgetLabel.text
    property alias showLabel: widgetLabel.visible
    property string _value: "disabled"

    WidgetLabel {
        id: widgetLabel
        x: 0; y: -15
        width: 53
        horizontalAlignment: Text.AlignHCenter
        visible: true
        text: ""
    }

    Image{
        source:"images/widget_lock_"+_value+".png"
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
        if(!param.engValidity)
            _value = "disabled";
        else {
            var valUpper = param.engValue.trim().toUpperCase();
            if(lockValues.indexOf(valUpper) > -1)
                _value = "lock"
            else
                _value = "unlock"
        }
    }

}
