pragma Singleton

import QtQuick
import Quickshell.Hyprland
import Quickshell.Io

Item {
    id: root
    property string activeWindowTitle: ""
    property string keyboardLayout: ""
    property bool fullscreenWindow: true

    function isScreenFullscreen(screen) {
        const monitor = Hyprland.monitorFor(screen);
        return monitor && monitor.activeWorkspace ? monitor.activeWorkspace.hasFullscreen : false;
    }

    Process {
        id: layoutProc
        command: ["sh", "-c", "hyprctl devices -j | grep 'active_keymap' | head -1 | awk -F '\"' '{print $4}'"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                root.keyboardLayout = this.text.trim();
            }
        }
    }

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "moveworkspace" || event.name === "focusedmon" || event.name === "monitoradded" || event.name === "monitorremoved") {
                Hyprland.refreshWorkspaces();
                Hyprland.refreshMonitors();
            }

            if (event.name === "activewindow") {
                const parts = event.data.split(",");
                root.activeWindowTitle = parts.slice(1).join(",");
            }

            if (event.name === "closewindow") {
                root.activeWindowTitle = "";
            }

            if (event.name === "activelayout") {
                const parts = event.data.split(",");
                root.keyboardLayout = parts[parts.length - 1];
            }

            if (event.name === "fullscreen") {
                if (Hyprland.focusedWorkspace) {
                    root.fullscreenWindow = Hyprland.focusedWorkspace.hasFullscreen;
                }
            }
        }
    }
}
