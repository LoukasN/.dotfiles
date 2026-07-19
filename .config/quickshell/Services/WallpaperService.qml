pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

Singleton {
    id: root
    readonly property string wallpaperDir: Quickshell.env("HOME") + "/Pictures/wallpapers/"
    readonly property string statePath: Quickshell.statePath("wallpaper-state.json")

    property var wallpapers: []
    property string current: ""

    function refreshList() {
        lister.running = true;
    }

    function setWallpaper(name) {
        current = name;
        stateFile.setText(JSON.stringify({
            current: name
        }, null, 2));
        setter.command = ["awww", "img", wallpaperDir + name];
        setter.running = true;
    }

    Process {
        id: lister
        command: ["ls", root.wallpaperDir]
        stdout: StdioCollector {
            onStreamFinished: root.wallpapers = text.trim().split("\n").filter(n => n.length > 0)
        }
    }

    Process {
        id: setter
    }

    FileView {
        id: stateFile
        path: root.statePath
        onLoaded: {
            var data = JSON.parse(text());
            if (data.current) {
                root.current = data.current;
                setter.command = ["awww", "img", root.wallpaperDir + data.current];
                setter.running = true;
            }
        }
    }

    Component.onCompleted: refreshList()
}
