import Quickshell
import Quickshell.Hyprland
import QtQuick
import qs.core as Core
import qs.components

Row {
    spacing: 10
    function toRoman(num) {
        const romans = [
            { value: 1000, numeral: "M" },
            { value: 900, numeral: "CM" },
            { value: 500, numeral: "D" },
            { value: 400, numeral: "CD" },
            { value: 100, numeral: "C" },
            { value: 90, numeral: "XC" },
            { value: 50, numeral: "L" },
            { value: 40, numeral: "XL" },
            { value: 10, numeral: "X" },
            { value: 9, numeral: "IX" },
            { value: 5, numeral: "V" },
            { value: 4, numeral: "IV" },
            { value: 1, numeral: "I" }
        ];

        let result = "";
        for (let i = 0; i < romans.length; i++) {
            while (num >= romans[i].value) {
                result += romans[i].numeral;
                num -= romans[i].value;
            }
        }
        return result;
      }

    property int focusID: Hyprland.focusedWorkspace ? Hyprland.focusedWorkspace.id : 1

    function getWorkspaceBlock() {
        let base = Math.floor((focusID - 1) / 5) * 5 + 1;
        return [
            {id: base, name: base},
            {id: base + 1, name: base + 1},
            {id: base + 2, name: base + 2},
            {id: base + 3, name: base + 3},
            {id: base + 4, name: base + 4}
        ];
    }

    Repeater {
        model: getWorkspaceBlock()
        delegate: Item {
            width: 50
            height: 25

            ShadowContainer {
                id: shadowBox
                width: parent.width
                height: parent.height
                radiusSize: "full"
                borderWidth: 2
                color: modelData.id === focusID ? Core.Theme.colors.accent : Core.Theme.colors.primary
                borderColor: modelData.id === focusID ? Core.Theme.colors.secondary : "transparent"

                // Hover Animations
                Behavior on scale { NumberAnimation { duration: 150 } }
                Behavior on color { ColorAnimation { duration: 150 } }

                MouseArea {
                  anchors.fill: parent
                  cursorShape: Qt.PointingHandCursor
                  hoverEnabled: true
                  onClicked: Hyprland.dispatch("workspace " + modelData.id)
                  onEntered: shadowBox.scale = 1.1
                  onExited: shadowBox.scale = 1
                }

                Text {
                  id: textItem
                  y: 0.5
                  text: toRoman(modelData.name)
                  font.pixelSize: 16
                  anchors.horizontalCenter: parent.horizontalCenter
                  color: modelData.id === focusID ? "white" : "#E2E8F0"
                  opacity: modelData.id === focusID ? 1 : 0.6
                  Behavior on opacity { NumberAnimation { duration: 150 } }
                }
            }
        }
    }
}

