pragma Singleton
import QtQuick

QtObject {
    // Global theme options
    readonly property color fg: "#c5c9c5"
    readonly property color bg: "#000000"
    readonly property color barBg: "transparent"
    readonly property color accent: "#c5c9c5"
    readonly property color specialAccent: "#ff5148"
    readonly property color hovered: "#1c1c1c"
    readonly property int radius: 4

    readonly property color threshold: "#c9c5c9"
    readonly property color warning: "yellow"
    readonly property color critical: "red"

    // Font options
    readonly property string font: "JetBrainsMono Nerd Font Propo"
    readonly property int fontSize: 15

    // Bar options
    readonly property int barHeight: 40
    readonly property int topMargin: 2
    readonly property int leftMargin: 4
    readonly property int rightMargin: 4
    readonly property int buttonWidth: 16
    readonly property int barPadding: 8
    readonly property int workspaceSpacing: 0
    readonly property int systemTraySpacing: 8
    readonly property int widgetSpacing: 4
    readonly property int dividerSidesPadding: 4

    // Menu options
    readonly property int menuButtonSpacingHeight: 4
    readonly property int menuButtonSpacingWidth: 12
    readonly property int menuButtonGap: 0

    // Notification options
    readonly property int notificationWidth: 360
    readonly property int notificationIconSize: 36
    readonly property int notificationTimeout: 5000
    readonly property int notificationTimeoutUrgent: 60000

    // Wallpaper menu options
    readonly property int thumbnailWidth: 192
    readonly property int thumbnailHeight: 108
    readonly property int gridSpacingHeight: 4
    readonly property int gridSpacingWidth: 4
    readonly property int maxGridHeight: 1024
    readonly property int thumbnailColumns: 3
}
