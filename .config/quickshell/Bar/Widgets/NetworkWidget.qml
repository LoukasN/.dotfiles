import QtQuick
import Quickshell
import Quickshell.Io
import "../../Services/"
import "../../Common/"

Item {
    id: root
    implicitWidth: network.width
    implicitHeight: network.height

    required property PanelWindow parentWindow
    required property var networkMenu

    Text {
        id: network
        text: NetworkService.networkState === "wifi" ? "" + " (" + (NetworkService.signalStrength) + "%)" : NetworkService.networkState === "ethernet" ? "󰈀" : "⚠"
        color: NetworkService.networkState === "disconnected" ? Theme.critical : Theme.fg
        font.family: Theme.font
        font.pixelSize: Theme.fontSize
        font.weight: Font.Bold
    }

    InfoPopup {
        anchors.fill: parent
        parentWindow: root.parentWindow
        text: NetworkService.info
        enabled: true
    }

    MouseArea {
        cursorShape: Qt.PointingHandCursor
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: mouse => {
            if (mouse.button === Qt.LeftButton) {
                root.networkMenu.toggle();
            } else if (mouse.button === Qt.RightButton)
                if (!openManagerProc.running)
                    openManagerProc.running = true;
        }
    }
    Process {
        id: openManagerProc
        command: ["nm-connection-editor"]
    }
}
