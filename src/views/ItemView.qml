import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import Units 1.0
import Style 1.0
import "../controls"

Item {
    property string expression
    property string meaning
    id: root
    visible: true
    Column {
        Controls.Label {
            text: "Expression"
            font.pixelSize: Style.smallFont.size
            color: Style.smallFont.color
            padding: Units.dp(16)
            bottomPadding: 0
        }
        Controls.Label {
            text: expression
            font.pixelSize: Style.font.size
            padding: Units.dp(16)
        }
        Line {
            width: root.width
            color: Style.line.color
        }
        Controls.Label {
            text: "Meaning"
            font.pixelSize: Style.smallFont.size
            color: Style.smallFont.color
            padding: Units.dp(16)
            bottomPadding: 0
        }
        Controls.Label {
            text: meaning
            font.pixelSize: Style.font.size
            padding: Units.dp(16)
        }
    }
}
