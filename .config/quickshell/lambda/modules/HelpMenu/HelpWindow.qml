import QtQuick
import Quickshell
import "../../core" as Core

PanelWindow {
    id: helpWindow

    required property var modelData
    screen: modelData

    aboveWindows: true
    
    focusable: true

    property bool realVisible: Core.HelpState.visible
    visible: realVisible

    Timer {
        id: closeTimer
        interval: 300
        onTriggered: helpWindow.realVisible = false
    }

    Connections {
        target: Core.HelpState
        function onVisibleChanged() {
            if (Core.HelpState.visible) {
                closeTimer.stop()
                helpWindow.realVisible = true
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

    HelpOverlay {
        anchors.fill: parent
        focus: true
        visible: Core.HelpState.visible
        opacity: visible ? 1.0 : 0.0

        Behavior on opacity {
            NumberAnimation { duration: 250 }
        }

        onCloseRequested: Core.HelpState.close()
    }
}
