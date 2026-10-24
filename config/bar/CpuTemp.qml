import Quickshell
import Quickshell.Io
import QtQuick

Rectangle {
  id: cTempData

  function updateCpuTemp() {
    cTempProc.running = true
  }

  property int cpuTemp: 0

  // CPU TEMPS
  Process {
    id: cTempProc
    command: ["sh", "-c", "cat /sys/class/thermal/thermal_zone0/temp"]
    stdout: SplitParser {
      onRead: data => {
        var temp = data.trim().split(/\s+/)
        cpuTemp = Math.round(temp[0]/1000)
      }
    }

    Component.onCompleted: running = true
  }


  color: "#040e0d"
  width: cTempDataText.implicitWidth + 26
  height: bar.implicitHeight
  radius: height / 2

  Text {
    id: cTempDataText
    text: "CTemp: " + cpuTemp + " °C"
    anchors.centerIn: parent
    color: "#f5e2c5"
    font.weight: 600
  }
}

