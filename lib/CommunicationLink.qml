import QtQuick 2.0

Rectangle {
    color: "transparent"
    WidgetLabelUI {
        text: "COMMUNICATION LINK"
    }
    WidgetLabelUI {
        y: 29.729
        text: "TC"
    }
    Row {
        y: 29.729
        x: 68.421
        spacing: 2
        WidgetButton {
            width: 80.248
            height: 29.346
            label: "OPEN"
            fontSize: 14
        }
        WidgetButton {
            width: 80.248
            height: 29.346
            label: "CLOSE"
            fontSize: 14
        }
        WidgetButton {
            width: 80.248
            height: 29.346
            label: "CHECK"
            fontSize: 14
        }
    }
    WidgetLabelUI {
        y: 65.179
        text: "TM"
    }
    Row {
        y: 65.179
        x: 68.421
        spacing: 2
        WidgetButton {
            width: 80.248
            height: 29.346
            label: "OPEN"
            fontSize: 14
        }
        WidgetButton {
            width: 80.248
            height: 29.346
            label: "CLOSE"
            fontSize: 14
        }
        WidgetButton {
            width: 80.248
            height: 29.346
            label: "CHECK"
            fontSize: 14
        }
    }
    WidgetLabelUI {
        y: 101.628
        text: "TMR"
    }
    Row {
        y: 101.628
        x: 68.421
        spacing: 2
        WidgetButton {
            width: 80.248
            height: 29.346
            label: "OPEN"
            fontSize: 14
        }
        WidgetButton {
            width: 80.248
            height: 29.346
            label: "CLOSE"
            fontSize: 14
        }
        WidgetButton {
            width: 80.248
            height: 29.346
            label: "CHECK"
            fontSize: 14
        }
    }
}
