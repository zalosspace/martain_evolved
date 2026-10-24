import Quickshell.Services.Pipewire
import QtQuick

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
