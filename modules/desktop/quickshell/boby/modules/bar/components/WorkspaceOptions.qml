import Quickshell
import QtQuick.Effects
import QtQuick.Layouts
import QtQuick
import qs.core as Core
import qs.components

import "./overlay" as Overlay
RowLayout {
  id: root
  spacing: 1

  /*Overlay.NetworkOverlay {
    posX: networkC.mapToGlobal(networkC.x, networkC.y)
  }*/

  MouseArea {
    id: networkC
    width: 40
    height: 40
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      if(Core.Settings.networkMenuOpen) Core.Settings.closeAll()
      else Core.Settings.networkMenuOpen = true
    }
    Text {
      id: networkIcon
      text: ""
      color: Core.Theme.colors.accent
      font.pixelSize: 22
      anchors.centerIn: parent
      layer.enabled: true
      layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: Qt.lighter(Core.Theme.colors.accent, 2.2)
        blurMax: 30
      }
      states: State {
        name: "hovered"
        when: networkC.containsMouse
        PropertyChanges { target: networkIcon; scale: 1.2; }
      }

      transitions: Transition {
        NumberAnimation { properties: "scale"; duration: 200; easing.type: Easing.InOutQuad }
        ColorAnimation { properties: "color"; duration: 200 }
      }
    }
  }

  MouseArea {
    id: configurationC
    width: 40
    height: 40
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: {
      if(Core.Settings.networkMenuOpen) Core.Settings.closeAll()
      else Core.Settings.networkMenuOpen = true
    }
    Text {
      id: configurationIcon
      text: "⚙"
      color: Core.Theme.colors.accent
      font.pixelSize: 50
      anchors.centerIn: parent
      layer.enabled: true
      layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: Qt.lighter(Core.Theme.colors.accent, 2.2)
        blurMax: 30
      }
      states: State {
        name: "hovered"
        when: configurationC.containsMouse
        PropertyChanges { target: configurationIcon; scale: 1.2; }
      }

      transitions: Transition {
        NumberAnimation { properties: "scale"; duration: 200; easing.type: Easing.InOutQuad }
        ColorAnimation { properties: "color"; duration: 200 }
      }
    }
  }

  Overlay.NetworkOverlay {
    property var pos: mapToGlobal(networkIcon.x, networkIcon.y)
    posX: pos.x
    posY: pos.y
  }

}
