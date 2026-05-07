import QtQuick
import QtQuick.Layouts
import "../core" as Core

Item {
    id: root

    implicitWidth: column.implicitWidth
    implicitHeight: column.implicitHeight

    Timer {
        interval: 1000
        repeat: true
        running: true
        triggeredOnStart: true
        onTriggered: {
            const now = new Date()
            timeLabel.text = Qt.formatDateTime(now, "HH:mm")
            dateLabel.text = Qt.formatDateTime(now, "dd MMM").toUpperCase()
        }
    }


    ColumnLayout {
        id: column
        anchors.centerIn: parent
        spacing: -2

        Text {
            id: timeLabel
            Layout.alignment: Qt.AlignHCenter
            text: "00:00"
            font.pixelSize: 14
            font.weight: Font.Bold
            font.family: "monospace"
            color: Core.Theme.primary
        }

        Text {
            id: dateLabel
            Layout.alignment: Qt.AlignHCenter
            text: "00 XXX"
            font.pixelSize: 9
            font.weight: Font.Medium
            font.family: "monospace"
            color: Core.Theme.onSurfaceVariant
        }
    }
}
