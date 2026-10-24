import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

PanelWindow{
  id: bar

  Timer {
    interval: 1000
    running: true
    repeat: true
    onTriggered: {
      brightness.updateBrightness()
      cpuUsage.updateCpuUsage()
      cpuTemp.updateCpuTemp()
      memUsage.updateMemUsage()
    }
  }

  anchors {
    top: true
    left: true
    right: true
  }

  margins {
    top: 15
    left: 15
    right: 15
  }

  implicitHeight: 36
  color: "transparent"

  Row {
    anchors.left: parent
    spacing: 6
    Workspace{}
    Media{}
  }


  Clock{
    anchors.centerIn: parent
  }

  Row {
    anchors.right: parent.right
    spacing: 6


    Bat{}
    Volume{}
    Brightness{
      id: brightness
    }
    Cpu{
      id: cpuUsage
    }
    CpuTemp{
      id: cpuTemp
    }
    Mem{
      id: memUsage
    }
  }

}
