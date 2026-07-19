pragma Singleton

import QtQuick
import Quickshell.Io

Item {
    id: root
    property int brightness: 100
    property int maxBrightness: 100
    readonly property int percent: Math.round((brightness / maxBrightness) * 100)

    function setBrightness(percentValue: int) {
        const brightness = Math.max(0, Math.min(100, percentValue));
        setProc.command = ["brightnessctl", "set", brightness + "%"];
        setProc.running = true;
    }

    Process {
        id: setProc
    }

    Process {
        id: brightnessProc
        command: ["cat", "/sys/class/backlight/amdgpu_bl1/brightness"]
        stdout: SplitParser {
            onRead: data => root.brightness = parseInt(data)
        }
    }

    Process {
        id: maxProc
        command: ["cat", "/sys/class/backlight/amdgpu_bl1/max_brightness"]
        stdout: SplitParser {
            onRead: data => root.maxBrightness = parseInt(data)
        }
    }

    Process {
        id: udevProc
        command: ["udevadm", "monitor", "--udev", "--subsystem-match=backlight"]
        stdout: SplitParser {
            onRead: data => brightnessProc.running = true
        }
    }

    Timer {
        interval: 100
        running: true
        repeat: false
        triggeredOnStart: true
        onTriggered: {
            udevProc.running = true;
            maxProc.running = true;
            brightnessProc.running = true;
        }
    }
}
