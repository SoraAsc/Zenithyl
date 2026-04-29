import Quickshell
import QtQuick
//import "components"

ShellRoot {
  id: root
  Variants {
    model: Quickshell.screens
    Scope {
      id: scope
      required property var modelData
    }
  }
}
