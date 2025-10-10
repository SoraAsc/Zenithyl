import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import qs.core as Core
import qs.components
import Quickshell.Services.UPower
import Quickshell.Io

import "./components" as Comp

Scope {
  id: root
  property string temperature: "--ºC"
  Process {
    id: tempProcess
    running: true
    command: ["sh", "-c", "cat /sys/class/thermal/thermal_zone*/temp"]
    stdout: StdioCollector {
      onStreamFinished: {
        root.temperature = (Number(text) / 1000) + "ºC"
      }
    }
  }
  Timer {
    id: tempClockTimer
    interval: 5000
    running: true
    repeat: true
    onTriggered: {
      tempProcess.running = true
    }
  }

  Component.onCompleted: tempClockTimer.triggered()
  Variants {
    model: Quickshell.screens
    PanelWindow {
      id: rootW
      property var modelData
      property int realHeight: {
        const h = Core.Settings.barHeight // Height
        const topMarginLostH = Core.Theme.size["md"]
        const borderLostH = 0.5
        return h + topMarginLostH + borderLostH
      }
      screen: modelData
      anchors {
        top: true
        bottom: false
        left: true
        right: true
      }
      color: "transparent"
      implicitHeight: realHeight
      Component.onCompleted: Core.Settings.topbarPanel = rootW
      Component.onDestruction: {
        if(Core.Settings.topbarPanel === rootW)
          Core.Settings.topbarPanel = null
      }

      // Bar Container
      ShadowContainer {
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: Core.Theme.size["sm"]
        height: Core.Settings.barHeight
        shadowOffsetY: 2
        shadowBlur: 10
        // Main Icon
        RowLayout {
          x: 20
          anchors.verticalCenter: parent.verticalCenter
          spacing: parent.width / 3 - 45
          ShadowContainer {
            width: 32
            height: 32
            radiusSize: "full"
            shadowOffsetY: 2
            shadowBlur: 2
            borderWidth: 1
            borderColor: Core.Theme.colors.accent
            shadowColor: Qt.lighter(Core.Theme.colors.secondary, 1.2)

            Image {
              anchors.fill: parent
              anchors.margins: 5
              source: "../../assets/Wolf.png"
              anchors.centerIn: parent
              fillMode: Image.PreserveAspectFit
            }
          }
          RowLayout {
            spacing: 25
            Comp.WorkspaceComponent {}
            Comp.CurrentWorkspaceInfo {}
          }
          RowLayout {
            spacing: 10
            Comp.WorkspaceOptions {}
            Comp.VerticalLine {lineHeight: 40}
            Comp.CompactStatus {
              temperature: root.temperature
              batteryPercent: UPower.displayDevice.isLaptopBattery ? Math.round(UPower.displayDevice.percentage * 100) : -1
              batteryCharging: !UPower.onBattery ?? false
            }
            Comp.VerticalLine {lineHeight: 40}
            Comp.DatePowerInfo {}
          }
        }
      }
    }
  }
}         
