pragma Singleton

import QtQuick
import Quickshell.Io
import Quickshell.Networking

Item {
    id: root

    readonly property var wifiDevice: {
        const devices = Networking.devices.values;
        for (let i = 0; i < devices.length; i++) {
            if (devices[i].type === DeviceType.Wifi)
                return devices[i];
        }
        return null;
    }

    readonly property var wiredDevice: {
        const devices = Networking.devices.values;
        for (let i = 0; i < devices.length; i++) {
            if (devices[i].type === DeviceType.Wired)
                return devices[i];
        }
        return null;
    }

    readonly property var activeWifiNetwork: {
        if (!wifiDevice)
            return null;
        const nets = wifiDevice.networks.values;
        for (let i = 0; i < nets.length; i++) {
            if (nets[i].connected)
                return nets[i];
        }
        return null;
    }

    // Bar
    readonly property string networkState: {
        if (wifiDevice && wifiDevice.connected)
            return "wifi";
        if (wiredDevice && wiredDevice.connected)
            return "ethernet";
        return "disconnected";
    }

    readonly property string ssid: activeWifiNetwork ? activeWifiNetwork.name : ""

    readonly property int signalStrength: activeWifiNetwork ? Math.round(activeWifiNetwork.signalStrength * 100) : 0

    readonly property string ifname: {
        if (networkState === "wifi" && wifiDevice)
            return wifiDevice.name;
        if (networkState === "ethernet" && wiredDevice)
            return wiredDevice.name;
        return "";
    }

    property string ipaddr: ""

    readonly property string info: {
        if (networkState === "disconnected")
            return "Disconnected";
        if (networkState === "wifi")
            return ssid + "\n" + ipaddr;
        return ifname + "\n" + ipaddr;
    }

    onIfnameChanged: refreshIp()
    onNetworkStateChanged: refreshIp()

    function refreshIp() {
        if (networkState === "disconnected" || !ifname) {
            ipaddr = "";
            return;
        }
        ipProc.command = ["sh", "-c", "ip -4 -o addr show " + ifname + " 2>/dev/null | awk '{print $4}' | head -1"];
        ipProc.running = true;
    }

    Process {
        id: ipProc
        stdout: SplitParser {
            onRead: data => root.ipaddr = data.trim()
        }
    }

    // Wifi menu

    readonly property bool wifiEnabled: Networking.wifiEnabled
    readonly property bool scanning: wifiDevice ? wifiDevice.scannerEnabled : false

    readonly property var networks: {
        if (!wifiDevice)
            return [];

        const list = wifiDevice.networks.values.map(net => ({
                    ssid: net.name,
                    secured: net.security !== WifiSecurityType.Open,
                    connected: net.connected,
                    saved: net.known,
                    signal: Math.round(net.signalStrength * 100)
                }));

        list.sort((a, b) => {
            if (a.connected !== b.connected)
                return a.connected ? -1 : 1;
            return b.signal - a.signal;
        });

        return list;
    }

    readonly property var savedConnections: networks.filter(n => n.saved).map(n => n.ssid)

    function scan() {
        if (wifiDevice)
            wifiDevice.scannerEnabled = true;
    }

    function toggleWifi() {
        Networking.wifiEnabled = !Networking.wifiEnabled;
    }

    function connectToNetwork(ssid, password) {
        if (!wifiDevice)
            return;

        const nets = wifiDevice.networks.values;
        for (let i = 0; i < nets.length; i++) {
            if (nets[i].name !== ssid)
                continue;

            const net = nets[i];
            if (net.known) {
                net.connect();
            } else if (password) {
                net.connectWithPsk(password);
            } else {
                net.connect();
            }
            return;
        }
    }

    function disconnectFromNetwork() {
        if (!wifiDevice)
            return;

        const nets = wifiDevice.networks.values;
        for (let i = 0; i < nets.length; i++) {
            if (nets[i].connected)
                nets[i].disconnect();
        }
        return;
    }
}
