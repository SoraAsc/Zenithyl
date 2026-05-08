import QtQuick
import Quickshell
import "../../core" as Core

PanelWindow {
    id: themeSelectorWindow

    required property var modelData
    screen: modelData

    aboveWindows: true

    focusable: true

    property bool realVisible: Core.ThemeState.selectorVisible
    visible: realVisible

    Timer {
        id: closeTimer
        interval: 350
        onTriggered: themeSelectorWindow.realVisible = false
    }

    Connections {
        target: Core.ThemeState
        function onSelectorVisibleChanged() {
            if (Core.ThemeState.selectorVisible) {
                closeTimer.stop()
                themeSelectorWindow.realVisible = true
            } else closeTimer.start()
        }
    }

    anchors {
        left:   true
        right:  true
        top:    true
        bottom: true
    }

    color: "transparent"

    ThemeSelectorOverlay {
        id: overlay
        anchors.fill: parent
        focus: true
        visible: Core.ThemeState.selectorVisible

        onCancelRequested: Core.ThemeState.close()
        onApplyRequested:  function(index, name) {
            Core.ThemeState.close()
        }
    }
}
