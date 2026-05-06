import QtQuick
import QtQuick.Layouts
import Quickshell
import "../../core" as Core

Item {
    id: root

    signal closeRequested()

    readonly property color accentColor: Core.Theme.primary
    readonly property color bgColor: Core.Theme.surfaceContainer
    readonly property color cardColor: Core.Theme.surfaceContainerHigh
    readonly property color textColor: Core.Theme.onSurface
    readonly property color subTextColor: Core.Theme.onSurfaceVariant

    Rectangle {
        anchors.fill: parent
        color: root.bgColor
        opacity: 0.98

        MouseArea {
            anchors.fill: parent
            onClicked: root.closeRequested()
        }
    }

    ColumnLayout {
        anchors.centerIn: parent
        width: Math.min(parent.width * 0.8, 650)
        spacing: 40

        // Header
        Column {
            Layout.alignment: Qt.AlignLeft
            spacing: 12
            Text {
                text: "SYSTEM SHORTCUTS"
                color: root.accentColor
                font { family: "JetBrains Mono"; pixelSize: 28; weight: Font.Bold; letterSpacing: 4 }
            }
            Rectangle { 
                width: 100; height: 4; 
                radius: 2
                color: root.accentColor 
            }
        }

        // Shortcut List
        GridLayout {
            columns: 2
            columnSpacing: 30
            rowSpacing: 20
            Layout.fillWidth: true

            HelpItem { key: "Super + B"; desc: "Open Web Browser" }
            HelpItem { key: "Super + Enter"; desc: "Open Terminal" }
            HelpItem { key: "Super + Space"; desc: "File Explorer" }
            HelpItem { key: "Super + ESC"; desc: "Open/Close Sidebar" }
        }

        // Close Hint
        Text {
            Layout.alignment: Qt.AlignHCenter
            text: "Press ESC or click anywhere to close"
            color: root.subTextColor
            opacity: 0.7
            font { family: "JetBrains Mono"; pixelSize: 13; italic: true; weight: Font.Medium }
        }
    }

    // Component for shortcut items
    component HelpItem : RowLayout {
        property string key: ""
        property string desc: ""
        Layout.fillWidth: true
        spacing: 16

        Rectangle {
            Layout.preferredWidth: 160
            Layout.preferredHeight: 38
            color: root.cardColor
            radius: 8
            border.color: Core.Theme.outlineVariant || "#43474e"
            border.width: 1

            Text {
                anchors.centerIn: parent
                text: parent.parent.key
                color: root.accentColor
                font { family: "JetBrains Mono"; pixelSize: 13; weight: Font.Bold }
            }
        }

        Text {
            Layout.fillWidth: true
            text: parent.desc
            color: root.textColor
            font { family: "JetBrains Mono"; pixelSize: 15; weight: Font.Medium }
        }
    }

    // Key handling
    focus: true
    Keys.onEscapePressed: (event) => {
        root.closeRequested();
        event.accepted = true;
    }

    onVisibleChanged: {
        if (visible) root.forceActiveFocus();
    }
}
