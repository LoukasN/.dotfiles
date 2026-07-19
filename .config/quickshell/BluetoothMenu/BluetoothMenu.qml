pragma ComponentBehavior: Bound

import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import "../Common/"
import "../Services/"

PopupMenu {
    id: menu

    required property var bluetoothMenu

    onVisibleChanged: if (visible) {
        focusedItem.focusedIndex = 0;
    }

    Item {
        id: focusedItem
        anchors.centerIn: parent
        focus: true

        property int focusedIndex: 0
        readonly property int columnCount: 1 + BluetoothService.devices.length

        implicitWidth: column.implicitWidth
        implicitHeight: column.implicitHeight

        Keys.onEscapePressed: menu.close()
        Keys.onUpPressed: focusedIndex = focusedIndex - 1 < 0 ? columnCount - 1 : focusedIndex - 1
        Keys.onDownPressed: focusedIndex = focusedIndex + 1 > columnCount - 1 ? 0 : focusedIndex + 1
        Keys.onReturnPressed: {
            activate(focusedIndex);
            menu.close();
        }

        function activate(index) {
            if (index === 0) {
                BluetoothService.togglePower();
                return;
            }
            const device = BluetoothService.devices[index - 1];
            if (!device)
                return;
            BluetoothService.toggleConnection(device.address);
        }

        ColumnLayout {
            id: column
            anchors.centerIn: parent
            spacing: Theme.menuButtonGap

            Rectangle {
                Layout.fillWidth: true
                implicitWidth: powerLabel.implicitWidth + powerLabel.font.pixelSize * Theme.menuButtonSpacingWidth / 16
                implicitHeight: powerLabel.implicitHeight + powerLabel.font.pixelSize * Theme.menuButtonSpacingHeight / 16
                radius: Theme.radius
                color: focusedItem.focusedIndex === 0 ? Theme.hovered : powerMouse.containsMouse ? Theme.hovered : Theme.bg

                Text {
                    id: powerLabel
                    anchors.centerIn: parent
                    text: BluetoothService.powered ? "Disable Bluetooth" : "Enable Bluetooth"
                    color: Theme.fg
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize + 4
                }
                MouseArea {
                    id: powerMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: focusedItem.activate(0)
                }
            }

            Repeater {
                id: repeater
                model: BluetoothService.devices
                delegate: Rectangle {
                    id: button
                    required property int index
                    required property var modelData
                    Layout.fillWidth: true
                    implicitWidth: label.implicitWidth + label.font.pixelSize * Theme.menuButtonSpacingWidth / 16
                    implicitHeight: label.implicitHeight + label.font.pixelSize * Theme.menuButtonSpacingHeight / 16
                    radius: Theme.radius
                    color: (index + 1) === focusedItem.focusedIndex ? Theme.hovered : mouseArea.containsMouse ? Theme.hovered : Theme.bg

                    Text {
                        id: label
                        anchors.centerIn: parent
                        text: modelData.name + (modelData.connected ? " ✓" : "")
                        color: modelData.connected ? Theme.specialAccent : Theme.fg
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
                            focusedItem.activate(index + 1);
                            menu.close();
                        }
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "bluetoothMenu"
        function toggle() {
            menu.toggle();
        }
    }
}
