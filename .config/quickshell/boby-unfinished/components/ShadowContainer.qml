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

  property var radiusCorners: ({
    topLeft: radiusSize,
    topRight: radiusSize,
    bottomLeft: radiusSize,
    bottomRight: radiusSize
  })

  property var enabledBorders: ({
    left: true,
    right: true,
    top: true,
    bottom: true
  })

  property color shadowColor: Qt.lighter(Core.Theme.colors.accent, 1.2)
  property int shadowOffsetY: 2
  property int shadowBlur: 10

  default property alias content: contentItem.children

  Rectangle {
    id: container
    anchors.fill: parent
    color: root.borderColor
    Rectangle {
      anchors.fill: parent
      color: root.color
      anchors.leftMargin: Core.Theme.getBorderSize(root.enabledBorders.left, root.borderWidth)
      anchors.rightMargin: Core.Theme.getBorderSize(root.enabledBorders.right, root.borderWidth)
      anchors.topMargin: Core.Theme.getBorderSize(root.enabledBorders.top, root.borderWidth)
      anchors.bottomMargin: Core.Theme.getBorderSize(root.enabledBorders.bottom, root.borderWidth)
      
      layer.enabled: true
      layer.effect: MultiEffect {
        shadowEnabled: true
        shadowColor: root.shadowColor
        shadowVerticalOffset: root.shadowOffsetY
        blurMax: root.shadowBlur
      }

      topLeftRadius: Core.Theme.getRadius(root.radiusCorners.topLeft, height)
      bottomLeftRadius: Core.Theme.getRadius(root.radiusCorners.bottomLeft, height)
      topRightRadius: Core.Theme.getRadius(root.radiusCorners.topRight, height)
      bottomRightRadius: Core.Theme.getRadius(root.radiusCorners.bottomRight, height)
    }

    topLeftRadius: Core.Theme.getRadius(root.radiusCorners.topLeft, height)
    bottomLeftRadius: Core.Theme.getRadius(root.radiusCorners.bottomLeft, height)
    topRightRadius: Core.Theme.getRadius(root.radiusCorners.topRight, height)
    bottomRightRadius: Core.Theme.getRadius(root.radiusCorners.bottomRight, height)
  }

  Item {
    id: contentItem
    anchors.fill: container
    z: container.z + 1
  }
}

