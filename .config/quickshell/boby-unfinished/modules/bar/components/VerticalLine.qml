import QtQuick
import qs.core as Core

Rectangle {
    id: root
    property color lineColor: Core.Theme.colors.secondary
    property int lineWidth: 1
    property int lineHeight: parent ? parent.height : 20
    property real opacityLevel: 0.5
    width: lineWidth
    height: lineHeight
    color: lineColor
    opacity: opacityLevel
    radius: width / 2
}

