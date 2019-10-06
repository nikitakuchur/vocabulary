import QtQuick 2.13

ListView {
    id: root
    anchors.fill: parent
    model: VocabModel {}
    delegate: Item {
        id: item
        width: root.width; height: Math.max(root.width, root.height) / 12
        Rectangle {
            width: root.width
            height: 1
            color: "#dfdfde"
            anchors.bottom: parent.top
        }
        Rectangle {
            width: root.width
            height: 1
            color: "#dfdfde"
            anchors.bottom: parent.bottom
        }
        Row {
            anchors.verticalCenter: parent.verticalCenter
            Text {
                width: 0.5 * item.width
                font.pixelSize: 0.4 * item.height
                text: expression
                elide: Text.ElideRight
                leftPadding: 16
            }
            Text {
                width: 0.5 * item.width
                font.pixelSize: 0.4 * item.height
                text: meaning
                elide: Text.ElideRight
                leftPadding: 16
            }
        }
    }
    focus: true
}
