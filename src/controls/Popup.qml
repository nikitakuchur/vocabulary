import QtQuick 2.13
import QtQuick.Controls 2.13 as Controls
import Style 1.0

Controls.Popup {
    id: dialog
    anchors.centerIn: parent
    modal: true
    background: Rectangle {
        radius: Style.rectangle.radius
    }
}
