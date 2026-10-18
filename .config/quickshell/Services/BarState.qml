pragma Singleton

import QtQuick

QtObject {
    property bool visible: true
    property bool fullscreenWindow: HyprlandService.fullscreenWindow
    property bool idleInhibited: false
}
