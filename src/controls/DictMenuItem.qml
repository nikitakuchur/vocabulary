import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import Units 1.0
import Style 1.0

Controls.MenuItem {
    font.pixelSize: Style.font.size
    height: Style.listView.itemHeight
    leftPadding: Units.dp(16)

    background: Rectangle {
        anchors.fill: parent
        color: pressed ? "#e6e6e6" : "white"
    }
}
