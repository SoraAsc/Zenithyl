pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    property bool selectorVisible: false
    property int selectedIndex: 0
    property string selectedTheme: themes.length > 0 ? themes[selectedIndex].name : "Default"

    function loadPersistedIndex() {
        const txt = savedIndexFile.text().trim()
        if (txt === "") return
        const val = parseInt(txt)
        if (!isNaN(val) && val >= 0 && val < themes.length) root.selectedIndex = val
    }

    onThemesChanged: {
        if (themes.length > 1) loadPersistedIndex()
    }

    FileView {
        id: savedIndexFile
        path: Quickshell.env("HOME") + "/.cache/lambda/theme_index"
        onTextChanged: loadPersistedIndex()
    }

    // Default fallback to prevent crashes before JSON loads
    property var themes: [
        { "name": "Loading...", "accent": "#ffffff", "bg": "#000000", "wallpaper": "" }
    ]

    function parseThemes(raw) {
        try {
            if (!raw || raw.trim() === "") return false
            const data = JSON.parse(raw)
            if (Array.isArray(data) && data.length > 0) {
                root.themes = data
                return true
            }
        } catch (e) {
            console.error("ThemeState: failed to parse themes JSON:", e)
        }
        return false
    }

    FileView {
        id: customThemes
        path: Quickshell.shellDir + "/assets/themes.json"
        onTextChanged: {
            if (!parseThemes(text())) parseThemes(defaultThemes.text())
        }
    }

    FileView {
        id: defaultThemes
        path: Quickshell.shellDir + "/assets/themes.default.json"
        onTextChanged: {
            if (customThemes.text().trim() === "") parseThemes(text())
        }
    }

    function open()  { selectorVisible = true  }
    function close() { selectorVisible = false }
}
