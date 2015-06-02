import QtQuick 2.0

Item {
    property var param1
    property var param2
    property double min1: 0.0
    property double min2: 0.0
    property double max1: 1.0
    property double max2: 1.0
    property double _value1: 0.5
    property double _value2: 0.5
    property double _offset: 14.0/285.0 * imgScale.width

    Image {
        id: imgScale
        source:"images/widget_compare_bar.png"
        scale: 0.9

        Image {
            x: (Math.min(_value1,max1)-min1)/(max1-min1)*(parent.width - 2*_offset) + _offset - width/2
            y: 22
            source:"images/arrow_up.png"
            visible: param1.engValidity
        }
        Image {
            x: (Math.min(_value2,max2)-min2)/(max2-min2)*(parent.width - 2*_offset) + _offset - width/2
            y: 32
            source:"images/arrow_down.png"
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
