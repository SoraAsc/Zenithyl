import Quickshell
import QtQuick
import Quickshell.Hyprland
import qs.core as Core

Row {
  spacing: 10
  x: 180
  anchors.verticalCenter: parent.verticalCenter
  // Ícone Spotify
  Rectangle {
    width: 32; height: 32
    color: "transparent"
    Image {
      anchors.fill: parent
      source: "../../../assets/Spotify.svg"
    }
    MouseArea {
      anchors.fill: parent
      onClicked: Hyprland.dispatch("workspace name:spotify")
    }
  }

  // Ícone Discord
  Rectangle {
    width: 32; height: 32
    color: "transparent"
    Image {
      anchors.fill: parent
      source: "../../../assets/Discord.svg"
    }
    MouseArea {
      anchors.fill: parent
      onClicked: {
        Hyprland.dispatch("workspace discord")
        //Qt.openUrlExternally("discord://")
      }
    }
  }
}

