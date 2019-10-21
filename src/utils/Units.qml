pragma Singleton
import QtQuick 2.12
import QtQuick.Window 2.12

Item {
    property int dpi: Screen.pixelDensity * 25.4

    function dp(x) {
        return x * (dpi / 160);
    }
}
