import QtQuick
import QtQuick.Layouts
import Quickshell
//import "../../components" as Components
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
    }

}