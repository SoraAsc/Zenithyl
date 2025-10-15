import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell.Io
import qs.core as Core
import qs.components

RowLayout {
  id: root
  spacing: 20
  property string timeString: ""
  property string dateString: ""

  Timer {
    id: clockTimer
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      var now = new Date()
      var hours = now.getHours().toString().padStart(2, "0")
      var minutes = now.getMinutes().toString().padStart(2, "0")
      root.timeString = hours + ":" + minutes
      root.dateString = Qt.formatDate(now, "MMM dd")
    }
  }

  Component.onCompleted: clockTimer.triggered()

  ColumnLayout {
    spacing: 0

    Text {
      text: root.timeString
      font.pixelSize: 14
      font.bold: true
      color: Core.Theme.colors.secondary
      horizontalAlignment: Text.AlignHCenter
      Layout.alignment: Qt.AlignHCenter
    }

    Text {
      text: root.dateString
      font.pixelSize: 12
      opacity: 0.5
      color: Core.Theme.colors.secondary
      horizontalAlignment: Text.AlignHCenter
      Layout.alignment: Qt.AlignHCenter
    }
  }

  Process {
    id: proc
    running: false
    command: [ "nwg-bar" ]
  }

  MouseArea {
    id: clickable
    width: 40
    height: 40
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      proc.startDetached()
    }
    ShadowContainer {
      anchors.fill: parent
      radiusSize: "full"
      borderWidth: 0
      enabledBorders: ({})
      shadowBlur: 40
      anchors.verticalCenter: parent.verticalCenter
      Text {
        id: powerIcon
        text: ""
        font.pixelSize: 25
        color: Core.Theme.colors.accent
        anchors.centerIn: parent
        layer.enabled: true
        layer.effect: MultiEffect {
          shadowEnabled: true
          shadowColor: Qt.lighter(Core.Theme.colors.accent, 2.2)
          blurMax: 30
        }

        states: State {
          name: "hovered"
          when: clickable.containsMouse
          PropertyChanges { target: powerIcon; scale: 1.05; color: Qt.lighter(Core.Theme.colors.accent, 10.3) }
        }

        transitions: Transition {
          NumberAnimation { properties: "scale"; duration: 200; easing.type: Easing.InOutQuad }
          ColorAnimation { properties: "color"; duration: 200 }
        }
      }
    }
  }
}
