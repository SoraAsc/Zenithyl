pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool selectorVisible: false
    property int selectedIndex: 0
    property string selectedTheme: themes.length > 0 ? themes[selectedIndex].name : "Default"

    // Default fallback to prevent crashes before JSON loads
    property var themes: [
        { "name": "Loading...", "accent": "#ffffff", "bg": "#000000", "wallpaper": "" }
    ]

    FileView {
        path: Quickshell.shellDir + "/assets/themes.json"
        onTextChanged: {
            try {
                const raw = text()
                if (!raw || raw.trim() === "") return
                const data = JSON.parse(raw)
                if (Array.isArray(data) && data.length > 0) root.themes = data
            } catch (e) {
                console.error("ThemeState: failed to parse themes.json:", e)
            }
        }
    }

    function open()  { selectorVisible = true  }
    function close() { selectorVisible = false }
}
