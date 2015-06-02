import QtQuick 2.0

Item {
    property var param
    property double _value: 0.5
    property double min: 0.0
    property double max: 1.0
    property int precision: 0

    Image {
        source:"images/widget_slevel_inactive_l.png"
        Item {
            id:leftItem
            x:(leftImage.width/2)-(leftImage.width/2)*((Math.min(_value,max)-min)/(max-min))
            clip: true
            height:leftImage.height
            width:(leftImage.width/2)*((Math.min(_value,max)-min)/(max-min))
            Image {
                id:leftImage
                x: -((leftImage.width/2)-(leftImage.width/2)*((Math.min(_value,max)-min)/(max-min)))
                source:"images/widget_slevel_active_l.png"
            }
        }
    }
    Image {
        source:"images/widget_slevel_inactive_r.png"
        Item {
            id:rightItem
            clip:true
            height:rightImage.height
            width:(rightImage.width/2)+(rightImage.width/2)*((Math.min(_value,max)-min)/(max-min))
            Image {
                id:rightImage
                source:"images/widget_slevel_active_r.png"
            }
        }
    }

    Image {
        x: 2; y: -24
        source:"images/widget_slevel_circle.png"

        WidgetLabel {
            x: 20; y: 22
            width: 82; height: 18
            color: "#FFFFFF"
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 24
            text: param.engValidity?_value.toFixed(precision):""
        }
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
            _value = 0;
        else
            _value = Number(param.engValue);
    }

}
