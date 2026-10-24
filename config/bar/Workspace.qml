import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts

Rectangle {
  height: bar.implicitHeight
  width: workspaceRow.implicitWidth + 24
  radius: height / 2
  color: "black"

  Row {
    id: workspaceRow
    required property var modelData
    anchors.centerIn: parent
    spacing: 8

    Repeater {
      model: 10

      Rectangle {
        property bool isActive: Hyprland.focusedWorkspace?.id == (index + 1)
        width: 12
        height: 12
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
