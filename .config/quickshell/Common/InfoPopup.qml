import QtQuick
import Quickshell
import "../Services"

Item {
    id: root

    required property PanelWindow parentWindow
    required property string text
    property alias hovered: mouseArea.containsMouse

    MouseArea {
        id: mouseArea
        width: root.width
        height: root.height
        hoverEnabled: true
        onEntered: {
            const pos = root.mapToItem(null, 0, 0);
            popup.anchor.rect = Qt.rect(pos.x, pos.y + Theme.barHeight / 2.8, root.width, root.height);
            popup.visible = true;
        }
        onExited: {
            popup.visible = false;
        }
    }

    PopupWindow {
        id: popup
        visible: false
        anchor {
            window: root.parentWindow
            edges: Edges.Bottom
            gravity: Edges.Bottom
        }
        implicitWidth: text.width + 16
        implicitHeight: text.height + 10
        color: Theme.bg

        Text {
            id: text
            anchors.centerIn: parent
            text: root.text
            color: Theme.fg
            font.family: Theme.font
            font.pixelSize: Theme.fontSize
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }
}
