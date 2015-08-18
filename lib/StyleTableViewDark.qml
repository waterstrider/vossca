import QtQuick 2.3
import QtQuick.Controls.Styles 1.2

TableViewStyle {
    id: tableViewStyleDark
    backgroundColor: "#111111"
    alternateBackgroundColor: "#222222"
    textColor: "#FFFFFF"
    headerDelegate: Rectangle {
        height: textItem.implicitHeight * 1.2
        width: textItem.implicitWidth
        color: "#DDDDDD"
        Text {
            id: textItem
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: styleData.textAlignment
            anchors.leftMargin: 12
            text: styleData.value
            elide: Text.ElideRight
            color: "#000000"
        }
        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            anchors.topMargin: 1
            width: 1
            color: "#BBBBBB"
        }
    }
}
