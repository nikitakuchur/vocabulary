import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import Style 1.0
import Units 1.0

Controls.Page {
    Controls.Label {
        text: qsTr("About")
        font.pixelSize: Style.font.size
        padding: Units.dp(16)
    }
}
