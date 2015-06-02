import QtQuick 2.0

Item {
    property var param1
    property var param2
    property double min1: 0.0
    property double min2: 0.0
    property double max1: 1.0
    property double max2: 1.0
    property alias label: widgetLabel.text
    property alias showLabel: widgetLabel.visible
    property double _value1: 0.5
    property double _value2: 0.5

    WidgetLabel {
        id: widgetLabel
        x:0; y: -20
        width: 102
        horizontalAlignment: Text.AlignHCenter
        visible: true
        text: ""
    }
    Image {
        source:"images/widget_vcompare.png"
        Image {
            id:left
            x: 32
            y: 100*((Math.min(_value1,max1)-min1)/(max1-min1))
            width: 12
            height: 14
            source:"images/arrow_left.png"
            visible: param1.engValidity
        }
        Image {
            id:right
            x: 61
            y: 100*((Math.min(_value2,max2)-min2)/(max2-min2))
            source:"images/arrow_right.png"
            visible: param2.engValidity
        }
    }

    Component.onCompleted: {
        updateValue1();
        updateValue2();
    }

    onParam1Changed: {
        param1.nameChanged.connect(updateValue1);
        param1.engValidityChanged.connect(updateValue1);
        param1.engValueChanged.connect(updateValue1);
    }
    function updateValue1() {
        if(!param1.engValidity || isNaN(param1.engValue))
            _value1 = 0;
        else
            _value1 = Number(param1.engValue);
    }
    onParam2Changed: {
        param2.nameChanged.connect(updateValue2);
        param2.engValidityChanged.connect(updateValue2);
        param2.engValueChanged.connect(updateValue2);
    }
    function updateValue2() {
        if(!param2.engValidity || isNaN(param2.engValue))
            _value2 = 0;
        else
            _value2 = Number(param2.engValue);
    }

}
