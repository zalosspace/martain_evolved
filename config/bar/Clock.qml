import Quickshell
import QtQuick

Rectangle {
  color: "#040e0d"
  width: clock.implicitWidth + 26
  height: bar.implicitHeight
  radius: height / 2

  Text {
    id: clock

    SystemClock {
      id: sysclock
      precision: SystemClock.Minutes
    }

    text: Qt.formatDateTime(sysclock.date, "hh:mm AP")
    color: "#f5e2c5"
    anchors.centerIn: parent

    font {
      weight: 600
    }
  }
}
