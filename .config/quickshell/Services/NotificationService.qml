pragma Singleton

import Quickshell
import Quickshell.Services.Notifications as QsNotifications
import QtQuick

Singleton {
    id: root
    property var history: []
    property int nextId: 0
    property alias trackedNotifications: notificationServer.trackedNotifications
    QsNotifications.NotificationServer {
        id: notificationServer
        actionsSupported: true
        bodySupported: true
        imageSupported: true

        onNotification: notification => {
            notification.tracked = true;
            let updated = root.history.slice();
            updated.unshift({
                id: root.nextId++,
                summary: notification.summary,
                body: notification.body,
                appName: notification.appName,
                urgency: notification.urgency,
                time: Qt.formatDateTime(new Date(), "HH:mm")
            });
            root.history = updated;
        }
    }
    function clearHistory() {
        root.history = [];
    }

    function removeHistoryItem(id) {
        root.history = root.history.filter(item => item.id !== id);
    }
}
