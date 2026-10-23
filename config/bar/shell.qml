import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import Quickshell.Services.Mpris
import QtQuick
import QtQuick.Layouts

PanelWindow{
  id: bar

  // System Data
  // CPU
  property int cpuUsage: 0
  property int cpuTemp: 0
  property var lastCpuIdle: 0
  property var lastCpuTotal: 0
  // MEM
  property int memUsage: 0

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

  Timer {
    interval: 2000
    running: true
    repeat: true
    onTriggered: {
      cpuProcess.running = true
      cTempProc.running = true
      memProc.running = true
    }
  }
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
   
  // MEM
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

  // minHeight
  implicitHeight: 36
  color: "transparent"
  // color: "black"

  Rectangle {
    height: bar.implicitHeight
    width: workspaceRow.implicitWidth + 24
    radius: height / 2
    color: "black"


    Row {
      id: workspaceRow
      required property var modelData
      anchors.centerIn: parent
      spacing: 5

      Repeater {
        model: 10

        Rectangle {
          property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)
          width: 14
          height: 14
          radius: height / 2
          color: isActive ? "#3dd1b0" : "white"

          // MouseArea {
          //   anchors.fill: parent
          //   onClicked: Hyprland.dispatch("workspace " + (index + 1))
          // }
        }
      }
    }
  }

  RowLayout {
    anchors.centerIn: parent
    spacing: 6

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

    Rectangle {
      id: audioPill
      color: "#040e0d"
      width: volText.implicitWidth + 26
      height: bar.implicitHeight
      radius: height / 2

      // Bind the sink so volume/mute properties are valid
      PwObjectTracker {
        objects: [ Pipewire.defaultAudioSink ]
      }

      readonly property real volume: Pipewire.defaultAudioSink?.audio.volume ?? 0
      readonly property bool muted:  Pipewire.defaultAudioSink?.audio.muted ?? false

      Text {
        id: volText
        anchors.centerIn: parent
        color: "#f5e2c5"
        font.weight: 600
        text: audioPill.muted ? "Muted" : `Vol: ${Math.round(audioPill.volume * 100)}%`
      }
    }

    Rectangle {
      id: cpuUsagePill
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

    Rectangle {
      id: memUsagePill
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

    Rectangle {
      id: mediaData
      color: "#040e0d"
      width: mediaDataText.implicitWidth + 26
      height: bar.implicitHeight
      radius: height / 2

      Text {
        property MprisPlayer activePlayer: Mpris.players.values[0]

        id: mediaDataText
        text: activePlayer ? (activePlayer.trackArtist
        + " - " + activePlayer.trackTitle) : "Stagnant"
        anchors.centerIn: parent
        color: "#f5e2c5"
        font.weight: 600
      }
    }

    Rectangle {
      id: cTempData
      color: "#040e0d"
      width: cTempDataText.implicitWidth + 26
      height: bar.implicitHeight
      radius: height / 2

      Text {
        property MprisPlayer activePlayer: Mpris.players.values[0]

        id: cTempDataText
        text: "CTemp: " + cpuTemp + " °C"
        anchors.centerIn: parent
        color: "#f5e2c5"
        font.weight: 600
      }
    }

  }
}

