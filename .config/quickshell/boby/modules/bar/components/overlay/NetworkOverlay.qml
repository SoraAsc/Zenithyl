import Quickshell
import QtQuick
import qs.core as Core
import qs.components

PopupWindow {
  id: root
  property real posX: 0
  property real posY: 0
  anchor.window: Core.Settings.topbarPanel
  anchor.rect.x: posX
  anchor.rect.y: posY
  implicitWidth: 400
  implicitHeight: 450
  visible: true
  color: "transparent"
  ShadowContainer {
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: parent.height - 10
    borderWidth: 1
    borderColor: Core.Theme.colors.accent
    shadowOffsetY: 2
    shadowBlur: 10
    radiusCorners: ({
      bottomLeft: "lg",
      bottomRight: "lg"
    })
    enabledBorders: ({
      top: false,
      bottom: true,
      left: true,
      right: true,
    })
  }
}