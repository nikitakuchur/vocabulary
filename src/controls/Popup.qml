import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import Style 1.0

Controls.Popup {
    id: dialog
    anchors.centerIn: parent
    modal: true
    background: Rectangle {
        radius: Style.rectangle.radius
    }
}
