pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Services.SystemTray
import "../../Services/"

Row {
    id: systemTray
    spacing: Theme.systemTraySpacing

    required property var parentWindow
    readonly property alias count: trayRepeater.count

    Repeater {
        id: trayRepeater
        model: SystemTray.items
        delegate: Rectangle {
            id: trayDelegate
            required property var modelData
            implicitHeight: Theme.barHeight
            implicitWidth: Theme.buttonWidth
            color: Theme.bg
            radius: Theme.radius

            Image {
                anchors.centerIn: parent
                sourceSize.width: Theme.fontSize
                sourceSize.height: Theme.fontSize
                smooth: true
                mipmap: true
                source: trayDelegate.modelData.icon
            }

            QsMenuAnchor {
                id: menuAnchor
                menu: trayDelegate.modelData.menu
                anchor.window: systemTray.parentWindow
            }

            MouseArea {
                cursorShape: Qt.PointingHandCursor
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton

                onClicked: mouse => {
                    if (mouse.button === Qt.RightButton) {
                        if (trayDelegate.modelData.hasMenu) {
                            const pos = trayDelegate.mapToItem(null, 0, 0);
                            menuAnchor.anchor.rect = Qt.rect(pos.x, pos.y + Theme.barHeight * 1.1, trayDelegate.width, trayDelegate.height);
                            menuAnchor.open();
                        } else
                            trayDelegate.modelData.secondaryActivate();
                    } else {
                        trayDelegate.modelData.activate();
                    }
                }
            }
        }
    }
}
