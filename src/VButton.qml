import QtQuick 2.13
import QtQuick.Controls 2.12

Button {
    id: root
    property real backgroundRadius: 8
    width: 40
    height: 20
    contentItem: Text {
        font.pixelSize: 0.4 * root.height
        color: "white"
        text: root.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: root.horizontalCenter
        anchors.verticalCenter: root.verticalCenter
    }
    background: Rectangle {
        id: background
        color: parent.pressed ?  "#008dbe" : "#2eaadc"
        radius: backgroundRadius
    }
}
