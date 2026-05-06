pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property string primary
  property string onPrimary
  property string primaryContainer
  property string onPrimaryContainer

  property string secondary
  property string onSecondary
  property string secondaryContainer
  property string onSecondaryContainer

  property string tertiary
  property string onTertiary
  property string tertiaryContainer
  property string onTertiaryContainer

  property string background
  property string onBackground

  property string surface
  property string onSurface
  property string surfaceVariant
  property string onSurfaceVariant
  
  property string surfaceContainer
  property string surfaceContainerLow
  property string surfaceContainerHigh
  property string surfaceContainerHighest
  
  property string outline
  property string outlineVariant

  FileView {
    path: Quickshell.env("HOME") + "/.cache/matugen/colors.json"
    watchChanges: true
    onFileChanged: reload()

    function pick(v) {
      return (typeof v === "string") ? v : v?.default.color
    }

    onTextChanged: {
      try {
        const raw = text()
        if (!raw || raw.trim() === "") return

        const c = JSON.parse(raw).colors
        if (!c) return
        
        root.primary           = pick(c.primary)
        root.onPrimary         = pick(c.on_primary)
        root.primaryContainer  = pick(c.primary_container)
        root.onPrimaryContainer = pick(c.on_primary_container)

        root.secondary          = pick(c.secondary)
        root.onSecondary        = pick(c.on_secondary)
        root.secondaryContainer = pick(c.secondary_container)
        root.onSecondaryContainer = pick(c.on_secondary_container)

        root.tertiary          = pick(c.tertiary)
        root.onTertiary        = pick(c.on_tertiary)
        root.tertiaryContainer = pick(c.tertiary_container)
        root.onTertiaryContainer = pick(c.on_tertiary_container)

        root.background        = pick(c.background)
        root.onBackground      = pick(c.on_background)

        root.surface           = pick(c.surface)
        root.onSurface         = pick(c.on_surface)
        root.surfaceVariant    = pick(c.surface_variant)
        root.onSurfaceVariant  = pick(c.on_surface_variant)
        
        root.surfaceContainer        = pick(c.surface_container)
        surfaceContainerLow          = pick(c.surface_container_low)
        root.surfaceContainerHigh    = pick(c.surface_container_high)
        root.surfaceContainerHighest = pick(c.surface_container_highest)
        
        root.outline           = pick(c.outline)
        root.outlineVariant    = pick(c.outline_variant)
        
      } catch (e) {
        console.error("Theme: failed to parse colors.json: ", e)
      } 
    }
  }
}
