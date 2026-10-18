pragma ComponentBehavior: Bound

import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "../Common/"
import "../Services/"

PopupMenu {
    id: menu

    onVisibleChanged: {
        if (visible) {
            NetworkService.scan();
            focusedItem.mode = "list";
            focusedItem.focusedIndex = 0;
            passwordField.text = "";
        } else {
            NetworkService.stopScan();
        }
    }

    Item {
        id: focusedItem
        anchors.centerIn: parent
        focus: true

        property string mode: "list"
        property int focusedIndex: 0
        readonly property int columnCount: 1 + NetworkService.networks.length

        implicitWidth: column.implicitWidth
        implicitHeight: column.implicitHeight

        Keys.onEscapePressed: {
            if (mode === "password") {
                passwordField.text = "";
                mode = "list";
                forceActiveFocus();
            } else
                menu.close();
        }
        Keys.onUpPressed: if (mode === "list")
            focusedIndex = focusedIndex - 1 < 0 ? columnCount - 1 : focusedIndex - 1
        Keys.onDownPressed: if (mode === "list")
            focusedIndex = focusedIndex + 1 > columnCount - 1 ? 0 : focusedIndex + 1
        Keys.onReturnPressed: if (mode === "list")
            activate(focusedIndex)

        property string pendingSsid: ""

        function activate(index) {
            if (index === 0) {
                NetworkService.toggleWifi();
                return;
            }
            const network = NetworkService.networks[index - 1];
            if (!network) {
                return;
            }
            if (network.connected) {
                NetworkService.disconnectFromNetwork();
                return;
            }
            if (network.secured && !network.saved) {
                pendingSsid = network.ssid;
                mode = "password";
                passwordField.forceActiveFocus();
            } else {
                NetworkService.connectToNetwork(network.ssid, "");
            }
        }

        ColumnLayout {
            id: column
            anchors.centerIn: parent
            spacing: Theme.menuButtonGap
            Rectangle {
                Layout.fillWidth: true
                implicitWidth: toggleLabel.implicitWidth + toggleLabel.font.pixelSize * Theme.menuButtonSpacingWidth / 16
                implicitHeight: toggleLabel.implicitHeight + toggleLabel.font.pixelSize * Theme.menuButtonSpacingHeight / 16
                radius: Theme.radius
                color: focusedItem.focusedIndex === 0 ? Theme.hovered : toggleMouse.containsMouse ? Theme.hovered : Theme.bg

                Text {
                    id: toggleLabel
                    anchors.centerIn: parent
                    text: NetworkService.wifiEnabled ? "Disable Wi-Fi" : "Enable Wi-Fi"
                    color: Theme.fg
                    font.family: Theme.font
                    font.pixelSize: Theme.fontSize + 4
                }
                MouseArea {
                    id: toggleMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: focusedItem.activate(0)
                }
            }

            Repeater {
                id: repeater
                model: NetworkService.networks
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
                        text: (modelData.secured ? " " : "") + modelData.ssid + (modelData.connected ? " ✓" : "")
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
                        onClicked: focusedItem.activate(index + 1)
                    }
                }
            }

            TextField {
                id: passwordField
                Layout.fillWidth: true
                visible: focusedItem.mode === "password"
                echoMode: TextInput.Password
                placeholderText: "Password"
                onAccepted: {
                    NetworkService.connectToNetwork(focusedItem.pendingSsid, text);
                    text = "";
                    focusedItem.mode = "list";
                    focusedItem.forceActiveFocus();
                }
            }
        }
    }

    IpcHandler {
        target: "networkMenu"
        function toggle() {
            menu.toggle();
        }
    }
}
