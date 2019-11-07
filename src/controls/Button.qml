import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import Style 1.0

Controls.Button {
    property alias fontSize: content.font.pixelSize
    property alias radius: background.radius
    property color defaultColor: Material.color(Material.Blue)

    id: root
    height: Style.button.height

    contentItem: Text {
        id: content
        color: "white"
        font.pixelSize: Style.font.size
        text: root.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: root.horizontalCenter
        anchors.verticalCenter: root.verticalCenter
    }

    background: Rectangle {
        id: background
        color: parent.pressed ?
                   Qt.rgba(defaultColor.r - 0.1, defaultColor.g - 0.1, defaultColor.b - 0.1, 1) :
                   defaultColor
        radius: Style.rectangle.radius
    }
}
