import QtQuick
import QtQuick.Shapes
import "../core" as Core

Item {
    id: root

    // --- VALUES AND UNITS ---
    property real value: 0
    property real maxValue: 100
    property string label: ""
    property string unit: "°C" // "°C", "%", " RPM", etc.

    // --- THRESHOLDS ---
    property real warningThreshold: 75
    property real criticalThreshold: 90

    // --- COLORS ---
    property color normalColor: Core.Theme.primary
    property color warningColor: "#ff9800"
    property color criticalColor: "#ec1313"
    
    property int strokeWidth: 2
    property int size: 48

    implicitWidth: size
    implicitHeight: size

    readonly property color currentColor: {
        if (value >= criticalThreshold) return criticalColor;
        if (value >= warningThreshold) return warningColor;
        return normalColor;
    }

    readonly property real percentage: Math.min(Math.max(value / maxValue, 0), 1)

    Rectangle {
        anchors.fill: parent
        radius: width / 2
        color: "transparent"
        border.color: root.currentColor
        border.width: 1
        opacity: 0.15 
        Behavior on border.color { ColorAnimation { duration: 300 } }
    }

    Shape {
        id: shape
        anchors.fill: parent
        layer.enabled: true
        layer.samples: 8

        ShapePath {
            strokeColor: root.currentColor
            strokeWidth: root.strokeWidth
            fillColor: "transparent"
            capStyle: ShapePath.RoundCap

            Behavior on strokeColor { ColorAnimation { duration: 300 } }

            PathAngleArc {
                centerX: root.size / 2
                centerY: root.size / 2
                radiusX: (root.size - root.strokeWidth) / 2
                radiusY: (root.size - root.strokeWidth) / 2
                
                startAngle: -90 
                sweepAngle: 360 * root.percentage
                
                Behavior on sweepAngle {
                    NumberAnimation { duration: 600; easing.type: Easing.OutCubic }
                }
            }
        }
    }

    Column {
        anchors.centerIn: parent
        spacing: -2

        Text {
            anchors.horizontalCenter: parent.horizontalCenter
            text: Math.round(root.value) + root.unit
            font.pixelSize: root.size * 0.25
            font.weight: Font.Bold
            color: root.currentColor
            Behavior on color { ColorAnimation { duration: 300 } }
        }

        Text {
            visible: root.label !== ""
            anchors.horizontalCenter: parent.horizontalCenter
            text: root.label
            font.pixelSize: root.size * 0.15
            font.weight: Font.Medium
            color: root.currentColor
            opacity: 0.6
            Behavior on color { ColorAnimation { duration: 300 } }
        }
    }
}