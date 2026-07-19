//@ pragma UseQApplication

import Quickshell
import QtQuick
import "./Bar/"
import "./ShutdownMenu/"
import "./NotificationsMenu/"
import "./Services/"
import "./NetworkMenu/"
import "./WallpaperMenu/"
import "./BluetoothMenu/"

Scope {
    NetworkMenu {
        id: networkMenu
    }
    BluetoothMenu {
        id: bluetoothMenu
    }
    Bar {
        networkMenu: networkMenu
        bluetoothMenu: bluetoothMenu
    }
    ShutdownMenu {}
    NotificationPopups {
        notifications: NotificationService.trackedNotifications
    }
    NotificationMenu {}
    WallpaperMenu {}
}
