import QtQuick 2.13
import QtQuick.Controls 2.12

Button {
    property real backgroundRadius: 4
    contentItem: Text {
        font.pointSize: 14
        color: "white"
        text: parent.text
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
    }
    background: Rectangle {
        color: parent.pressed ?  "#008dbe" : "#2eaadc"
        radius: backgroundRadius
    }
}
