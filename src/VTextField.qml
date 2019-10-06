import QtQuick 2.13
import QtQuick.Controls 2.12

TextField {
    width: 40
    height: 20
    font.pixelSize: 0.4 * height
    background: Rectangle {
        radius: 8
        color: "#f7f7f5"
        border.color: "#cfcfcd"
        border.width: 1
    }
}
