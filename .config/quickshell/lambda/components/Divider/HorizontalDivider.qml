import QtQuick
import QtQuick.Layouts
import "../../core" as Core
Rectangle {
    readonly property color mainColor: Core.Theme.outline
    Layout.fillWidth: true
    Layout.leftMargin: 12
    Layout.rightMargin: 12
    implicitHeight: 1
    color: mainColor
    opacity: 0.2
}