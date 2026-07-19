import Quickshell
import Quickshell.Io
import QtQuick
import "../../Services/"
import "../../Common/"

Item {
    id: root
    implicitWidth: bluetooth.width
    implicitHeight: bluetooth.height

    required property PanelWindow parentWindow
    required property var bluetoothMenu

    property bool isDeviceConnected
    readonly property string connectedInfo: {
        var connectedDeviceInfo = [];
        if (!BluetoothService.enabled)
            return "Bluetooth is off";
        if (BluetoothService.devices.length === 0)
            return "No devices connected";
        if (BluetoothService.devices.length !== 0)
            isDeviceConnected = false;
        for (let i = 0; i < BluetoothService.devices.length; i++) {
            if (BluetoothService.devices[i].connected) {
                const name = BluetoothService.devices[i].name;
                const battery = BluetoothService.devices[i].battery;
                connectedDeviceInfo.push(name + " " + battery * 100 + "%\n");
                isDeviceConnected = true;
            }
        }
        return connectedDeviceInfo.toString();
    }

    Text {
        id: bluetooth
        text: "󰂯"
        color: BluetoothService.powered ? Theme.fg : Theme.critical
        font.family: Theme.font
        font.pixelSize: Theme.fontSize + 3
    }

    InfoPopup {
        visible: parent.isDeviceConnected
        anchors.fill: parent
        parentWindow: root.parentWindow
        text: root.connectedInfo
        enabled: true
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                root.bluetoothMenu.toggle();
            } else if (mouse.button === Qt.RightButton)
                if (!openManagerProc.running)
                    openManagerProc.running = true;
        }
    }

    Process {
        id: openManagerProc
        command: ["blueman-manager"]
    }
}
