import QtQuick
import "../../core" as Core
Rectangle {
    readonly property color mainColor: Core.Theme.outline
    anchors 
    {
        left: parent.left
        right: parent.right
    }
    implicitWidth: 40
    implicitHeight: 1
    color: mainColor
    opacity: 0.2
    anchors.leftMargin: 12
    anchors.rightMargin: 12
}