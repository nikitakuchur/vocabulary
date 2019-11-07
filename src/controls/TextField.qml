import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import Style 1.0

Controls.TextField {
    font.pixelSize: Style.font.size

    background: Rectangle {
        radius: Style.rectangle.radius
        color: Material.color(Material.Grey, Material.Shade100)
        border.color: Material.color(Material.Grey, Material.Shade300)
        border.width: 1
    }
}
