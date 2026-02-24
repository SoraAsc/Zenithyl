pragma Singleton
import Quickshell

Singleton {
  readonly property int barHeight: 50
  property bool networkMenuOpen: false
  property var topbarPanel: null
  function closeAll() {
    networkMenuOpen = false
  }
}

