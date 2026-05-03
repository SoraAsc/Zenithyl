import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../core" as Core
Item {
    id: root

    readonly property int sidebarWidth: 56
    readonly property color bgColor: Core.Theme.background
    readonly property color accentColor: "#cba6f7"

    implicitWidth: sidebarWidth
    implicitHeight: parent?.height ?? 0

    Rectangle {
        anchors.fill: parent
        color: root.bgColor

        topLeftRadius: 0
        bottomLeftRadius: 0
        topRightRadius: 0
        bottomRightRadius: 0
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        SidebarTop {}
        SidebarMiddle { }
        SidebarBottom { }
    }

}