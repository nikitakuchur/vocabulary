import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.LocalStorage 2.12
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
        Row {
            anchors.fill: parent
            Controls.ToolButton {
                text: stack.depth > 1 ? "‹" : "⋮"
                font.pixelSize: Units.dp(32)
                height: toolBar.height
                width: height
                onClicked: {
                    if (stack.depth > 1) {
                        stack.pop()
                    } else {
                        drawer.open()
                    }
                }
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

    Controls.Drawer {
        id: drawer
        width: Math.min(window.width, window.height) / 3 * 2
        height: window.height
        interactive: stack.depth === 1

        ListView {
            id: listView

            focus: true
            currentIndex: -1
            anchors.fill: parent

            delegate: Controls.ItemDelegate {
                width: parent.width
                text: model.title
                font.pixelSize: Style.font.size
                highlighted: ListView.isCurrentItem
                onClicked: {
                    listView.currentIndex = index;
                    //stack.push(model.source);
                    drawer.close();
                }
            }

            model: ListModel {
                ListElement { title: "Dictionary"; source: "" }
                ListElement { title: "Quizzes"; source: "" }
                ListElement { title: "About"; source: "" }
            }

            Controls.ScrollIndicator.vertical: Controls.ScrollIndicator { }
        }
    }

    onClosing: {
        if (stack.depth > 1) {
            close.accepted = false;
            stack.pop();
        }
    }

    Component.onCompleted: DB.init()
}
