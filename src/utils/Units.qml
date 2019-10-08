pragma Singleton
import QtQuick 2.13
import QtQuick.Window 2.13

Item {
    property int dpi: Screen.pixelDensity * 25.4

    function dp(x) {
        return x * (dpi / 160);
    }
}
