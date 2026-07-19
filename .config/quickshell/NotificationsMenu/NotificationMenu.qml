import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "../Services/"

PanelWindow {
    id: root
    visible: false
    color: "transparent"

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.OnDemand

    anchors {
        top: true
        right: true
        left: true
        bottom: true
    }

    Item {
        id: focusedItem
        anchors.fill: parent
        focus: true

        Keys.onEscapePressed: root.visible = false
        Keys.onDeletePressed: NotificationService.clearHistory()

        MouseArea {
            anchors.fill: parent
            onClicked: root.visible = false
        }

        Rectangle {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: Theme.topMargin
            anchors.rightMargin: Theme.rightMargin
            implicitWidth: Theme.notificationWidth
            implicitHeight: Math.min(root.height / 2, Math.max(105, row.implicitHeight + listView.contentHeight + 20))
            radius: Theme.radius
            color: Theme.bg

            MouseArea {
                anchors.fill: parent
            }

            ColumnLayout {
                id: column
                anchors.fill: parent
                anchors.margins: Theme.barPadding
                spacing: Theme.widgetSpacing

                RowLayout {
                    id: row
                    Layout.fillWidth: true
                    Text {
                        text: "Notifications"
                        color: Theme.accent
                        font.family: Theme.font
                        font.pixelSize: Theme.fontSize + 2
                        font.bold: true
                        Layout.fillWidth: true
                    }
                    Text {
                        visible: NotificationService.history.length > 0
                        text: "Clear all"
                        color: Theme.fg
                        font.family: Theme.font
                        font.pixelSize: Theme.fontSize

                        MouseArea {
                            anchors.fill: parent
                            anchors.margins: -4
                            onClicked: NotificationService.clearHistory()
                        }
                    }
                }
                ListView {
                    id: listView
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    spacing: Theme.widgetSpacing
                    model: NotificationService.history

                    delegate: NotificationCard {
                        width: ListView.view.width
                        isHistory: true
                        onRemoveRequested: NotificationService.removeHistoryItem(modelData.id)
                    }
                    Text {
                        anchors.centerIn: parent
                        visible: NotificationService.history.length === 0
                        text: "No notifications"
                        color: Theme.fg
                        font.family: Theme.font
                        font.pixelSize: Theme.fontSize
                    }
                }
            }
        }
    }

    IpcHandler {
        target: "notifications"
        function toggle() {
            root.visible = !root.visible;
        }
        function clear() {
            NotificationService.clearHistory();
        }
    }
}
