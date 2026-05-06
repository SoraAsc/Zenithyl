import QtQuick
import "../../core" as Core

Item {
    id: root

    width:  40
    height: 40

    readonly property color accentColor: Core.Theme.primary

    // Outer ring - glows when help is open
    Rectangle {
        anchors.centerIn: parent
        width:  root.width + 6
        height: root.height + 6
        radius: (root.width + 6) / 2
        color:  "transparent"
        border.color: accentColor
        border.width: 1
        opacity: Core.HelpState.visible ? 0.55 : 0
        Behavior on opacity { NumberAnimation { duration: 200 } }
    }

    // Main circle button
    Rectangle {
        id: btn
        anchors.fill: parent
        radius: width / 2
        color:  ma.containsMouse
                ? Qt.rgba(
                      accentColor.r,
                      accentColor.g,
                      accentColor.b,
                      0.15)
                : "transparent"

        border.color: accentColor
        border.width: 1
        opacity: 0.8

        Behavior on color { ColorAnimation { duration: 150 } }

        Text {
            anchors.centerIn: parent
            text: "?"
            color: accentColor
            font { family: "JetBrains Mono"; pixelSize: 18; weight: Font.Bold }
        }
    }

    // Tooltip
    Rectangle {
        id: tooltip
        anchors {
            left:           parent.right
            verticalCenter: parent.verticalCenter
            leftMargin:     8
        }
        width:  tooltipText.implicitWidth + 16
        height: 22
        radius: 3
        color:  Core.Theme.surface || "#0f0505"
        border.color: Core.Theme.outline || "#2a1515"
        border.width: 1
        visible: ma.containsMouse
        opacity: ma.containsMouse ? 1 : 0
        Behavior on opacity { NumberAnimation { duration: 120 } }

        Text {
            id: tooltipText
            anchors.centerIn: parent
            text:  Core.HelpState.visible ? "CLOSE HELP" : "HELP"
            color: accentColor
            font { family: "JetBrains Mono"; pixelSize: 9; letterSpacing: 1.5; weight: Font.Medium }
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape:  Qt.PointingHandCursor
        onClicked: Core.HelpState.toggle()
    }
}
