import Quickshell
import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import qs.core as Core
import qs.components
import Quickshell.Services.UPower
import "./components" as Comp
Scope {
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
          spacing: parent.width / 3 - 92
          ShadowContainer {
            width: 45
            height: 45
            radiusSize: "full"
            shadowOffsetY: 2
            shadowBlur: 2
            borderWidth: 1
            borderColor: Core.Theme.colors.accent
            shadowColor: Qt.lighter(Core.Theme.colors.secondary, 1.2)

            Image {
              anchors.fill: parent
              anchors.margins: 6
              source: "../../assets/Wolf.png"
              anchors.centerIn: parent
              fillMode: Image.PreserveAspectFit
            }
          }
          RowLayout {
            spacing: 35
            Comp.WorkspaceComponent {}
            Comp.CurrentWorkspaceInfo {}
          }
          RowLayout {
            spacing: 10
              Comp.WorkspaceOptions {}
            Comp.VerticalLine {lineHeight: 40}
            Comp.CompactStatus {
              temperature: "50°C"
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
