import QtQuick 2.12
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

ListView {
        property color defaultColor: "white"

    id: root
    anchors.fill: parent

    delegate: Item {
        id: item
        width: root.width
        height: Style.listView.itemHeight

        Line {
            width: parent.width
            anchors.bottom: parent.top
        }

        Rectangle {
            anchors.fill: parent
            color: mouseArea.pressed ? Qt.rgba(defaultColor.r - 0.1, defaultColor.g - 0.1, defaultColor.b - 0.1, 1) :
                                       defaultColor
        }

        Row {
            anchors.verticalCenter: parent.verticalCenter

            Text {
                width: 0.5 * item.width
                font.pixelSize: Style.font.size
                text: expression
                elide: Text.ElideRight
                leftPadding: Units.dp(16)
            }

            Text {
                id: meaningText
                width: 0.5 * item.width
                font.pixelSize: Style.font.size
                text: meanings.count > 0 ? meanings.get(0).meaning : ""
                elide: Text.ElideRight
                leftPadding: Units.dp(16)
            }
        }

        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                stack.push(itemPage);
            }
        }

        ItemPage {
            id: itemPage
            visible: false
        }
    }
}
