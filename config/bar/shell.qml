import Quickshell
import Quickshell.Hyprland
import Quickshell.Services.UPower
import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

PanelWindow{
  id: bar

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
        model: Hyprland.workspaces

        Rectangle {
          required property var modelData
          width: 14
          height: 14
          visible: modelData.id > 0
          radius: height / 2
          color: modelData.focused ? "#3dd1b0" : "white"
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

        text: `${UPower.displayDevice.percentage * 100}%`
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
        text: audioPill.muted ? "Muted" : `${Math.round(audioPill.volume * 100)}%`
      }
    }

  }
}

