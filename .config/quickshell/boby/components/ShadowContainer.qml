import Quickshell
import QtQuick
import QtQuick.Effects
import qs.core as Core

// I need to enable alpha
Item {
  id: root
  
  // Configurations
  property string radiusSize: "md"
  property color color: Core.Theme.colors.primary
  property color borderColor: Core.Theme.colors.secondary
  property double borderWidth: 0.5

  property color shadowColor: Qt.lighter(Core.Theme.colors.accent, 1.2)
  property int shadowOffsetY: 2
  property int shadowBlur: 10

  default property alias content: contentItem.children

  Rectangle {
    id: container
    anchors.fill: parent
    color: root.color
    radius: Core.Theme.getRadius(root.radiusSize, height)
    border.color: root.borderColor
    border.width: root.borderWidth

    layer.enabled: true
    layer.effect: MultiEffect {
      shadowEnabled: true
      shadowColor: root.shadowColor
      shadowVerticalOffset: root.shadowOffsetY
      blurMax: root.shadowBlur
    }
  }

  Item {
    id: contentItem
    anchors.fill: container
    z: container.z + 1
  }
}

