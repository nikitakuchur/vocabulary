import QtQuick 2.13

ListView {
    id: listView
    anchors.fill: parent
    model: VocabModel {}
    delegate: Item {
        id: item
        width: parent.width; height: listView.height / 10
        Rectangle {
            width: parent.width
            height: 1
            color: "#dfdfde"
            anchors.bottom: parent.top
        }
        Rectangle {
            width: parent.width
            height: 1
            color: "#dfdfde"
            anchors.bottom: parent.bottom
        }
        Row {
            anchors.verticalCenter: parent.verticalCenter
            Text {
                width: item.width / 2
                font.pointSize: 14
                text: expression
                elide: Text.ElideRight
                leftPadding: 16
            }
            Text {
                width: item.width / 2
                font.pointSize: 14
                text: meaning
                elide: Text.ElideRight
                leftPadding: 16
            }
        }
    }
    //highlight: Rectangle { color: "#e8e7e4" }
    focus: true
}
