import QtQuick
import Quickshell.Services.UPower

Rectangle {
  color: "#040e0d"
  width: bat.implicitWidth + 26
  height: bar.implicitHeight
  radius: height / 2

  Text {
    id: bat

    text: `Bat: ${UPower.displayDevice.percentage * 100}%`
    color: "#f5e2c5"
    anchors.centerIn: parent

    font {
      weight: 600
    }
  }
}

