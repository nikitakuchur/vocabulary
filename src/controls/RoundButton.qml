import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import Style 1.0

Controls.Button {
    property color defaultColor: Material.color(Material.Blue)

    id: root
    width: Style.roundButton.width
    height: Style.roundButton.width

    background: Rectangle {
        id: background
        color: parent.pressed ?
                   Qt.rgba(defaultColor.r - 0.1, defaultColor.g - 0.1, defaultColor.b - 0.1, 1) :
                   defaultColor
        radius: root.height / 2
        width: root.height
        height: root.height
    }
}
