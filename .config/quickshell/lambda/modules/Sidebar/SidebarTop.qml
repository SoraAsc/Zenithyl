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

        Comp.IconButton {
            Layout.alignment: Qt.AlignHCenter
            iconSize: 20
            iconSource: Qt.resolvedUrl("../../assets/icons/lambda.svg")
            onClicked: () => console.log("top button clicked")
        }
    }
}