import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import Style 1.0

Controls.Button {
    id: root
    property int fontSize: Style.font.size
    property real backgroundRadius: Style.rectangle.radius
    contentItem: Text {
        font.pixelSize: fontSize
        color: Style.button.textColor
        text: root.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: root.horizontalCenter
        anchors.verticalCenter: root.verticalCenter
    }
    background: Rectangle {
        id: background
        color: parent.pressed ? Style.button.pressedColor : Style.button.color
        radius: backgroundRadius
    }
}
