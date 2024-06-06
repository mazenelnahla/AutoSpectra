import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtMultimedia 5.12
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import com.company.serialmanager 1.0
import MyPythonScript 1.0
import com.company.cardatareceiver 1.0
import spotifyreceiver 1.0

Window {
    id: window
    height: 600
    visible: true
    width: 1024
    color: "#3e3c3c"
    maximumHeight: 600
    maximumWidth: 1024
    minimumHeight: 600
    minimumWidth: 1024
    title: qsTr("Instrument Cluster")
    // visibility: "FullScreen"
//    screen: Qt.application.screens[1]
    property int autoPilot: 1

//    Video {
//            id: videoPlayer
//            x:0
//            y:0
//            z: 1 // Ensure it's on top
//            width: window.width
//            height: window.height
//            source: "qrc:/videos/boot.mp4"
//            autoPlay: false
//            MediaPlayer {
//                id: mediaPlayer
//            }

//            onPlaybackStateChanged: {
//                if (mediaPlayer.playbackState === MediaPlayer.PlayingState) {
//                    playbackTimer.start();
//                }
//            }
//        }

//    Timer {
//        id: playbackTimer
//        interval: 8000 // Hide the video after 8 seconds
//        repeat: false // Don't repeat
//        running: false // Start the timer when necessary

//        onTriggered: {
//            console.log("Hiding video after 8 seconds");
//            videoPlayer.visible = false;
//            bg_splash.visible=false;
//        }
//    }

//    Component.onCompleted: {
//        videoPlayer.play();
//        playbackTimer.start(); // Start the timer when the component is completed
//    }
    Instrument_Cluster{

    }

}








