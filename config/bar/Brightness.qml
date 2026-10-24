import QtQuick
import Quickshell.Io

Rectangle {
  id: brightnessPill

  function updateBrightness() {
    brightnessProc.running = true
  }

  property int currB: 0
  property int maxB: 0
  property int brightness: 0

  Process {
    id:brightnessProc
    command: ["sh", "-c", "brightnessctl g; brightnessctl m"]
    stdout: StdioCollector {
      onStreamFinished: {
        var d = text.trim().split("\n")

        currB = parseInt(d[0])
        maxB = parseInt(d[1])
        brightness = (currB / maxB) * 100
      }
    }

    Component.onCompleted: running = true
  }

  color: "#040e0d"
  width: briText.implicitWidth + 26
  height: bar.implicitHeight
  radius: height / 2

  Text {
    id: briText
    anchors.centerIn: parent
    color: "#f5e2c5"
    font.weight: 600
    text: "Bri: " + brightness + "%"
  }
}
