pragma Singleton

import QtQuick
import Quickshell.Io

Item {
    id: root

    // Bar
    property string networkState: ""
    property string ssid: ""
    property string ifname: ""
    property string ipaddr: ""

    readonly property string info: {
        if (networkState === "disconnected")
            return "Disconnected";
        if (networkState === "wifi")
            return ssid + "\n" + ipaddr;
        return ifname + "\n" + ipaddr;
    }

    // Wifi menu
    property bool wifiEnabled: true
    property bool scanning: false
    property var networks: []
    property var savedConnections: []

    function scan() {
        scanning = true;
        networks = [];
        wifiRadioProc.running = true;
    }

    function toggleWifi() {
        toggleWifiProc.command = ["nmcli", "radio", "wifi", wifiEnabled ? "off" : "on"];
        toggleWifiProc.running = true;
    }

    function connectToNetwork(ssid, password) {
        if (savedConnections.indexOf(ssid) !== -1) {
            connectProc.command = ["nmcli", "connection", "up", "id", ssid];
        } else if (password) {
            connectProc.command = ["nmcli", "device", "wifi", "connect", ssid, "password", password];
        } else {
            connectProc.command = ["nmcli", "device", "wifi", "connect", ssid];
        }
        connectProc.running = true;
    }

    // Wifi menu processes
    Process {
        id: wifiRadioProc
        command: ["nmcli", "-g", "WIFI", "general"]
        stdout: SplitParser {
            onRead: data => {
                root.wifiEnabled = data.trim() === "enabled";
                if (root.wifiEnabled) {
                    savedConnProc.running = true;
                } else {
                    root.networks = [];
                    root.scanning = false;
                }
            }
        }
    }

    Process {
        id: savedConnProc
        command: ["nmcli", "-g", "NAME", "connection", "show"]
        property string buffer: ""
        onRunningChanged: if (running)
            buffer = ""
        stdout: SplitParser {
            onRead: data => savedConnProc.buffer += data + "\n"
        }
        onExited: (code, status) => {
            root.savedConnections = buffer.split("\n").map(saved => saved.trim()).filter(saved => saved !== "");
            scanListProc.running = true;
        }
    }

    Process {
        id: scanListProc
        command: ["nmcli", "-t", "-f", "SSID,SECURITY,SIGNAL,IN-USE", "device", "wifi", "list"]
        property string buffer: ""
        onRunningChanged: if (running)
            buffer = ""
        stdout: SplitParser {
            onRead: data => scanListProc.buffer += data + "\n"
        }
        onExited: (code, status) => {
            const seen = {};
            const list = [];
            const lines = buffer.split("\n").filter(line => line.trim() !== "");
            for (const line of lines) {
                const parts = line.split(":");
                const netSsid = parts[0];
                const security = parts[1] || "";
                const signal = parseInt(parts[2] || "0", 10);
                const inUse = (parts[3] || "").trim() === "*";
                if (!netSsid)
                    continue;
                list.push({
                    ssid: netSsid,
                    secured: security !== "" && security !== "--",
                    connected: inUse,
                    saved: root.savedConnections.indexOf(netSsid) !== -1,
                    signal: signal
                });
            }

            const bySsid = {};
            for (const item of list) {
                const existing = bySsid[item.ssid];
                if (!existing) {
                    bySsid[item.ssid] = item;
                } else if (item.connected && !existing.connected) {
                    bySsid[item.ssid] = item;
                } else if (!item.conncted && item.signal > existing.signal) {
                    bySsid[item.ssid] = item;
                }
            }

            const deduped = Object.values(bySsid);

            deduped.sort((a, b) => {
                if (a.connected !== b.connected)
                    return a.connected ? -1 : 1;
                return b.signal - a.signal;
            });
            root.networks = deduped;
            root.scanning = false;
        }
    }

    Process {
        id: toggleWifiProc
        onExited: (code, status) => wifiRadioProc.running = true
    }

    Process {
        id: connectProc
        onExited: (code, status) => scan()
    }

    // Bar processes
    Process {
        id: netProc
        command: ["sh", "-c", "ip route get 1.1.1.1 2>/dev/null | awk '{print $5}' | head -1"]
        property bool gotData: false
        onRunningChanged: if (running)
            gotData = false
        stdout: SplitParser {
            onRead: data => {
                netProc.gotData = true;
                const iface = data.trim();
                root.ifname = iface;
                ipProc.running = true;

                if (iface.startsWith("wl")) {
                    root.networkState = "wifi";
                    wifiProc.running = true;
                } else {
                    root.networkState = "ethernet";
                    root.ssid = "";
                }
            }
        }
        onExited: (code, status) => {
            if (!gotData) {
                root.networkState = "disconnected";
                root.ssid = "";
                root.ifname = "";
                root.ipaddr = "";
            }
        }
    }

    Process {
        id: wifiProc
        command: ["sh", "-c", "iwgetid -r"]
        stdout: SplitParser {
            onRead: data => {
                const s = data.trim();
                if (s !== "") {
                    root.ssid = s;
                }
            }
        }
    }

    Process {
        id: ipProc
        command: ["sh", "-c", "ip -4 -o addr show | grep -v 'lo ' | awk '/inet / {print $4}' | head -1"]
        stdout: SplitParser {
            onRead: data => {
                if (root.networkState !== "disconnected")
                    root.ipaddr = data.trim();
            }
        }
    }

    Process {
        id: udevProc
        command: ["ip", "monitor", "link", "address"]
        running: true
        stdout: SplitParser {
            onRead: data => debouncerTimer.restart()
        }
    }

    Timer {
        id: debouncerTimer
        interval: 500
        repeat: false
        onTriggered: netProc.running = true
    }

    Timer {
        interval: 100
        running: true
        repeat: false
        triggeredOnStart: true
        onTriggered: netProc.running = true
    }
}
