import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import QtQuick.LocalStorage 2.12
import Units 1.0
import Style 1.0
import "../controls"
import "../utils/Database.js" as DB

EditableItemPage {
    expressionText: expression

    RoundButton {
        text: qsTr("X")
        defaultColor: Material.color(Material.Pink)

        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 10
            bottomMargin: 10
        }

        onClicked: {
            DB.deleteRow(currentDict, id);
            DB.readAll(currentDict, listModel);
            stack.pop(mainPage);
        }
    }

    onSaveButtonClicked: {
        expression = expressionText;
        var count = Math.max(meanings.count, meaningList.count);
        for (var i = 0; i < count; i++) {
            if (i < meaningList.count) {
                meanings.set(i, { meaning: meaningList.get(i).meaning });
            } else {
                meanings.remove(i);
                i--;
                count--;
            }
        }
        DB.update(currentDictId, id, expression, meanings, 0);
        stack.pop();
    }

    onVisibleChanged: {
        if (visible) {
            meaningList.clear();
            for (var i = 0; i < meanings.count; i++) {
                meaningList.append({ meaning: meanings.get(i).meaning });
            }
        }
    }
}
