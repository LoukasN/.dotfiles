pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root
    property var entries: []

    signal historyUpdated

    function refresh() {
        listProc.running = true;
    }

    function copyEntry(entry) {
        decodeProc.entryText = entry;
        decodeProc.running = true;
    }

    function deleteEntry(entry) {
        deleteProc.entryText = entry;
        deleteProc.running = true;
    }

    Process {
        id: listProc
        command: ["cliphist", "list"]
        stdout: StdioCollector {
            onStreamFinished: {
                root.entries = text.split("\n").filter(line => line.length > 0);
                root.historyUpdated();
            }
        }
    }

    Process {
        id: decodeProc
        property string entryText: ""
        command: ["bash", "-c", " cliphist decode | wl-copy"]
        stdinEnabled: true
        running: false
        onRunningChanged: {
            if (running) {
                write(entryText + "\n");
                stdinEnabled = false;
            }
        }
    }

    Process {
        id: deleteProc
        property string entryText: ""
        command: ["cliphist", "delete"]
        stdinEnabled: true
        running: false
        onRunningChanged: {
            if (running) {
                write(entryText + "\n");
                stdinEnabled = false;
            }
        }
    }

    Component.onCompleted: refresh()
}
