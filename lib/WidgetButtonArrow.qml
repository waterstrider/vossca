import QtQuick 2.0

WidgetButton {
    bgColor: "transparent"
    borderColor: "#009DCC"
    textColor: "#FFFFFF"
    bgColorPressed: "#458429"
    borderColorPressed: "#458429"
    labelLeftMargin: 40
    fontBold: true

    Image {
        id: widgetImage
        x: 12; y: 13
        source: "images/WidgetButtonArrow.png"
    }

}
