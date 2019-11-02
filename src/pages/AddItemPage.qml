import QtQuick 2.12
import "../utils/Database.js" as DB

EditableItemPage {
    onSaveButtonClicked: {
        var rowid = parseInt(DB.insert(expressionText, meaningList));
        var meanings = []
        for (var i = 0; i < meaningList.count; i++) {
            meanings.push({ meaning: meaningList.get(i).meaning })
        }
        listModel.append({
            id: rowid,
            expression: expressionText,
            meanings: meanings
        });
        stack.pop();
    }
    onVisibleChanged: {
        if (visible) {
            expressionText = "";
            meaningList.clear();
            meaningList.append({ meaning: "" });
        }
    }
}
