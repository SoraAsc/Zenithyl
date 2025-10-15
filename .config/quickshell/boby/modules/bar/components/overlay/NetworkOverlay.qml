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
  implicitHeight: 350
  visible: false
  //visible: true
  //visible: Core.Settings.networkMenuOpen || shadowContainer.height > 0
  color: "transparent"

  property alias menuHoverArea: menuHoverArea
  property var closeNetworkTimer

  ShadowContainer {
    id: shadowContainer
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right
    height: Core.Settings.networkMenuOpen ? parent.height - 10 : 0
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
    Behavior on height { 
      NumberAnimation {
        duration: 200
        easing.type: Easing.InOutQuad 
      } 
    }
    onHeightChanged: {
      if (height <= 0) root.visible = false
      else root.visible = true
    }

    MouseArea {
      id: menuHoverArea
      anchors.fill: parent
      hoverEnabled: true
      onEntered: Core.Settings.networkMenuOpen = true
      onExited: closeNetworkTimer.start()
    }
  }
}