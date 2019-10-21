pragma Singleton
import QtQuick 2.12
import Units 1.0

QtObject {
    property QtObject font: QtObject {
        property int size: Units.dp(24)
    }

    property QtObject rectangle: QtObject {
        property real radius: Units.dp(12)
    }

    property QtObject button: QtObject {
        property int height: Units.dp(64)
        property color textColor: "white"
        property color color: "#2eaadc"
        property color pressedColor: "#008dbe"
    }

    property QtObject roundButton: QtObject {
        property int width: Units.dp(70)
    }

    property QtObject textField: QtObject {
        property int height: Units.dp(64)
        property color color: "#f7f7f5"
        property color borderColor: "#cfcfcd"
    }

    property QtObject listView: QtObject {
        property int itemHeight: Units.dp(64)
        property color color: "#f7f7f5"
        property color borderColor: "#dfdfde"
    }
}
