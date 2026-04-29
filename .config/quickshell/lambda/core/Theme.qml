pragma Singleton
import Quickshell
import Quickshell.Io

Singleton {
  id: root

  property string primary
  property string secondary
  property string tertiary
  property string background
  property string surface
  property string surfaceContainer
  property string onSurface
  property string outline

  FileView {
    path: Quickshell.env("HOME") + "/.cache/matugen/colors.json"
    watchChanges: true
    onFileChanged: reload()

    onTextChanged: {
      try {
        const raw = text()
        if (!raw || raw.trim() === "") return

        const c = JSON.parse(raw).colors
        if (!c) return
        root.primary          = c.primary.dark
        root.secondary        = c.secondary.dark
        root.tertiary         = c.tertiary.dark
        root.background       = c.background.dark
        root.surface          = c.surface.dark
        root.surfaceContainer = c.surface_container.dark
        root.onSurface        = c.on_surface.dark
        root.outline          = c.outline.dark
      } catch (e) {
        console.error("Theme: failed to parse colors.json: ", e)
      } 
    }
  }
}
