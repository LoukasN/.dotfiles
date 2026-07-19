import Quickshell
import Quickshell.Wayland
import QtQuick
import "../Services/"

PanelWindow {
    id: root

    visible: false

    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    default property alias content: contentItem.data
    function close() {
        root.visible = false;
    }
    function toggle() {
        root.visible = !root.visible;
    }

    anchors {
        top: true
        left: true
        right: true
        bottom: true
    }

    MouseArea {
        anchors.fill: parent
        onClicked: root.close()
    }

    Rectangle {
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.topMargin: Theme.topMargin + 3
        anchors.rightMargin: Theme.rightMargin
        implicitWidth: contentItem.implicitWidth + Theme.menuButtonSpacingWidth
        implicitHeight: contentItem.implicitHeight + Theme.menuButtonSpacingHeight
        radius: Theme.radius
        color: Theme.bg

        MouseArea {
            anchors.fill: parent
        }

        Item {
            id: contentItem
            anchors.centerIn: parent
            implicitWidth: {
                let width = 0;
                for (const child of children)
                    width = Math.max(width, child.implicitWidth);
                return width;
            }
            implicitHeight: {
                let height = 0;
                for (const child of children)
                    height = Math.max(height, child.implicitHeight);
                return height;
            }
        }
    }
}
