import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Layouts 1.12
import Units 1.0
import Style 1.0
import "../controls"

Controls.Page {
    id: root

    Flickable {
        anchors.fill: parent
        contentHeight: column.height + parent.height / 2
        Controls.ScrollBar.vertical: Controls.ScrollBar { }

        Column {
            id: column

            Text {
                text: qsTr("Expression")
                font.pixelSize: Style.smallFont.size
                color: Style.smallFont.color
                padding: Units.dp(16)
                bottomPadding: 0
            }

            Text {
                width: root.width
                text: expression
                font.pixelSize: Style.font.size
                wrapMode: Text.Wrap
                padding: Units.dp(16)
            }

            Line { width: root.width }

            Text {
                text: qsTr("Meaning")
                font.pixelSize: Style.smallFont.size
                color: Style.smallFont.color
                padding: Units.dp(16)
                bottomPadding: 0
            }

            Repeater {
                model: meanings
                Row {
                    Text {
                        id: dot
                        text: "•"
                        font.pixelSize: Style.font.size
                        visible: meanings.count > 1
                        topPadding: Units.dp(16)
                        leftPadding: Units.dp(16)
                    }
                    Text {
                        text: modelData
                        font.pixelSize: Style.font.size
                        wrapMode: Text.Wrap
                        width: root.width - Units.dp(16)
                        padding: Units.dp(16)
                        bottomPadding: 0
                    }
                }
            }
        }
    }
    RoundButton {
        icon.source: "../icons/edit.svg"
        icon.color: "white"

        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }

        onClicked: {
            stack.push(editItemPage);
        }
    }

    EditItemPage {
        id: editItemPage
        visible: false
    }
}
