pragma Singleton
import QtQuick
import Quickshell.Io

Item {
    id: root

    property string governor: "unknown"
    property string driver: ""
    property real avgLoad: 0
    property bool turboEnabled: false
    property string suggestion: ""
    property bool available: true

    property string rawStats: ""

    Timer {
        interval: 500
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: statsProcess.running = true
    }

    Process {
        id: statsProcess
        command: ["auto-cpufreq", "--stats"]
        stdout: StdioCollector {
            id: collector
            onStreamFinished: {
                root.rawStats = collector.text;
                root.available = true;
                root.parse(collector.text);
                console.log(collector.text)
            }
        }
        onExited: (exitCode, exitStatus) => {
            if (exitCode !== 0) {
                root.available = false;
            }
        }
    }

    function parse(text) {
        const governorMatch = text.match(/Governor:\s*(\S+)/i);
        if (governorMatch)
            governor = governorMatch[1];

        const driverMatch = text.match(/Driver:\s*(\S+)/i);
        if (driverMatch)
            driver = driverMatch[1];

        const loadMatch = text.match(/Total CPU usage:\s*([\d.]+)/i);
        if (loadMatch)
            avgLoad = parseFloat(loadMatch[1]);

        turboEnabled = /Turbo:\s*(On|Yes|True)/i.test(text);
    }
}
