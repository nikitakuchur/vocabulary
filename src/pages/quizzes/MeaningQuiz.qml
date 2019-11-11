import QtQuick 2.12
import QtQuick.Controls 2.12 as Controls
import QtQuick.Controls.Material 2.12
import Units 1.0
import Style 1.0
import "../../controls"
import "../../utils/Quizzes.js" as QZ

Flickable {
    property var expression
    property var meanings

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
            text: expression.expression
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
                    if (QZ.hasMeaning(expression, meanings[index])) {
                        defaultColor = Material.color(Material.Green);
                        QZ.increaseLevel(expression);
                    } else {
                        defaultColor = Material.color(Material.Pink);
                        QZ.decreaseLevel(expression);
                    }
                    for (let i = 0; i < repeater.count; i++) {
                        repeater.itemAt(i).enabled = false;
                    }
                    timer.start();
                }
            }
        }

        Component.onCompleted: {
            if (QZ.getRandomInt(2) === 0) {
                expression = QZ.getRandomExpression();
            } else {
                expression = QZ.getRandomLowLevelExpression();
            }
            let initialMeaning = QZ.getRandomElement(expression.meanings).meaning;
            let array = QZ.getRandomMeanings(initialMeaning, 3);
            meanings = QZ.shuffle(array);
        }
    }
}
