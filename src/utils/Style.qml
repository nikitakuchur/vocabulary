pragma Singleton
import QtQuick 2.12
import QtQuick.Controls.Material 2.12
import Units 1.0

QtObject {
    property QtObject toolBar: QtObject {
        property int height: Units.dp(60)
    }

    property QtObject smallFont: QtObject {
        property int size: Units.dp(16)
        property color color: Material.color(Material.Grey)
    }

    property QtObject font: QtObject {
        property int size: Units.dp(24)
        property color color: "black"
    }

    property QtObject rectangle: QtObject {
        property real radius: Units.dp(8)
    }

    property QtObject roundButton: QtObject {
        property int width: Units.dp(60)
    }

    property QtObject listView: QtObject {
        property int itemHeight: Units.dp(64)
    }
}
