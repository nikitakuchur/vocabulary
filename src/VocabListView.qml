import QtQuick 2.13
import Style 1.0

ListView {
    id: root
    anchors.fill: parent
    model: VocabModel {}
    delegate: Item {
        id: item
        width: root.width; height: Style.listView.itemHeight
        Rectangle {
            width: root.width
            height: 1
            color: Style.listView.borderColor
            anchors.bottom: parent.top
        }
        Rectangle {
            width: root.width
            height: 1
            color: Style.listView.borderColor
            anchors.bottom: parent.bottom
        }
        Row {
            anchors.verticalCenter: parent.verticalCenter
            Text {
                width: 0.5 * item.width
                font.pixelSize: Style.font.size
                text: expression
                elide: Text.ElideRight
                leftPadding: 16
            }
            Text {
                width: 0.5 * item.width
                font.pixelSize: Style.font.size
                text: meaning
                elide: Text.ElideRight
                leftPadding: 16
            }
        }
    }
    focus: true
}
