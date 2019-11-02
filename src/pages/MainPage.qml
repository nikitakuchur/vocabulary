import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

Controls.Page {
    property alias model: listModel

    ListModel {
        id: listModel
        Component.onCompleted: {
            DB.readAll(listModel);
        }
    }

    MainListView {
        id: listView
        model: listModel
    }

    RoundButton {
        text: qsTr("+")
        anchors {
            right: parent.right
            bottom: parent.bottom
            rightMargin: 10
            bottomMargin: 10
        }
        onClicked: {
            stack.push(dddItemPage);
        }
    }

    AddItemPage {
        id: dddItemPage
        visible: false
    }
}
