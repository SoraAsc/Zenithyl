import QtQuick
import QtQuick.Layouts
import Quickshell
import QtQuick.Effects
import qs.core as Core

RowLayout {
  id: root
  property int controlSpacing: 20
  spacing: controlSpacing
  
  // state
  property string temperature: "--°C"    // ex: "23°C"
  property int batteryPercent: -1        // -1 = unknown
  property bool batteryCharging: false

  /*******************
    * Helpers / colors *
  *******************/
  function tempValue() {
    var m = root.temperature ? root.temperature.toString().match(/-?\d+/) : null;
    return m ? parseInt(m[0], 10) : null;
  }

  function tempColor() {
    var v = tempValue();
    if (v === null) return "#ffffff";           // unknown -> branco
    if (v <= 0) return "#4DB8FF";               // cold -> light blue
    if (v >= 60) return "#FF4D4D";              // extremo quente -> vermelho
    if (v >= 50) return "#FF8C42";              // hot -> orange
    return "#2DD4BF";                           // normal -> teal
  }

  function batteryColor() {
    if (root.batteryCharging) return "#4DB8FF"; // charging -> blue
    if (root.batteryPercent < 0) return "#FFFFFF"; // unknown -> white
    if (root.batteryPercent <= 20) return "#FF4D4D"; // low -> vermelho
    if (root.batteryPercent >= 95) return "#FFD166"; // nearly full -> yellow/gold
    return "#4CD137";
  }

    /******************
     * TEMP AREA
     ******************/
    RowLayout {
        id: tempArea
        spacing: 6
        ColumnLayout {
            spacing: 2
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

            Text {
                id: tempText
                text: root.temperature
                font.pixelSize: 12
                font.bold: true
                color: tempColor()
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                scale: 1.0
            }

            Text {
                text: "Temp"
                font.pixelSize: 11
                opacity: 0.65
                color: "#CCCCCC"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }

        SequentialAnimation {
            id: tempPulse
            running: (tempValue() !== null) && (tempValue() <= 0 || tempValue() >= 50)
            loops: Animation.Infinite

            NumberAnimation {
                target: tempText
                property: "scale"
                from: 1.0; to: 1.06
                duration: 600
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: tempText
                property: "scale"
                from: 1.06; to: 1.0
                duration: 600
                easing.type: Easing.InOutQuad
            }
        }
    }

    /******************
     * BATTERY AREA
     ******************/
    RowLayout {
        id: batArea
        spacing: 6

        ColumnLayout {
            spacing: 2
            Layout.alignment: Qt.AlignVCenter | Qt.AlignHCenter

            Text {
                id: batText
                text: (root.batteryPercent >= 0) ? (root.batteryPercent + "%") : "--"
                font.pixelSize: 12
                font.bold: true
                color: batteryColor()
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
                opacity: 1.0
            }

            Text {
                text: root.batteryCharging ? "Charging" : "Battery"
                font.pixelSize: 11
                opacity: 0.65
                color: "#CCCCCC"
                horizontalAlignment: Text.AlignHCenter
                Layout.alignment: Qt.AlignHCenter
            }
        }

        SequentialAnimation {
            id: batPulse
            running: (root.batteryPercent >= 0) && (root.batteryPercent <= 20 || root.batteryPercent >= 95)
            loops: Animation.Infinite

            NumberAnimation {
                target: batText
                property: "opacity"
                from: 1.0; to: 0.6
                duration: 700
                easing.type: Easing.InOutQuad
            }
            NumberAnimation {
                target: batText
                property: "opacity"
                from: 0.6; to: 1.0
                duration: 700
                easing.type: Easing.InOutQuad
            }
        }
    }
}
