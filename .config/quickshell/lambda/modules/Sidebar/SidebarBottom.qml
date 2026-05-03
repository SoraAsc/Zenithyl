import QtQuick
import QtQuick.Layouts
import "../../components" as Comp

Item {
    id: root

    implicitWidth: parent?.width ?? 56
    implicitHeight: layout.implicitHeight + 16

        ColumnLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 0

        Comp.WorkspaceSwitcher {
            Layout.alignment: Qt.AlignHCenter
        }
    }
}