import QtQuick 2.3

WidgetButton {
    bgColor: "transparent"
    borderColor: "#009DCC"
    textColor: "#FFFFFF"
    bgColorPressed: "#458429"
    borderColorPressed: "#458429"
    labelLeftMargin: 40
    fontBold: true
    property string imgSrc: "images/WidgetButtonArrow.png"
    property bool isArrowVisible: true

    Image {
        id: widgetImage
        x: 12
        y: 13
        source: imgSrc
        visible: isArrowVisible
    }
}
