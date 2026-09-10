import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../Common/"
import "../Services/"

PopupMenu {
    id: menu

    onVisibleChanged: if (visible)
        focusedItem.focusedIndex = 0

    Item {
        id: focusedItem
        focus: true

        property int focusedIndex: 0

        implicitWidth: row.implicitWidth
        implicitHeight: row.implicitHeight

        Keys.onEscapePressed: menu.close()
        Keys.onUpPressed: focusedIndex = focusedIndex - 1 < 0 ? repeater.count - 1 : focusedIndex - 1
        Keys.onDownPressed: focusedIndex = focusedIndex + 1 > repeater.count - 1 ? 0 : focusedIndex + 1
        Keys.onReturnPressed: {
            menu.close();
            proc.command = repeater.itemAt(focusedIndex).modelData.cmd;
            proc.running = true;
        }

        ColumnLayout {
            id: row
            spacing: Theme.menuButtonGap
            Repeater {
                id: repeater
                model: [
                    {
                        label: " Poweroff",
                        cmd: ["systemctl", "poweroff"]
                    },
                    {
                        label: " Restart",
                        cmd: ["systemctl", "reboot"]
                    },
                    {
                        label: "󰍃 Logout",
                        cmd: ["bash", "-c", "kill -SIGTERM $(pidof Hyprland)"]
                    },
                    {
                        label: "󰤄 Suspend",
                        cmd: ["systemctl", "suspend"]
                    },
                    {
                        label: " Lock",
                        cmd: ["loginctl", "lock-session"]
                    },
                ]

                delegate: Rectangle {
                    id: button
                    required property int index
                    required property var modelData
                    implicitWidth: label.implicitWidth + label.font.pixelSize * Theme.menuButtonSpacingWidth / 16
                    implicitHeight: label.implicitHeight + label.font.pixelSize * Theme.menuButtonSpacingHeight / 16
                    radius: Theme.radius
                    color: index === focusedItem.focusedIndex ? Theme.hovered : mouseArea.containsMouse ? Theme.hovered : Theme.bg

                    Text {
                        id: label
                        anchors.centerIn: parent
                        text: parent.modelData.label
                        color: Theme.fg
                        font.family: Theme.font
                        font.pixelSize: Theme.fontSize + 4
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                        width: parent.width + Theme.menuButtonSpacingWidth
                    }

                    MouseArea {
                        id: mouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            menu.close();
                            proc.command = parent.modelData.cmd;
                            proc.running = true;
                        }
                    }
                }
            }
        }
    }

    Process {
        id: proc
        running: false
    }

    IpcHandler {
        target: "shutdownMenu"
        function toggle() {
            menu.toggle();
        }
    }
}
