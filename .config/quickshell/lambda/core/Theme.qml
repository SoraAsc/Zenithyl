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

    function pick(v) {
      return (typeof v === "string") ? v : v?.default.color
    }

    onTextChanged: {
      try {
        const raw = text()
        if (!raw || raw.trim() === "") return

        const c = JSON.parse(raw).colors
        if (!c) return
        root.primary          = pick(c.primary)
        root.secondary        = pick(c.secondary)
        root.tertiary         = pick(c.tertiary)
        root.background       = pick(c.background)
        root.surface          = pick(c.surface)
        root.surfaceContainer = pick(c.surface_container)
        root.onSurface        = pick(c.on_surface)
        root.outline          = pick(c.outline)
        
      } catch (e) {
        console.error("Theme: failed to parse colors.json: ", e)
      } 
    }
  }
}
