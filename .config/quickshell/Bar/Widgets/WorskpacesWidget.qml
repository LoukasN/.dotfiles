import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../../Services/"

RowLayout {
    id: root
    required property var screen
    Repeater {
        model: {
            const monitor = Hyprland.monitorFor(root.screen);
            if (!monitor) {
                return [];
            }
            return Hyprland.workspaces.values.filter(ws => ws.monitor === monitor && ws.id > 0);
        }

        delegate: Item {
            id: worskpaceButton
            required property var modelData
            property bool isActive: Hyprland.focusedWorkspace?.id === modelData.id
            property bool hovered: mouseArea.containsMouse

            implicitWidth: Theme.buttonWidth
            implicitHeight: Theme.barHeight

            Rectangle {
                anchors.fill: parent
                color: worskpaceButton.hovered ? Theme.hovered : Theme.bg
            }

            Rectangle {
                anchors.bottom: parent.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                width: Theme.buttonWidth
                height: Theme.barHeight * 0.1
                color: Theme.specialAccent
                visible: worskpaceButton.isActive
            }

            Text {
                anchors.centerIn: parent
                text: worskpaceButton.modelData.id
                color: Theme.fg
                font.family: Theme.font
                font.pixelSize: worskpaceButton.isActive ? Theme.fontSize + 1 : Theme.fontSize
                font.weight: Font.Bold
            }

            MouseArea {
                id: mouseArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: worskpaceButton.modelData.activate()
            }
        }
    }
}
