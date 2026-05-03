import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell
import Quickshell.Hyprland
import "../core" as Core
import "../core/NumberUtils.js" as NumberUtils

Item {
    id: root

    // === CONFIG ===
    readonly property int activeSize: 22
    readonly property int inactiveSize: 10
    readonly property int spacing: 6          // distance between items in base grid
    readonly property int activeOffset: 12    // how far active item "jumps out"
    readonly property int pressOffset: 0      // slight Y push

    // === WORKSPACE STATE ===
    readonly property var activeWs: Hyprland.focusedMonitor?.activeWorkspace ?? null
    readonly property int currentWsId: activeWs?.id ?? 1

    // Determine which group of 4 workspaces we are showing
    readonly property int startId: Math.floor((currentWsId - 1) / 4) * 4 + 1

    implicitWidth: 46
    implicitHeight: 46

    Item {
        id: container
        anchors.centerIn: parent
        width: 30
        height: 30

        Repeater {
            model: 4

            delegate: Item {
                id: wrapper

                // === WORKSPACE INFO ===
                readonly property int wsId: root.startId + index
                readonly property bool isActive: root.currentWsId === wsId

                // === GRID POSITION (2x2) ===
                readonly property bool isLeft: index % 2 === 0
                readonly property bool isTop: index < 2

                // === ACTIVE POSITION (normalized to 0..3 inside current group) ===
                readonly property int activeIndex: root.currentWsId - root.startId
                readonly property bool activeIsLeft: activeIndex % 2 === 0
                readonly property bool activeIsTop: activeIndex < 2

                // === BASE GRID POSITION ===
                readonly property real baseX: isLeft ? -root.spacing : root.spacing
                readonly property real baseY: isTop ? -root.spacing : root.spacing

                // === GROUP SHIFT (push everything away from active item) ===
                readonly property real shiftX: activeIsLeft ? 1 : -1
                readonly property real shiftY: activeIsTop ? 1 : -1

                // === FINAL POSITION ===
                x: (container.width / 2) + (
                       isActive
                       ? (isLeft ? -root.activeOffset : root.activeOffset)
                       : baseX + shiftX
                   )

                y: (container.height / 2) + (
                       isActive
                       ? ((isTop ? -root.activeOffset : root.activeOffset) + root.pressOffset)
                       : baseY + shiftY
                   )

                // === ANIMATIONS ===
                Behavior on x {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutBack
                        easing.overshoot: 1.2
                    }
                }

                Behavior on y {
                    NumberAnimation {
                        duration: 300
                        easing.type: Easing.OutBack
                        easing.overshoot: 1.2
                    }
                }

                Rectangle {
                    id: rect
                    anchors.centerIn: parent

                    // === SIZE & SHAPE ===
                    width: wrapper.isActive ? root.activeSize : root.inactiveSize
                    height: wrapper.isActive ? root.activeSize : root.inactiveSize
                    radius: wrapper.isActive ? width / 2 : 2
                    z: wrapper.isActive ? 10 : 1

                    // === STYLE ===
                    color: wrapper.isActive
                           ? Core.Theme.primary
                           : Qt.rgba(1, 1, 1, 0.15)

                    border.color: wrapper.isActive
                                  ? Core.Theme.surface
                                  : "transparent"

                    border.width: wrapper.isActive ? 1.5 : 0

                    // === ANIMATIONS ===
                    Behavior on width {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutBack
                            easing.overshoot: 1.4
                        }
                    }

                    Behavior on height {
                        NumberAnimation {
                            duration: 250
                            easing.type: Easing.OutBack
                            easing.overshoot: 1.4
                        }
                    }

                    Behavior on color {
                        ColorAnimation { duration: 500 }
                    }

                    // === LABEL ===
                    Text {
                        anchors.centerIn: parent
                        text: NumberUtils.toRoman(wrapper.wsId)

                        font.pixelSize: 9
                        font.weight: Font.Bold

                        color: Core.Theme.surface

                        opacity: wrapper.isActive ? 1 : 0
                        scale: wrapper.isActive ? 1 : 0.5

                        Behavior on opacity {
                            NumberAnimation { duration: 150 }
                        }

                        Behavior on scale {
                            NumberAnimation { duration: 200 }
                        }
                    }
                }

                MouseArea {
                    anchors.fill: parent
                    anchors.margins: -10
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        Hyprland.dispatch("workspace " + wrapper.wsId)
                    }
                }
            }
        }
    }
}