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
        icon.source: "../icons/clear.svg"
        icon.color: "white"
        defaultColor: Material.color(Material.Pink)

        anchors {
            left: parent.left
            bottom: parent.bottom
            leftMargin: 10
            bottomMargin: 10
        }

        onClicked: {
            DB.deleteRow(dictList.get(currentDictIndex).id, id);
            DB.readAll(dictList.get(currentDictIndex).id, listModel);
            stack.pop(dictPage);
        }
    }

    onSaveButtonClicked: {
        expression = expressionText;
        let count = Math.max(meanings.count, meaningList.count);
        for (let i = 0; i < count; i++) {
            if (i < meaningList.count) {
                meanings.set(i, { meaning: meaningList.get(i).meaning });
            } else {
                meanings.remove(i);
                i--;
                count--;
            }
        }
        DB.update(dictList.get(currentDictIndex).id, id, expression, meanings, 0);
        stack.pop();
    }

    onVisibleChanged: {
        if (visible) {
            meaningList.clear();
            for (let i = 0; i < meanings.count; i++) {
                meaningList.append({ meaning: meanings.get(i).meaning });
            }
        }
    }
}
