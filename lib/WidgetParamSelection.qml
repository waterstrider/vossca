import QtQuick 2.0

Item {
    property var param
    property var leftValues: ["ON"]
    property var rightValues: ["OFF"]
    property alias label: widgetLabel.text
    property alias showLabel: widgetLabel.visible

    Image {
        id: imageLeft
        x: 0; y: 0
        source:"images/widget_selection_off.png"
    }
    Image {
        id: imageRight
        x: 36; y: 0
        source:"images/widget_selection_off.png"
    }
    WidgetLabel {
        id: widgetLabel
        x: 1; y: -15
        width: 66; height: 13
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
        if(!param.engValidity) {
            imageLeft.source = "images/widget_selection_off.png";
            imageRight.source = "images/widget_selection_off.png";
        } else {
            var valUpper = param.engValue.trim().toUpperCase();

            if(leftValues.indexOf(valUpper)>-1)
                imageLeft.source = "images/widget_selection_on_l.png"
            else
                imageLeft.source = "images/widget_selection_off.png";

            if(rightValues.indexOf(valUpper)>-1)
                imageRight.source = "images/widget_selection_on_r.png"
            else
                imageRight.source = "images/widget_selection_off.png";
        }

    }
}
