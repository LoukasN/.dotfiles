pragma Singleton

import QtQuick
import Quickshell.Bluetooth
import qs.Services

Item {
    id: root

    readonly property BluetoothAdapter adapter: Bluetooth.defaultAdapter
    readonly property bool powered: adapter ? adapter.enabled : false
    readonly property var devices: adapter ? adapter.devices.values : []

    function togglePower() {
        if (adapter)
            adapter.enabled = !adapter.enabled;
    }

    function deviceByMac(mac) {
        if (!adapter)
            return null;
        for (let i = 0; i < devices.length; i++) {
            if (devices[i].address === mac)
                return devices[i];
        }
        return null;
    }

    function toggleConnection(mac) {
        const device = deviceByMac(mac);
        if (!device || device.state === BluetoothDeviceState.Connecting || device.state === BluetoothDeviceState.Disconnecting)
            return;
        if (device.state === BluetoothDeviceState.Connected)
            device.disconnect();
        else
            device.connect();
    }
}
