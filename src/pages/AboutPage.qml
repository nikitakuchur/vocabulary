import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import Style 1.0
import Units 1.0

Controls.Page {
    Flickable {
        Controls.ScrollBar.vertical: Controls.ScrollBar {}
        Column {
            spacing: Units.dp(16)
            padding: Units.dp(16)
            Text {
                text: qsTr("Vocabulary")
                font.pixelSize: Style.font.size
            }
            Text {
                text: "Version 0.9"
                font.pixelSize: Style.smallFont.size
                bottomPadding: Units.dp(16)
            }
            Text {
                text: qsTr("Author")
                font.pixelSize: Style.font.size
            }
            Text {
                text: "Nikita Kuchur"
                font.pixelSize: Style.smallFont.size
                bottomPadding: Units.dp(16)
            }
            Text {
                text: qsTr("E-mail")
                font.pixelSize: Style.font.size
            }
            Text {
                text: "nikitakuchur@gmail.com"
                font.pixelSize: Style.smallFont.size
                bottomPadding: Units.dp(16)
            }
        }
    }
}
