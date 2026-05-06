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
      implicitWidth: sidebar.width

      color: "transparent"
      exclusiveZone: sidebar.width
      aboveWindows: false

      Sidebar.Sidebar {
        id: sidebar
        anchors.fill: parent
      }
    }
  }
  Variants {
    model: Quickshell.screens

    HelpMenu.HelpWindow {}
  }
}