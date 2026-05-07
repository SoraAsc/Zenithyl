import QtQuick
import Quickshell
import "modules/Sidebar" as Sidebar
import "modules/HelpMenu" as HelpMenu

ShellRoot {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: shell

      required property var modelData
      screen: modelData

      anchors {
        left: true
        top: true
        bottom: true
      }
      implicitWidth: sidebar.sidebarWidth + 150

      color: "transparent"
      exclusiveZone: sidebar.sidebarWidth
      aboveWindows: false

      Sidebar.Sidebar {
        id: sidebar
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
      }
    }
  }
  Variants {
    model: Quickshell.screens

    HelpMenu.HelpWindow {}
  }
}