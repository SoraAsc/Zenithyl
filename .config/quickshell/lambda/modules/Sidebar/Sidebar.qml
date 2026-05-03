import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../core" as Core
import "../../components/Divider" as Divider

Item {
    id: root

    readonly property int sidebarWidth: 56
    readonly property color bgColor: Core.Theme.surface

    implicitWidth: sidebarWidth
    implicitHeight: parent?.height ?? 0

    Rectangle {
        anchors.fill: parent
        color: root.bgColor
        opacity: 0.98

        topLeftRadius: 0
        bottomLeftRadius: 0
        topRightRadius: 0
        bottomRightRadius: 0

        Rectangle {
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            width: 1
            color: Core.Theme.outline
            opacity: 0.2
        }
    }

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        //anchors.verticalCenter: parent.verticalCenter
        //anchors.fill: parent
        spacing: 0

        SidebarTop {}
        Divider.HorizontalDivider {}
        SidebarMiddle { }
        Divider.HorizontalDivider {}
        SidebarBottom { }
    }

}