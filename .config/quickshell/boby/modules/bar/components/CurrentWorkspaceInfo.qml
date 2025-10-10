import QtQuick
import Quickshell
import QtQuick.Layouts
import Quickshell.Hyprland
import qs.core as Core

RowLayout {
  Layout.preferredWidth: 30
  spacing: 10
  function formatAppTitle(title) {
    if (!title) return "~/";
    title = title.trim();
    if (title.startsWith("~/")) return title;
    return "~/" + title;
  }
  Image {
    id: appImage
    width: 25
    height: 25
    source: "../../../assets/Terminal.png"
    fillMode: Image.PreserveAspectFit
    cache: true
    Layout.preferredWidth: width
    Layout.preferredHeight: height
  }


  ColumnLayout {
    id: content
    spacing: 1

    Text {
      id: titleText
      Layout.preferredWidth: parent.width
      text: formatAppTitle(Hyprland.activeToplevel?.title ?? "~/")
      font.pixelSize: 13
      font.bold: true
      elide: Text.ElideRight
      wrapMode: Text.NoWrap
      color: Core.Theme.colors.secondary
    }

    Text {
      id: subtitleText
      text: "Hyprland • Wayland • QuickShell"
      font.pixelSize: 11
      opacity: 0.6
      elide: Text.ElideRight
      wrapMode: Text.NoWrap
      color: Core.Theme.colors.secondary
    }
  }
}
