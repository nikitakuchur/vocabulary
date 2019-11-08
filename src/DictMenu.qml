import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "utils/Database.js" as DB
import "controls"

Controls.Menu {
    id: more
    modal: true

    DictMenuItem {
        text: qsTr("Rename")
        onClicked: editDictPopup.open()
    }

    Line {
        width: parent.width
    }

    DictMenuItem {
        text: qsTr("Delete")
        onClicked: {
            deleteDictPopup.open();
            /**/
        }
    }
}
