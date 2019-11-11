import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import Units 1.0
import Style 1.0
import "../../controls"
import "Quizzes.js" as QZ

Flickable {
    property string meaning: ""
    property var expressions

    anchors.fill: parent
    contentHeight: column.height + parent.height * 0.2
    Controls.ScrollBar.vertical: Controls.ScrollBar {}

    Column {
        id: column
        spacing: Units.dp(16)

        Text {
            text: qsTr("Meaning")
            font.pixelSize: Style.smallFont.size
            color: Style.smallFont.color
            topPadding: Units.dp(16)
            leftPadding: Units.dp(16)
        }

        Text {
            width: root.width
            text: meaning
            font.pixelSize: Style.font.size
            wrapMode: Text.Wrap
            leftPadding: Units.dp(16)
            rightPadding: Units.dp(16)
        }

        Line { width: root.width }

        Text {
            text: qsTr("Choose the expression")
            font.pixelSize: Style.smallFont.size
            color: Style.smallFont.color
            leftPadding: Units.dp(16)
        }

        Repeater {
            id: repeater
            model: expressions
            Button {
                text: expressions[index].expression
                font.pixelSize: Style.font.size
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.margins: Units.dp(16)

                onClicked: {
                    // Check user's answer
                    if (QZ.hasMeaning(expressions[index], meaning)) {
                        defaultColor = Material.color(Material.Green);
                        QZ.increaseLevel(expressions[index]);
                    } else {
                        defaultColor = Material.color(Material.Pink);
                        QZ.decreaseLevel(expressions[index]);
                    }
                    // Show the correct answer
                    for (let i = 0; i < repeater.count; i++) {
                        if (QZ.hasMeaning(expressions[i], meaning)) {
                            repeater.itemAt(i).defaultColor = Material.color(Material.Green);
                        }
                        repeater.itemAt(i).enabled = false;
                    }
                    timer.start();
                }
            }
        }

        Component.onCompleted: {
            let randomExpression;
            if (QZ.getRandomInt(2) === 0) {
                randomExpression = QZ.getRandomExpression();
            } else {
                randomExpression = QZ.getRandomLowLevelExpression();
            }
            meaning = QZ.getRandomElement(randomExpression.meanings).meaning;
            let array = QZ.getRandomExpressions(randomExpression, 3);
            expressions = QZ.shuffle(array);
        }
    }
}
