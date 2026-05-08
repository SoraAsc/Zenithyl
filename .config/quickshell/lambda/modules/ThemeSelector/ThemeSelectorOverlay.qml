import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import "../../core" as Core

Item {
    id: root

    signal cancelRequested()
    signal applyRequested(int index, string themeName)

    // Internal state
    property int previewIndex: Core.ThemeState.selectedIndex

    readonly property var themes: Core.ThemeState.themes
    readonly property int themeCount: themes.length

    // Card geometry
    readonly property int centerW: 340
    readonly property int centerH: 230
    readonly property int sideW:   200
    readonly property int sideH:   170
    readonly property int cardSpacing: 30

    opacity: 1

    onVisibleChanged: {
        if (visible) previewIndex = Core.ThemeState.selectedIndex
    }

    // Backdrop and image
    Rectangle {
        anchors.fill: parent
        color: Core.Theme.surfaceContainer
        opacity: 0.98

        Rectangle {
            anchors.fill: parent
            color: themes[previewIndex]?.bg || "transparent"
            opacity: 0.35
            Behavior on color { ColorAnimation { duration: 600 } }
        }

        Loader {
            id: bgPreviewLoader
            anchors.fill: parent
            sourceComponent: (themes[previewIndex]?.wallpaper && themes[previewIndex].wallpaper.toLowerCase().endsWith(".gif")) ? animBg : staticBg
            opacity: 0.12
            layer.enabled: true
            layer.effect: MultiEffect { blurEnabled: true; blur: 1.0; blurMax: 64 }

            Component {
                id: staticBg
                Image {
                    anchors.fill: parent
                    source: themes[previewIndex]?.wallpaper ? "file://" + Quickshell.shellDir + "/assets/themes/" + themes[previewIndex].wallpaper : ""
                    fillMode: Image.PreserveAspectCrop
                    visible: status === Image.Ready
                }
            }

            Component {
                id: animBg
                AnimatedImage {
                    anchors.fill: parent
                    source: themes[previewIndex]?.wallpaper ? "file://" + Quickshell.shellDir + "/assets/themes/" + themes[previewIndex].wallpaper : ""
                    fillMode: Image.PreserveAspectCrop
                    visible: status === AnimatedImage.Ready
                }
            }
        }
    }

    // Header
    Item {
        id: header
        anchors { top: parent.top; left: parent.left; right: parent.right; topMargin: 70; leftMargin: 80; rightMargin: 80 }
        height: 50

        Column {
            anchors.left: parent.left
            spacing: 6
            Text {
                text: "THEME SELECTOR"
                color: themes[previewIndex]?.accent || "white"
                font { family: "JetBrains Mono"; pixelSize: 18; weight: Font.Bold; letterSpacing: 5 }
                Behavior on color { ColorAnimation { duration: 400 } }
            }
            Rectangle { width: 60; height: 2; color: themes[previewIndex]?.accent || "white"; opacity: 0.6 }
        }

        // Restored Pagination Text
        Text {
            anchors.right: parent.right; anchors.verticalCenter: parent.verticalCenter
            text: (previewIndex + 1).toString().padStart(2, "0") + " / " + themeCount.toString().padStart(2, "0")
            color: Core.Theme.onSurface || "white"
            opacity: 0.5
            font { family: "JetBrains Mono"; pixelSize: 22; weight: Font.ExtraLight }
        }
    }

    // Carousel
    Item {
        id: carouselArea
        anchors { top: header.bottom; bottom: dotsRow.top; left: parent.left; right: parent.right; topMargin: 20; bottomMargin: 20 }

        ThemeNavButton {
            id: leftArrow
            anchors { left: parent.left; leftMargin: 60; verticalCenter: parent.verticalCenter }
            direction: "left"
            onClicked: previewIndex = (previewIndex - 1 + themeCount) % themeCount
        }

        ThemeNavButton {
            id: rightArrow
            anchors { right: parent.right; rightMargin: 60; verticalCenter: parent.verticalCenter }
            direction: "right"
            onClicked: previewIndex = (previewIndex + 1) % themeCount
        }

        Item {
            anchors { left: leftArrow.right; right: rightArrow.left; top: parent.top; bottom: parent.bottom }
            clip: true

            Repeater {
                model: themes
                delegate: ThemeCard {
                    readonly property var modelDataValue: modelData
                    readonly property int indexValue: index

                    readonly property int offset: {
                        let diff = indexValue - previewIndex;
                        if (diff > themeCount / 2) diff -= themeCount;
                        if (diff < -themeCount / 2) diff += themeCount;
                        return diff;
                    }

                    themeName:   modelDataValue.name
                    accentColor: modelDataValue.accent
                    bgColor:     modelDataValue.bg
                    wallpaper:   modelDataValue.wallpaper || ""
                    isSelected:  indexValue === previewIndex
                    isActive:    indexValue === Core.ThemeState.selectedIndex

                    width:  isSelected ? centerW : sideW
                    height: isSelected ? centerH : sideH
                    z: isSelected ? 100 : (10 - Math.abs(offset))
                    opacity: Math.abs(offset) > 1.1 ? 0.0 : (isSelected ? 1.0 : 0.4)
                    visible: opacity > 0

                    anchors.verticalCenter: parent.verticalCenter
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.horizontalCenterOffset: offset * (sideW + cardSpacing)

                    scale: isSelected ? 1.0 : 0.8

                    Behavior on anchors.horizontalCenterOffset {
                        NumberAnimation {
                            id: posAnim
                            duration: 400
                            easing.type: Easing.OutCubic
                        }
                    }

                    Behavior on opacity { NumberAnimation { duration: 150 } }
                    Behavior on scale   { NumberAnimation { duration: 400; easing.type: Easing.OutCubic } }

                    onClicked: previewIndex = indexValue
                }
            }
        }
    }

    // Pagination Dots
    Row {
        id: dotsRow
        anchors { bottom: buttonRow.top; horizontalCenter: parent.horizontalCenter; bottomMargin: 40 }
        spacing: 12

        Repeater {
            model: themeCount
            Rectangle {
                width: index === previewIndex ? 24 : 8
                height: 8
                radius: 4
                color: index === previewIndex ? (themes[previewIndex]?.accent || "white") : Core.Theme.outline || "#444"
                opacity: index === previewIndex ? 1.0 : 0.4
                Behavior on width { NumberAnimation { duration: 300; easing.type: Easing.OutCubic } }
                Behavior on color { ColorAnimation { duration: 300 } }
                
                MouseArea {
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    onClicked: previewIndex = index
                }
            }
        }
    }

    // Actions
    Row {
        id: buttonRow
        anchors { bottom: parent.bottom; horizontalCenter: parent.horizontalCenter; bottomMargin: 80 }
        spacing: 24

        Rectangle {
            width: 200; height: 50; radius: 8
            color: applyMa.containsMouse ? Qt.lighter(themes[previewIndex]?.accent || "white", 1.1) : (themes[previewIndex]?.accent || "white")
            
            Text {
                anchors.centerIn: parent
                text: "APPLY THEME"
                color: Core.Theme.onPrimary
                font { family: "JetBrains Mono"; pixelSize: 13; weight: Font.Bold; letterSpacing: 1 }
            }

            MouseArea {
                id: applyMa; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                onClicked: {
                    const theme = themes[previewIndex]
                    if (!theme) return
                    themeProcess.command = [
                        Quickshell.shellDir + "/scripts/apply-theme.sh", 
                        Quickshell.shellDir + "/assets/themes/" + theme.wallpaper,
                        previewIndex.toString()
                    ]
                    themeProcess.running = true
                    Core.ThemeState.selectedIndex = previewIndex
                    root.applyRequested(previewIndex, theme.name)
                    root.cancelRequested() 
                }
            }
        }

        Rectangle {
            width: 140; height: 50; radius: 8
            color: "transparent"
            border.color: Core.Theme.outline || "#444"
            border.width: 1.5
            
            Rectangle {
                anchors.fill: parent; radius: 8; color: "white"; opacity: cancelMa.containsMouse ? 0.1 : 0
            }

            Text {
                anchors.centerIn: parent
                text: "CANCEL"
                color: Core.Theme.onSurface || "white"
                font { family: "JetBrains Mono"; pixelSize: 13; weight: Font.Medium }
            }

            MouseArea {
                id: cancelMa; anchors.fill: parent; hoverEnabled: true; cursorShape: Qt.PointingHandCursor
                onClicked: {
                    previewIndex = Core.ThemeState.selectedIndex
                    root.cancelRequested() 
                }
            }
        }
    }

    Process { id: themeProcess }

    focus: true
    Keys.onLeftPressed:   previewIndex = (previewIndex - 1 + themeCount) % themeCount
    Keys.onRightPressed:  previewIndex = (previewIndex + 1) % themeCount
    Keys.onReturnPressed: applyMa.clicked(null)
    Keys.onEscapePressed: cancelMa.clicked(null)
}
