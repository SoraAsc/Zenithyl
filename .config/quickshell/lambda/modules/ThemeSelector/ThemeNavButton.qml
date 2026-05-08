import QtQuick
import "../../core" as Core

Item {
    id: root

    property string direction: "right"   // "left" | "right"
    signal clicked()

    width:  42
    height: 42

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color:  ma.containsMouse && root.enabled ? Qt.rgba(1, 1, 1, 0.08) : "transparent"
        border.color: root.enabled ? Core.Theme.outline : Qt.rgba(1, 1, 1, 0.05)
        border.width: 1.5
        opacity: root.enabled ? 1.0 : 0.2
        
        Behavior on color { ColorAnimation { duration: 150 } }

        Text {
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -2 
            
            text:  root.direction === "left" ? "‹" : "›"
            color: Core.Theme.onSurface || "#ffffff"
            font { 
                family: "JetBrains Mono"
                pixelSize: 28
                weight: Font.Light 
            }
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
        }
    }

    MouseArea {
        id: ma
        anchors.fill: parent
        hoverEnabled: true
        cursorShape:  root.enabled ? Qt.PointingHandCursor : Qt.ArrowCursor
        enabled:      root.enabled
        onClicked:    root.clicked()
    }
}
