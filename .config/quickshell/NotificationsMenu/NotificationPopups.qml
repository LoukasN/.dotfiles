import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../Services/"

Variants {
    id: variantsRoot
    model: Quickshell.screens
    required property var notifications

    PanelWindow {
        id: root
        required property var modelData
        screen: modelData
        color: "transparent"

        WlrLayershell.layer: WlrLayer.Overlay

        anchors {
            top: true
            right: true
        }

        margins {
            top: Theme.topMargin + Theme.barHeight * 1.1
            right: Theme.rightMargin
        }

        implicitWidth: Theme.notificationWidth
        implicitHeight: Math.max(1, column.implicitHeight)
        exclusionMode: ExclusionMode.Ignore

        ColumnLayout {
            id: column
            width: parent.width
            spacing: Theme.widgetSpacing

            Repeater {
                model: variantsRoot.notifications
                delegate: NotificationCard {
                    isHistory: false
                }
            }
        }
    }
}
