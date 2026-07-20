pragma Singleton

import QtQuick
import Quickshell.Io

Item {
    id: root
    property bool hasBacklight: false
    property string deviceName: ""
    property int brightness: 100
    property int maxBrightness: 100
    readonly property int percent: Math.round((brightness / maxBrightness) * 100)

    function setBrightness(percentValue: int) {
        const brightness = Math.max(0, Math.min(100, percentValue));
        setProc.command = ["brightnessctl", "-d", root.deviceName, "set", brightness + "%"];
        setProc.running = true;
    }

    Process {
        id: setProc
    }

    Process {
        id: detectProc
        command: ["brightnessctl", "-m", "-l"]
        stdout: SplitParser {
            onRead: data => {
                const fields = data.split(",");
                if (fields.length >= 5 && fields[1] === "backlight") {
                    root.deviceName = fields[0];
                    root.hasBacklight = true;
                    root.brightness = parseInt(fields[2]);
                    root.maxBrightness = parseInt(fields[4]);
                }
            }
        }
    }

    Process {
        id: udevProc
        command: ["udevadm", "monitor", "--udev", "--subsystem-match=backlight"]
        stdout: SplitParser {
            onRead: data => detectProc.running = true
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: false
        triggeredOnStart: true
        onTriggered: {
            detectProc.running = true;
            udevProc.running = true;
        }
    }
}
