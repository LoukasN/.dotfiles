import QtQuick
import Quickshell
import "../../Services/"
import "../../Common/"

Item {
    id: root
    implicitWidth: batteryText.implicitWidth
    implicitHeight: batteryText.implicitHeight

    required property PanelWindow parentWindow

    Text {
        id: batteryText
        text: (BatteryService.isPluggedIn ? " " : "") + BatteryService.icon + "" + BatteryService.capacity + "%"
        color: BatteryService.isCritical ? Theme.critical : BatteryService.isWarning ? Theme.warning : BatteryService.isPaused ? Theme.threshold : Theme.fg
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        font.weight: Font.Bold
    }

    InfoPopup {
        id: batteryPopup
        anchors.fill: parent
        parentWindow: root.parentWindow
        text: BatteryService.info
    }
}
