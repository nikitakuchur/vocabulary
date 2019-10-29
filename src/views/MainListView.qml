import QtQuick 2.12
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

ListView {
    id: root
    anchors.fill: parent
    model: ListModel {
        id: listModel
        Component.onCompleted: DB.readAll()
    }
    delegate: Item {
        id: item
        width: root.width
        height: Style.listView.itemHeight
        Line {
            width: root.width
            color: Style.listView.borderColor
            anchors.bottom: parent.top
        }
        Rectangle {
            anchors.fill: parent
            color: mouseArea.pressed ? Style.listView.pressedColor : Style.listView.color
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
                width: 0.5 * item.width
                font.pixelSize: Style.font.size
                text: meanings.get(0).meaning
                elide: Text.ElideRight
                leftPadding: Units.dp(16)
            }
        }
        MouseArea {
            id: mouseArea
            anchors.fill: parent
            onClicked: {
                stack.push(itemView, { "expression": expression, "meanings": getMeaningArray(meanings) })
            }
        }
        function getMeaningArray(meanings) {
            var array = [];
            for (var index = 0; index < meanings.count; index++) {
                array.push(meanings.get(index).meaning)
            }
            return array;
        }
    }
    focus: true
}