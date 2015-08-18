import QtQuick 2.0


//DO NOT USE THIS WIDGET!!!
Rectangle {

    property bool cornerLeft: true
    property bool cornerRight: true

    height: 200
    width: 200

    BorderImage {
        width: parent.width
        height: parent.height
        border {
            left: 10
            top: 10
            right: 10
            bottom: 2
        }
        horizontalTileMode: BorderImage.Stretch
        verticalTileMode: BorderImage.Stretch
        source: {
            if (cornerLeft && cornerRight) {
                "images/rectangles/cornered_rectangle_both_blue_40.svg"
            } else if (cornerLeft) {
                "images/rectangles/cornered_rectangle_left_blue_40.svg"
            } else if (cornerRight) {
                "images/rectangles/cornered_rectangle_right_blue_40.svg"
            } else {
                "images/rectangles/rectangle_blue_40.svg"
            }
        }
    }
}
