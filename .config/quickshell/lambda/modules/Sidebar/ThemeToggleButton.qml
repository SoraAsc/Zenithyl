import QtQuick
import "../../core" as Core

Item {
    id: root

    width:  40
    height: 40

    z: ma.containsMouse ? 100 : 1

    readonly property color accentColor: Core.Theme.primary || "#ffffff"

    // Outer ring - glows when overlay is open
    Rectangle {
        anchors.centerIn: parent
        width:  root.width + 6
        height: root.height + 6
        radius: (root.width + 6) / 2
        color:  "transparent"
        border.color: accentColor
        border.width: 1
        opacity: Core.ThemeState.selectorVisible ? 0.55 : 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    // Main circle button
    Rectangle {
        id: btn
        anchors.fill: parent
        radius: width / 2
        color:  ma.containsMouse
                ? Qt.rgba(accentColor.r, accentColor.g, accentColor.b, 0.25)
                : Qt.rgba(accentColor.r, accentColor.g, accentColor.b, Core.ThemeState.selectorVisible ? 0.30 : 0.1)

        border.color: accentColor
        border.width: 1
        opacity: 0.9

        Behavior on color { ColorAnimation { duration: 150 } }

        // Palette icon (2x2 grid of colored dots)
        Grid {
            anchors.centerIn: parent
            columns: 2
            spacing: 3

            Rectangle { width: 7; height: 7; radius: 3.5; color: accentColor }
            Rectangle { width: 7; height: 7; radius: 3.5; color: Core.Theme.secondary; opacity: 0.9 }
            Rectangle { width: 7; height: 7; radius: 3.5; color: Core.Theme.tertiary; opacity: 0.8 }
            Rectangle { width: 7; height: 7; radius: 3.5; color: Core.Theme.primaryContainer; opacity: 0.7 }
        }
    }

    // Tooltip
    Rectangle {
        id: tooltip
        anchors {
            left:           parent.right
            verticalCenter: parent.verticalCenter
            leftMargin:     12
        }
        width:  tooltipText.implicitWidth + 20
        height: 26
        radius: 6
        color:  Core.Theme.surfaceContainerHighest || "#32353a"
        border.color: Core.Theme.outlineVariant || "#43474e"
        border.width: 1
        visible: ma.containsMouse
        opacity: ma.containsMouse ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 150 } }

        layer.enabled: true
        Text {
            id: tooltipText
            anchors.centerIn: parent
            text:  Core.ThemeState.selectorVisible ? "CLOSE THEMES" : "THEMES"
            color: Core.Theme.primary
            font {
                family:      "JetBrains Mono, Monospace"
                pixelSize:   10
                letterSpacing: 1.2
                weight:      Font.Bold
            }
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape:  Qt.PointingHandCursor
        onClicked: {
            if (Core.ThemeState.selectorVisible) Core.ThemeState.close()
            else Core.ThemeState.open()
        }
    }

    // Rotate-in animation when accent changes
    RotationAnimator {
        target: btn
        from:   -8
        to:     0
        duration: 250
        easing.type: Easing.OutBack
        running: true
    }
}
