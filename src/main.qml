import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "controls"
import "views"
import "utils/Database.js" as DB

Controls.ApplicationWindow {
    id: window
    visible: true
    width: 1080 / 3
    height: 1920 / 3
    title: qsTr("Vocabulary")
    header: Controls.ToolBar {
        id: toolBar
        height: Style.toolBar.height
        Row {
            anchors.fill: parent
            Controls.ToolButton {
                text: stack.currentItem == mainView ? "⋮" : "‹"
                font.pixelSize: Units.dp(32)
                height: toolBar.height
                width: height
                onClicked: stack.pop()
            }
        }
    }
    Controls.StackView {
        id: stack
        initialItem: mainView
        anchors.fill: parent
    }
    MainView {
        id: mainView
    }
    ItemView {
        id: itemView
        visible: false
    }
    EditItemView {
        id: editItemView
        visible: false
    }
    onClosing: {
        if (stack.currentItem != mainView) {
            close.accepted = false
            stack.pop()
        }
    }
    Component.onCompleted: DB.init()
}
