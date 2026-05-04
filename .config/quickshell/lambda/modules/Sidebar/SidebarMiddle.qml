import QtQuick
import QtQuick.Layouts
import Quickshell.Io
import "../../components" as Comp
Item {
    id: root

    implicitWidth: parent?.width ?? 56
    implicitHeight: layout.implicitHeight + 16

    ColumnLayout {
        id: layout
        anchors.centerIn: parent
        spacing: 20

        Comp.CircularMetric {
            id: cpuGauge
            size: 40
            label: "CPU"
            unit: "°C"
            maxValue: 100
            warningThreshold: 75
            criticalThreshold: 90

            Process {
                id: cpuProcess
                command: ["sh", "-c", "cat /sys/class/thermal/thermal_zone3/temp"]
                stdout: StdioCollector {
                    onStreamFinished: {
                        let rawTemp = parseInt(text.trim());
                        if (!isNaN(rawTemp)) cpuGauge.value = rawTemp / 1000;
                    }
                }
            }

            Timer {
                interval: 2000
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: cpuProcess.running = true
            }
        }

        Comp.CircularMetric {
            id: gpuGauge
            size: 40
            label: "GPU"
            unit: "°C"
            maxValue: 100
            warningThreshold: 75
            criticalThreshold: 90

            Process {
                id: gpuProcess
                // If you use a different gpu you need to change this command
                command: ["sh", "-c", "nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader"]
                
                stdout: StdioCollector {
                    onStreamFinished: {
                        let rawTemp = parseInt(text.trim());
                        if (!isNaN(rawTemp)) gpuGauge.value = rawTemp;
                    }
                }
            }

            Timer {
                interval: 2000 
                running: true
                repeat: true
                triggeredOnStart: true
                onTriggered: gpuProcess.running = true
            }
        }
    }
}