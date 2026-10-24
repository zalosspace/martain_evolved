import Quickshell
import Quickshell.Io
import QtQuick

// MEM
Rectangle {
  id: memUsagePill

  function updateMemUsage() {
    memProc.running = true
  }
  property int memUsage: 0

  Process {
    id: memProc
    command: ["sh", "-c", "free | grep Mem"]
    stdout: SplitParser {
      onRead: data => {
        var p = data.trim().split(/\s+/)
        var total = parseInt(p[1]) || 1
        var used = parseInt(p[2]) || 0
        memUsage = Math.round(100 * used / total)
      }
    }

    Component.onCompleted: running = true
  }
  color: "#040e0d"
  width: memUsageText.implicitWidth + 26
  height: bar.implicitHeight
  radius: height / 2

  Text {
    id: memUsageText
    anchors.centerIn: parent
    color: "#f5e2c5"
    font.weight: 600
    text: "Mem: " + memUsage + "%"
  }
}

