pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    property bool tailscaleUp: false
    property string tailnetIp: ""
    property bool exitNodeActive: false

    Process {
        id: tsCheck
        command: ["tailscale", "status", "--json"]
        stdout: StdioCollector {
            onStreamFinished: {
                try {
                    const s = JSON.parse(text);
                    root.tailscaleUp = s.BackendState === "Running";
                    root.tailnetIp = (s.Self && s.Self.TailscaleIPs) ? s.Self.TailscaleIPs[0] : "";
                    root.exitNodeActive = !!s.ExitNodeStatus;
                } catch (e) {
                    root.tailscaleUp = false;
                    root.tailnetIp = "";
                    root.exitNodeActive = false;
                }
            }
        }
    }

    Timer {
        interval: 5000
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: tsCheck.running = true
    }
}
