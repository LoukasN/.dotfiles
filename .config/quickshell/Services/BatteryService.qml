pragma Singleton

import QtQuick
import Quickshell.Services.UPower

Item {
    id: root

    property string capacity: Math.round(device.percentage * 100)

    property UPowerDevice device: UPower.displayDevice

    readonly property string status: {
        switch (device.state) {
        case UPowerDeviceState.FullyCharged:
            return "Full";
        case UPowerDeviceState.Charging:
            return "Charging";
        case UPowerDeviceState.Discharging:
            return "Discharging";
        case UPowerDeviceState.PendingCharge:
            return "Not charging";
        case UPowerDeviceState.PendingDischarge:
            return "Pending discharge";
        case UPowerDeviceState.Empty:
            return "Empty";
        default:
            return "Unknown";
        }
    }

    readonly property bool isPluggedIn: device.state == UPowerDeviceState.Charging || device.state == UPowerDeviceState.FullyCharged || device.state == UPowerDeviceState.PendingCharge
    readonly property bool isCharging: isPluggedIn && (status === "Charging" || status === "Full")
    readonly property bool isPaused: isPluggedIn && status === "Not charging"
    readonly property bool isWarning: capacity <= 30 && !isCharging
    readonly property bool isCritical: capacity <= 15 && !isCharging
    readonly property bool isDischarging: status === "Discharging"

    readonly property string icon: {
        if (capacity >= 90)
            return " ";
        if (capacity >= 80)
            return " ";
        if (capacity >= 50)
            return " ";
        if (capacity >= 20)
            return " ";
        if (capacity >= 0)
            return " ";
        return "";
    }

    readonly property string timeRemaining: {
        const seconds = isDischarging ? device.timeToEmpty : device.timeToFull;
        if (seconds <= 0)
            return "";
        const h = Math.floor(seconds / 3600);
        const m = Math.floor((seconds % 3600) / 60);
        return h + " h " + m + " min";
    }

    readonly property string info: {
        if (device.state == UPowerDeviceState.FullyCharged) {
            return "Charged";
        } else if (device.state == UPowerDeviceState.Charging) {
            return "Full in " + timeRemaining;
        } else if (device.state == UPowerDeviceState.PendingCharge) {
            return "Charging is Paused";
        } else if (device.state == UPowerDeviceState.Discharging) {
            return (timeRemaining !== "" ? "Empty in " + timeRemaining : "");
        }
        return null;
    }
}
