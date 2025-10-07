pragma Singleton
import Quickshell

//import QtQuick

Singleton {
  readonly property int barHeight: 60
  property bool networkMenuOpen: false
  property var topbarPanel: null
  function closeAll() {
    networkMenuOpen = false
  }
    //property bool showBorders: false
}

