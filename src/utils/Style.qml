pragma Singleton
import QtQuick 2.12
import Units 1.0

QtObject {
    property QtObject toolBar: QtObject {
        property int height: Units.dp(60)
    }

    property QtObject smallFont: QtObject {
        property int size: Units.dp(16)
        property color color: "gray"
    }

    property QtObject font: QtObject {
        property int size: Units.dp(24)
        property color color: "black"
    }

    property QtObject line: QtObject {
        property color color: "#dfdfde"
    }

    property QtObject rectangle: QtObject {
        property real radius: Units.dp(8)
    }

    property QtObject button: QtObject {
        property int height: Units.dp(46)
        property color textColor: "white"
        property color blueColor: "#2eaadc"
        property color redColor: "#e96675"
    }

    property QtObject roundButton: QtObject {
        property int width: Units.dp(70)
    }

    property QtObject textField: QtObject {
        property int height: Units.dp(46)
        property color color: "#f7f7f5"
        property color borderColor: "#cfcfcd"
    }

    property QtObject listView: QtObject {
        property int itemHeight: Units.dp(64)
        property color color: "white"
        property color borderColor: "#dfdfde"
        property color pressedColor: "#dfdede"
    }
}
