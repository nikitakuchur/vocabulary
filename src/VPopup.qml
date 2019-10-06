import QtQuick 2.12
import QtQuick.Controls 2.12

Popup {
    id: dialog
    width: parent.width - 20
    anchors.centerIn: parent
    modal: true
    background: Rectangle {
        radius: 4
    }
}
