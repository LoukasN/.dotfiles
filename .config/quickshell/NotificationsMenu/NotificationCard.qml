import Quickshell.Services.Notifications as QsNotifications
import QtQuick
import QtQuick.Layouts

import "../Services/"

Rectangle {
    id: card
    required property var modelData
    property bool isHistory: false
    signal removeRequested
    Layout.fillWidth: true
    implicitHeight: Math.max(layout.implicitHeight + Theme.barPadding * 2, Theme.barHeight)
    color: Theme.bg
    border.color: modelData.urgency === QsNotifications.NotificationUrgency.Critical ? Theme.critical : Theme.accent
    radius: Theme.radius

    MouseArea {
        anchors.fill: parent
        onClicked: {
            if (card.isHistory) {
                card.removeRequested();
                return;
            }
            const defaultAction = card.modelData.actions.find(action => action.identifier === "default");
            if (defaultAction) {
                defaultAction.invoke();
            } else {
                card.modelData.dismiss();
            }
        }
    }

    Timer {
        running: !card.isHistory && card.modelData.urgency !== QsNotifications.NotificationUrgency.Critical
        interval: Theme.notificationTimeout
        onTriggered: card.modelData.dismiss()
    }

    Timer {
        running: !card.isHistory && card.modelData.urgency === QsNotifications.NotificationUrgency.Critical
        interval: Theme.notificationTimeoutUrgent
        onTriggered: card.modelData.dismiss()
    }

    RowLayout {
        id: layout
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Theme.barPadding
        spacing: Theme.widgetSpacing

        Image {
            Layout.preferredHeight: Theme.notificationIconSize
            Layout.preferredWidth: Theme.notificationIconSize
            Layout.alignment: Qt.AlignHCenter
            fillMode: Image.PreserveAspectFit
            visible: source.toString() !== ""
            source: card.modelData.image || card.modelData.appicon || ""
        }

        ColumnLayout {
            Layout.fillWidth: true
            spacing: Theme.widgetSpacing
            Text {
                Layout.fillWidth: true
                text: card.modelData.summary
                color: Theme.accent
                font.family: Theme.font
                font.pixelSize: Theme.fontSize + 1
                font.bold: true
                elide: Text.ElideRight
            }

            Text {
                Layout.fillWidth: true
                visible: text !== ""
                text: card.modelData.body
                color: Theme.fg
                font.family: Theme.font
                font.pixelSize: Theme.fontSize
                wrapMode: Text.WordWrap
            }
        }
    }
}
