import QtQuick
import Quickshell.Widgets
import "../core" as Core
import QtQuick.Controls

AbstractButton {
    id: root

    property string iconSource: ""
    property int iconSize: 20
    property int buttonPadding: 8

    implicitWidth: iconSize + buttonPadding * 2
    implicitHeight: iconSize + buttonPadding * 2

    background: Rectangle {
        radius: 999
        color: Core.Theme.secondary
        opacity: root.hovered ? 0.15 : 0.0

        Behavior on opacity {
            NumberAnimation { duration: 120 }
        }
    }

    IconImage {
        anchors.centerIn: parent
        source: root.iconSource
        implicitSize: root.iconSize
    }
}