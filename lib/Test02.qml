import QtQuick 2.0

Rectangle {
    width: 100
    height: 62
    property int ff: 5

    Text {
        property int ff: 10
        id: inner
        text: "a " + ff
    }
}
