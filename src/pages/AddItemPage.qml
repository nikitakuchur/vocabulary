import QtQuick 2.12
import "../utils/Database.js" as DB

EditableItemPage {
    onSaveButtonClicked: {
        var id = DB.insert(currentDictId, expressionText, meaningList, 0);
        var meanings = []
        for (var i = 0; i < meaningList.count; i++) {
            meanings.push({ meaning: meaningList.get(i).meaning })
        }
        dictPage.model.append({
            id: id,
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
