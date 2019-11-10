import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import Style 1.0
import Units 1.0
import "../controls"

Controls.Page {
    property int expressionIndex: 0
    property variant meanings
    property ListModel test

    id: root
    visible: false

    Flickable {
        anchors.fill: parent
        contentHeight: column.height + parent.height * 0.2
        Controls.ScrollBar.vertical: Controls.ScrollBar {}

        Column {
            id: column
            spacing: Units.dp(16)

            Text {
                text: qsTr("Expression")
                font.pixelSize: Style.smallFont.size
                color: Style.smallFont.color
                topPadding: Units.dp(16)
                leftPadding: Units.dp(16)
            }

            Text {
                width: root.width
                text: dictPage.model.get(expressionIndex).expression
                font.pixelSize: Style.font.size
                wrapMode: Text.Wrap
                leftPadding: Units.dp(16)
                rightPadding: Units.dp(16)
            }

            Line { width: root.width }

            Text {
                text: qsTr("Choose the meaning")
                font.pixelSize: Style.smallFont.size
                color: Style.smallFont.color
                leftPadding: Units.dp(16)
            }

            Repeater {
                id: repeater
                model: meanings
                Button {
                    text: meanings[index]
                    font.pixelSize: Style.font.size
                    anchors.left: parent.left
                    anchors.right: parent.right
                    anchors.margins: Units.dp(16)

                    onClicked: {
                        if (hasMeaning(meanings[index])) {
                            defaultColor = Material.color(Material.Green);
                        } else {
                            defaultColor = Material.color(Material.Pink);
                        }
                        for (let i = 0; i < repeater.count; i++) {
                            repeater.itemAt(i).enabled = false;
                        }
                        timer.start();
                    }
                }
            }
        }
    }

    Timer {
        id: timer
        interval: 300
        onTriggered: stack.replace("qrc:/pages/QuizzesPage.qml")
    }

    onVisibleChanged: {
        if (visible) {
            expressionIndex = getRandomExpressionIndex();
            let meaningArray = getRandomMeanings();
            meaningArray.push(getRandomMeaning(expressionIndex));
            meaningArray = shuffle(meaningArray);
            meanings = meaningArray;
        }
    }

    function hasMeaning(meaning) {
        let currentMeanings = dictPage.model.get(expressionIndex).meanings;
        for (let i = 0; i < currentMeanings.count; i++) {
            if (currentMeanings.get(i).meaning === meaning) {
                return true;
            }
        }
        return false;
    }

    function getRandomInt(count) {
        return Math.floor(Math.random() * count);
    }

    function getRandomExpressionIndex() {
        return getRandomInt(dictPage.model.count);
    }

    function getRandomMeaning(expressionIndex) {
        let meanings = dictPage.model.get(expressionIndex).meanings;
        let randomIndex = getRandomInt(meanings.count);
        return meanings.get(randomIndex).meaning;
    }

    function getRandomMeanings() {
        let result = [];
        for (let i = 0; i < 3; i++) {
            result.push(getRandomMeaning(getRandomExpressionIndex()));
        }
        return result;
    }

    function shuffle(array) {
        for (let i = array.length - 1; i > 0; i--) {
            const j = Math.floor(Math.random() * (i + 1));
            [array[i], array[j]] = [array[j], array[i]];
        }
        return array;
    }
}
