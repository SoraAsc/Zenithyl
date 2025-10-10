import Quickshell
import QtQuick
import qs.core as Core
  PopupWindow {
    id: root
    property real posX: 0
    property real posY: 0
    Component.onCompleted: console.log(posX)
    anchor.window: Core.Settings.topbarPanel
    anchor.rect.x: posX//300
    anchor.rect.y: posY//-480
    implicitWidth: 50
    implicitHeight: 50
    visible: false
    color: "white"
  }
  //color: "transparent"
  //exclusionMode: ExclusionMode.Ignore
  //visible: true   // depois trocar pelo Core.Settings.networkMenuOpen

