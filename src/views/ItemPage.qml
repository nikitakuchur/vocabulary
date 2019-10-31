import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import Units 1.0
import Style 1.0
import "../controls"

Item {
    property int index
    property int id
    property string expression: ""
    property variant meanings: [""]

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
        Line { width: root.width }
        Controls.Label {
            text: "Meaning"
            font.pixelSize: Style.smallFont.size
            color: Style.smallFont.color
            padding: Units.dp(16)
            bottomPadding: 0
        }
        Repeater {
            model: meanings
            Controls.Label {
                text: meanings.length > 1 ? "•  " + modelData : modelData
                font.pixelSize: Style.font.size
                padding: Units.dp(16)
                bottomPadding: 0
            }
        }
    }
    RoundButton {
        text: qsTr("Edit")
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        onClicked: {
            stack.push(editItemView, { "index": index, "id": id, "expression": expression, "meanings": meanings })
        }
    }
}
