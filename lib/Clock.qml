import QtQuick 2.0

Rectangle {
    id: clock
    color: "transparent"
    property int year
    property int date
    property int hours
    property int minutes
    property int seconds
    property color segmentColorC: "#7AC943"
    property color segmentOffColorC: "#2A2A20"
    property real segmentWidthC: 3
    function timeChanged() {
        Date.prototype.getDOY = function () {
            var onejan = new Date(this.getFullYear(), 0, 1)
            return Math.ceil((this - onejan) / 86400000)
        }
        var jsDate = new Date
        year = jsDate.getUTCFullYear()
        date = jsDate.getDOY()
        hours = jsDate.getUTCHours()
        minutes = jsDate.getUTCMinutes()
        seconds = jsDate.getUTCSeconds()
    }
    Timer {
        interval: 100
        running: true
        repeat: true
        onTriggered: clock.timeChanged()
    }
    WidgetLabelUI {
        x: 40
        text: "YEAR"
        color: "#3FA9F5"
    }
    WidgetLabelUI {
        x: 160
        text: "DATE"
        color: "#3FA9F5"
    }
    WidgetLabelUI {
        x: 305
        text: "UTC TIME"
        color: "#3FA9F5"
    }
    Rectangle {
        y: 25
        width: parent.width
        height: 78
        color: "transparent"
        border.color: "#66CCFF"
        LCDDisplay {
            x: 15.0
            y: 20.0
            number: year / 100
            segmentColorD: segmentColorC
            segmentOffColorD: segmentOffColorC
            segmentWidthD: segmentWidthC
            LCDDisplay {
                number: year % 100
                segmentColorD: segmentColorC
                segmentOffColorD: segmentOffColorC
                segmentWidthD: segmentWidthC
                anchors {
                    left: parent.right
                    top: parent.top
                }
            }
        }
        Seperator {
            x: 126
            y: 20
        }
        LCDDigit {
            id: dateMain
            x: 150
            y: 20.0
            number: date / 100
            width: dateSub.width / 2 - segmentWidthC
            height: dateSub.height
            segmentColor: segmentColorC
            segmentOffColor: segmentOffColorC
            segmentWidth: segmentWidthC
        }
        LCDDisplay {
            id: dateSub
            number: date % 100
            segmentColorD: segmentColorC
            segmentOffColorD: segmentOffColorC
            segmentWidthD: segmentWidthC
            anchors {
                left: dateMain.right
                top: dateMain.top
            }
        }
        Seperator {
            x: 237
            y: 20
        }
        LCDDisplay {
            x: 261
            y: 20.0
            number: hours
            segmentColorD: segmentColorC
            segmentOffColorD: segmentOffColorC
            segmentWidthD: segmentWidthC
        }
        TimeSep {
            x: 315
            y: 20
        }

        LCDDisplay {
            x: 325
            y: 20.0
            number: minutes
            segmentColorD: segmentColorC
            segmentOffColorD: segmentOffColorC
            segmentWidthD: segmentWidthC
        }
        TimeSep {
            x: 379
            y: 20
        }
        LCDDisplay {
            x: 389
            y: 20.0
            number: seconds
            segmentColorD: segmentColorC
            segmentOffColorD: segmentOffColorC
            segmentWidthD: segmentWidthC
        }
    }
}
