import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import Units 1.0
import Style 1.0
import "controls"
import "pages"
import "utils/Database.js" as DB

Controls.ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 640
    title: qsTr("Vocabulary")
    header: Controls.ToolBar {
        id: toolBar
        height: Style.toolBar.height
        Material.background: Material.Red
        Row {
            anchors.fill: parent
            Controls.ToolButton {
                text: stack.currentItem == mainPage ? "⋮" : "‹"
                font.pixelSize: Units.dp(32)
                height: toolBar.height
                width: height
                onClicked: stack.pop()
            }
        }
    }
    Controls.StackView {
        id: stack
        initialItem: mainPage
        anchors.fill: parent
    }
    MainPage {
        id: mainPage
    }
    onClosing: {
        if (stack.depth > 1) {
            close.accepted = false;
            stack.pop();
        }
    }
    Component.onCompleted: DB.init()
}
