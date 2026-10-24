import Quickshell
import Quickshell.Io
import QtQuick

// CPU
Rectangle {
  id: cpuUsagePill

  function updateCpuUsage() {
    cpuProcess.running = true
  }

  property int cpuUsage: 0
  property var lastCpuIdle: 0
  property var lastCpuTotal: 0

  // Run shell commands with Process
  Process {
    id: cpuProcess
    command: ["sh", "-c", "head -1 /proc/stat"]
    stdout: SplitParser {
      onRead: data => {
        var p = data.trim().split(/\s+/)
        var idle = parseInt(p[4]) + parseInt(p[5])
        var total = p.slice(1,8).reduce((a, b) => a + parseInt(b), 0)
        if(lastCpuTotal > 0) {
          cpuUsage = Math.round(100 * (1 - (idle-lastCpuIdle) / (total - lastCpuTotal)))
        }

        lastCpuTotal = total
        lastCpuIdle = idle
      }
    }

    Component.onCompleted: running = true
  }
  color: "#040e0d"
  width: cpuUsageText.implicitWidth + 26
  height: bar.implicitHeight
  radius: height / 2

  Text {
    id: cpuUsageText
    anchors.centerIn: parent
    color: "#f5e2c5"
    font.weight: 600
    text: "Cpu: " + cpuUsage + "%"
  }
}

