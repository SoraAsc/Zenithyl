pragma Singleton
import Quickshell

Singleton {
  // Main Colors
  readonly property var colors: {
    "primary": "#000000",
    "secondary": "#E2E8F0",
    "tertiary": "#00D4FF",
    "accent": "#9D4EDD",
    "danger": "#D22929"
  }

  // Typography
  //property string fontFamily: "JetBrainsMono Nerd Font"
  //property int fontSizeSmall: 12
  //property int fontSizeNormal: 14
  //property int fontSizeLarge: 18

  // Spacing
  readonly property var size: {
    "sm": 4,
    "md": 8,
    "lg": 16,
    "xl": 24
  }

  // Radius by size
  function getRadius(factor, elementHeight) {
    if (factor === "full") return elementHeight / 2
    return size[factor] !== undefined ? size[factor] : 0
  }
}

