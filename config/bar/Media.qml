import Quickshell
import Quickshell.Io
import QtQuick
import Quickshell.Services.Mpris

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

