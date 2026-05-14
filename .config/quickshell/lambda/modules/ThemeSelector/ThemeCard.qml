import QtQuick
import QtQuick.Effects
import Quickshell

Item {
    id: root

    property string themeName:   ""
    property string wallpaper:   ""
    property color  accentColor: "#EF4444"
    property color  bgColor:     "#1a0505"
    property bool   isSelected:  false
    property bool   isActive:    false    // currently applied theme

    signal clicked()

    Rectangle {
        id: cardBody
        anchors.fill: parent
        radius: 8
        color:  root.bgColor
        clip:   true

        Behavior on scale { NumberAnimation { duration: 200; easing.type: Easing.OutCubic } }

        // Preview image
        Loader {
            id: previewLoader
            anchors.fill: parent
            sourceComponent: (root.wallpaper && root.wallpaper.toLowerCase().endsWith(".gif")) ? animatedComp : (root.wallpaper ? staticComp : null)
            
            Component {
                id: staticComp
                Image {
                    anchors.fill: parent
                    source: root.wallpaper ? "file://" + Quickshell.shellDir + "/assets/themes/" + root.wallpaper : ""
                    fillMode: Image.PreserveAspectCrop
                    asynchronous: true
                    visible: status === Image.Ready
                    opacity: root.isSelected ? 0.95 : 0.7
                    Behavior on opacity { NumberAnimation { duration: 300 } }
                }
            }

            Component {
                id: animatedComp
                AnimatedImage {
                    anchors.fill: parent
                    source: root.wallpaper ? "file://" + Quickshell.shellDir + "/assets/themes/" + root.wallpaper : ""
                    fillMode: Image.PreserveAspectCrop
                    visible: status === AnimatedImage.Ready
                    opacity: root.isSelected ? 0.95 : 0.7
                    Behavior on opacity { NumberAnimation { duration: 300 } }
                }
            }
        }

        // Fallback gradient
        Rectangle {
            anchors.fill: parent
            visible: previewLoader.item && previewLoader.item.status !== Image.Ready && previewLoader.item.status !== AnimatedImage.Ready
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: Qt.darker(root.accentColor, 3.5) }
                GradientStop { position: 1.0; color: "#050202" }
            }
        }

        // Scrim
        Rectangle {
            anchors { left: parent.left; right: parent.right; bottom: parent.bottom }
            height: parent.height * 0.6
            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: "transparent" }
                GradientStop { position: 1.0; color: Qt.rgba(0, 0, 0, 0.85) }
            }
        }

        // Labels
        Text {
            anchors { left: parent.left; bottom: parent.bottom; margins: 14 }
            text:  root.themeName
            color: "#ffffff"
            font { family: "JetBrains Mono"; pixelSize: root.isSelected ? 14 : 12; weight: Font.Medium }
            Behavior on font.pixelSize { NumberAnimation { duration: 300 } }
        }

        // Status Icon
        Rectangle {
            anchors { right: parent.right; bottom: parent.bottom; margins: 12 }
            width: 20; height: 20; radius: 10
            color: root.accentColor
            visible: root.isActive
            Text { anchors.centerIn: parent; text: "✓"; color: "black"; font { pixelSize: 11; weight: Font.Bold } }
        }
    }

    // Outer glow
    layer.enabled: root.isSelected
    layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: root.accentColor
        shadowBlur: 0.8
        shadowScale: 1.02
    }

    MouseArea {
        anchors.fill: parent
        cursorShape: Qt.PointingHandCursor
        onClicked: root.clicked()
        hoverEnabled: true
        onEntered: if (!root.isSelected) cardBody.scale = 1.03
        onExited:  cardBody.scale = 1.0
    }
}
