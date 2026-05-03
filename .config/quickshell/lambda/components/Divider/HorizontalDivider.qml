import QtQuick
import "../../core" as Core
Rectangle {
    readonly property color mainColor: Core.Theme.outline

    width: 50
    height: 1
    color: mainColor
    opacity: 0.2
    //anchors.leftMargin: 12
    //anchors.rightMargin: 12
}