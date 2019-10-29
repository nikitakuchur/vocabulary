import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import Style 1.0

Controls.TextField {
    font.pixelSize: Style.font.size
    height: Style.textField.height
    background: Rectangle {
        radius: Style.rectangle.radius
        color: Style.textField.color
        border.color: Style.textField.borderColor
        border.width: 1
    }
}
