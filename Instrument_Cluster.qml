import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Extras 1.4
import QtMultimedia 5.15
import QtGraphicalEffects 1.0
import QtQuick.Controls.Styles 1.4
import com.company.serialmanager 1.0
import MyPythonScript 1.0
import com.company.cardatareceiver 1.0
import spotifyreceiver 1.0
import spotifyclient 1.0
Item {
    id: item1
    width: 1024
    height: 600
    property bool hasRealData: false
    property bool rSignal:false
    property bool lSignal:false
    property int autopilot:0
    property string albumImgUrl: ""
    property string bluetoothDeviceName: "Mazen's A20"
    property bool isPlaying // Property to track play/pause state
    property bool isPlaying2 // Property to track play/pause state
    property int update_flag
    Rectangle{
        width: 1024
        height: 600
        color: "#353535"

    }


    // Image {
    //     id: color_fill_1
    //     source: "images/color_fill_1.png"
    //     x: 0
    //     y: 0
    //     opacity: 1
    // }


    Image {
        id: rectangle_1
        source: "images/rectangle_1.png"
        x: 200
        y: 153
        opacity: 1
    }


    Rectangle {
        id: artistImage
        radius: 8
        visible: false
        color: "#000000"
        width:170
        height:170
        x: 425
        y: 225

        ShaderEffectSource {
            id: artistImageSource
            sourceItem: artistImage
            recursive: true
            live: true
        }

        Image {
            source: "qrc:/images/unknown_song.png"
            fillMode: Image.PreserveAspectCrop
            width:170
            height:170
            opacity: 1
            // layer.enabled:true
            // layer.effect: OpacityMask{
            //     maskSource: artistImageSource
            // }
        }
        Image {
            id: artistImg
            source: ""
            fillMode: Image.PreserveAspectCrop
            width:170
            height:170
            x: 0
            y: 0
            opacity: 1
            // layer.enabled:true
            // layer.effect: OpacityMask{
            //     maskSource: artistImageSource
            // }
        }
        Image {
            id: bluetooth_icon
            source: "images/Bluetooth_white_tray_icon.png"
            anchors.horizontalCenterOffset: -100
            anchors.horizontalCenter: parent.horizontalCenter
            focus: true
            sourceSize.height: 20
            sourceSize.width: 20
            fillMode: Image.PreserveAspectFit
            width:20
            height:20
            x: -22
            y: -55
            opacity: 1
        }
        Text {
            id: bluetooth_connected
            text: "Connected to: " +bluetoothDeviceName
            font.pixelSize: 15
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.weight: Font.Black
            font.family: "Arial-Black"
            color: "#f2f2f2"
            smooth: true
            y: -60
            width: 169
            height: 25
            opacity: 0.70196078431373
            visible: true
        }
        Text {
            id: playingNow
            text: "Playing Now"
            font.pixelSize: 21
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.weight: Font.Black
            font.family: "Arial-Black"
            color: "#f2f2f2"
            smooth: true
            x: 0
            y: -34
            width: 169
            height: 25
            opacity: 0.70196078431373
            visible: true
        }

        Text {
            id: songTitle
            text: "."
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Arial-Black"
            color: "#ffffff"
            smooth: true
            y: 168
            width: 294
            height: 32
            opacity: 1
        }

        Text {
            id: artistName
            text: "."
            font.pixelSize: 19
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            anchors.horizontalCenter: parent.horizontalCenter
            font.family: "Arial-Black"
            color: "#ffffff"
            smooth: true
            y: 200
            width: 170
            height: 19
            opacity: 0.5
        }

        ProgressBar {
            id:musicProgress
            y: 230
            width: 250
            value: 100
            anchors.horizontalCenter: parent.horizontalCenter
            from: 0
            to: 100
            height: 5
            background: Rectangle {
                implicitWidth: 200
                implicitHeight: 6
                color: "#7f7f7f"
                radius: 3
            }
            contentItem: Item {
                implicitWidth: 200
                implicitHeight: 4

                Rectangle {
                    width: musicProgress.visualPosition * parent.width
                    height: parent.height
                    radius: 2
                    color: "#ffffff"
                }
            }
            Text {
                id: current_time
                text: "00:00"
                font.pixelSize: 14
                font.family: "Arial"
                font.bold: true
                color: "#ffffff"
                smooth: true
                x: 0
                y: 10
                opacity: 0.5
            }
            Text {
                id: finish_time
                text: "00:00"
                font.pixelSize: 14
                font.family: "Arial"
                font.bold: true
                color: "#ffffff"
                smooth: true
                x: 215
                y: 10
                opacity: 0.5
            }
        }
        Image {
            id:spotifyControlButtons
            y:270
            width: 197
            height: 54
            source: "images/button_frame.png"
            anchors.horizontalCenter: parent.horizontalCenter
            opacity: 1
            Image {
                id: play
                source: "images/play.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                fillMode: Image.PreserveAspectCrop
                height:45
                width:45
                opacity: isPlaying ? 0 : 1
                anchors.verticalCenter: parent.verticalCenter
                MouseArea {
                    anchors.fill: parent
                    enabled: true
                    onClicked: {
                        if(isPlaying2){
                            spotify.pause()
                        }else{
                            spotify.play()
                        }
                        isPlaying2 = !isPlaying2;
                    }
                }
            }
            Image {
                id: pause
                source: "images/pause.png"
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenterOffset: 0
                fillMode: Image.PreserveAspectCrop
                height:45
                width:45
                opacity: isPlaying ? 1 : 0
                anchors.verticalCenter: parent.verticalCenter
                MouseArea {
                    anchors.fill: parent
                    enabled: true
                    onClicked: {
                        if(isPlaying2){
                            spotify.pause()
                        }else{
                            spotify.play()
                        }
                        isPlaying2 = !isPlaying2;
                    }
                }
            }


            Image {
                id: forward
                source: "images/forward.png"
                anchors.verticalCenterOffset: 0
                fillMode: Image.PreserveAspectCrop
                x: 127
                height:45
                width:45
                opacity: 1
                anchors.verticalCenter: parent.verticalCenter
                MouseArea {
                    anchors.fill: parent
                    enabled: true
                    onClicked: {
                        spotify.nextTrack()
                    }
                }
            }
            Image {
                id: back
                source: "images/back.png"
                fillMode: Image.PreserveAspectCrop
                x: 21
                height:45
                width:45
                opacity: 1
                anchors.verticalCenter: parent.verticalCenter
                MouseArea {
                    anchors.fill: parent
                    enabled: true
                    onClicked: {
                        spotify.previousTrack()
                    }
                }
            }
        }

    }

    VideoOutput {
        id: viewfinder
        x: 124
        y: 70
        width: 1236
        height: 698
        anchors.fill: rectangle_1
        anchors.centerIn: parent
        source: camera
        visible: false
    }



    Camera {
        id: camera
    }


    Rectangle {
        id: noSignalIndicator
        anchors.fill: rectangle_1
        visible: false
        color: "black"

        Column {
            anchors.centerIn: parent
            spacing: 10

            Repeater {
                model: 5
                Rectangle {
                    width: parent.width
                    height: 20
                    color: model.index % 2 === 0 ? "red" : "blue"
                }
            }
        }

        Text {
            text: "No Signal"
            color: "white"
            font.pixelSize: 24
            anchors.centerIn: parent
        }
    }


    Image {
        id: right_side_none
        source: "images/Right_Side.png"
        x: 616
        y: 113
        opacity: 1
        visible: speed_read.text <= 0 || hasRealData== false
    }


    Image {
        id: right_side_blue
        source: "images/right_side_blue.png"
        x: 616
        y: 113
        opacity: 1
        visible: speed_read.text > 0 && speed_read.text < 60 && hasRealData== true
    }

    Image {
        id: right_side_red
        source: "images/right_side_red.png"
        x: 616
        y: 113
        opacity: 1
        visible: speed_read.text >= 120 && hasRealData== true
    }

    Image {
        id: right_side_yellow
        source: "images/right_side_yellow.png"
        x: 616
        y: 113
        opacity: 1
        visible: speed_read.text >= 60 && speed_read.text < 120 && hasRealData== true
    }



    Image {
        id: left_side_center1
        x: 696
        y: 194
        opacity: 1
        source: "images/center.png"
        rotation: -173.341
    }


    Image {
        id: left_side
        source: "images/left_side.png"
        x: -5
        y: 113
        opacity: 1
    }



    Gauge_animation {
        x: 42
        y: 161
        width: 317
        height: 317
        value: speed_read.text
        maximumValue: 160
        anchors {
            margins: window.height * 0.2
        }
        Text {
            id: min_speed
            x: 84
            y: 264
            color: "#ffffff"
            text: qsTr("0")
            font.pixelSize: 17
            font.family: "GoogleSansDisplay-Bold"
            font.bold: true
        }

        Text {
            id: max_speed
            x: 206
            y: 268
            font.family: "GoogleSansDisplay-Bold"
            color: "#d92a27"
            text: qsTr("160")
            font.pixelSize: 17
            font.bold: true
        }
    }





    Image {
        id: left_side_center
        source: "images/center.png"
        x: 80
        y: 197
        opacity: 1
    }


    Image {
        id: upper_status
        source: "images/upper_status.png"
        anchors.horizontalCenter: parent.horizontalCenter
        clip: true
        y: 0
        width: 1026
        height: 127
        opacity: 0.911
        visible: true
    }



    Text {
        id: miles_value
        text: "0060"
        font.pixelSize: 16
        font.family: "Futura"
        color: "#d0d0d0"
        smooth: true
        x: 782
        y: 379
        opacity: 1
    }


    Text {
        id: miles
        x: 824
        y: 379
        opacity: 1
        color: "#7f7f7f"
        text: "km"
        font.pixelSize: 16
        smooth: true
        font.family: "Futura"
    }


    Text {
        id: gear
        text: "Gear"
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Futura"
        font.bold: true
        color: "#e7bf8c"
        smooth: true
        x: 791
        y: 231
        opacity: 1
        visible: true


        Text {
            id: selected_gear
            text: "P"
            font.pixelSize: 80
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Futura"
            font.bold: true
            color: "#ffffff"
            smooth: true
            x: -60
            y: 22
            width: 170
            height: 86
            opacity: 1
        }

        Text {
            id: _P
            x: -23
            y: 114
            width: 20
            height: 20
            color: "#ffffff"
            text: qsTr("P")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Black
        }


        Text {
            id: _N
            x: 27
            y: 114
            width: 20
            height: 20
            color: "#7f7f7f"
            text: qsTr("N")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Black
        }


        Text {
            id: _D
            x: 53
            y: 114
            width: 20
            height: 20
            color: "#7f7f7f"
            text: qsTr("D")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Black
        }


        Text {
            id: _R
            x: 0
            y: 114
            width: 20
            height: 20
            color: "#7f7f7f"
            text: qsTr("R")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Black
        }


        Text {
            id: drive_mode
            x: -344
            y: -204
            text: "Parking"
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.weight: Font.Black
            font.family: "Futura"
            color: "#e7bf8c"
            smooth: true
            width: 133
            height: 22
            opacity: 1
        }
    }



    Text {
        id: gearAuto
        text: "Gear"
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Futura"
        font.bold: true
        color: "#e7bf8c"
        smooth: true
        x: 791
        y: 231
        opacity: 1
        visible: false

        Text {
            id: auto_selected_gear
            text: "P"
            font.pixelSize: 80
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.family: "Futura"
            font.bold: true
            color: "#ffffff"
            smooth: true
            x: -60
            y: 22
            width: 170
            height: 86
            opacity: 1
        }

        Text {
            id: auto_P
            x: -23
            y: 114
            width: 20
            height: 20
            color: "#ffffff"
            text: qsTr("P")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Black
        }

        Text {
            id: auto_N
            x: 27
            y: 114
            width: 20
            height: 20
            color: "#7f7f7f"
            text: qsTr("N")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Black
        }

        Text {
            id: auto_D
            x: 53
            y: 114
            width: 20
            height: 20
            color: "#7f7f7f"
            text: qsTr("D")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Black
        }

        Text {
            id: auto_R
            x: 0
            y: 114
            width: 20
            height: 20
            color: "#7f7f7f"
            text: qsTr("R")
            font.pixelSize: 25
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Black
        }

        Text {
            id: auto_drive_mode
            x: -344
            y: -204
            text: "Parking"
            font.pixelSize: 18
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.AllUppercase
            font.weight: Font.Black
            font.family: "Futura"
            color: "#e7bf8c"
            smooth: true
            width: 133
            height: 22
            opacity: 1
        }
    }



    Text {
        id: speed_read
        font.pixelSize: 80
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignBottom
        font.family: "Futura"
        font.bold: true
        color: "#ffffff"
        text: speedValue
        smooth: true
        x: 118
        y: 261
        width: 167
        height: 97
        opacity: 1
        visible: true

        property int speedValue: 0
        SequentialAnimation on speedValue {
            id: speedAnimation

            NumberAnimation {
                from: 0
                to: 160
                duration: 4000
                easing.type: Easing.InOutQuad
            }

            NumberAnimation {
                from: 160
                to: 0
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }
    }
    // Start the animation only if hasRealData is false
    // Component.onCompleted: {
    //     if (hasRealData==false) {
    //         speedAnimation.start()
    //     }
    //     else{
    //         speedAnimation.stop()
    //     }
    // }



    Image {
        id: speed_limit
        source: "images/Set 1/signs.png"
        sourceSize.height: 37
        cache: false
        focus: true
        fillMode: Image.PreserveAspectFit
        sourceSize.width: 37
        x: 237
        y: 358
        width: 37
        height: 37
        opacity: 1
        visible: true
    }


    Image {
        id: door_open
        source: "images/door_open.png"
        x: 77
        y: 17
        opacity: 1
        property bool colorFlag: false
    }

    ColorOverlay {
        anchors.fill: door_open
        source: door_open
        color: door_open.colorFlag ? "#515151" : "transparent"
    }


    Image {
        id: low_bat
        source: "images/low_bat.png"
        x: 782
        y: 72
        opacity: 1
        visible: true
        property bool colorFlag: false
    }

    ColorOverlay {
        anchors.fill: low_bat
        source: low_bat
        color: low_bat.colorFlag ? "#515151" : "transparent"
    }



    Image {
        id: parking_break
        source: "images/parking_break.png"
        x: 144
        y: 49
        opacity: 1
        visible: true
        property bool colorFlag: false
    }
    ColorOverlay {
        anchors.fill: parking_break
        source: parking_break
        color: parking_break.colorFlag ? "#515151" : "transparent"
    }



    Image {
        id: seat_belt
        source: "images/seat_belt.png"
        x: 210
        y: 65
        opacity: 1
        visible: true
        property bool colorFlag: false
    }

    ColorOverlay {
        anchors.fill: seat_belt
        source: seat_belt
        color: seat_belt.colorFlag ? "#515151" : "transparent"
    }




    Image {
        id: assist_disable
        source: "images/assist_disable.png"
        x: 919
        y: 15
        opacity: 1
        visible: true
        property bool colorFlag: false
    }

    ColorOverlay {
        anchors.fill: assist_disable
        source: assist_disable
        color: assist_disable.colorFlag ? "#515151" : "transparent"
    }


    Image {
        id: steering_error
        source: "images/steering_error.png"
        x: 853
        y: 44
        opacity: 1
        visible: true
        property bool colorFlag: false
    }

    ColorOverlay {
        anchors.fill: steering_error
        source: steering_error
        color: steering_error.colorFlag ? "#515151" : "transparent"
    }


    Item{
        id:lights_indecators
        Image {
            id: low_beam
            source: "images/low_beam.png"
            fillMode: Image.PreserveAspectFit
            x: 200
            y: 388
            width: 30
            height: 30
            opacity: 1
            property bool colorFlag: false
        }


        ColorOverlay {
            y: 554
            anchors.fill: low_beam
            source: low_beam
            color: low_beam.colorFlag ? "#39383c" : "transparent"
        }


        Image {
            id: high_beam
            source: "images/high_beam.png"
            fillMode: Image.PreserveAspectFit
            sourceSize.height: 0
            sourceSize.width: 0
            x: 173
            y: 353
            width: 30
            height: 30
            opacity: 1
            property bool colorFlag: false
        }


        ColorOverlay {
            y: 554
            anchors.fill: high_beam
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            source: high_beam
            color: high_beam.colorFlag ? "#39383c" : "transparent"
        }


        Image {
            id: adaptive_on
            source: "images/adaptive_on.png"
            fillMode: Image.PreserveAspectFit
            sourceSize.height: 0
            sourceSize.width: 0
            x: 124
            y: 353
            width: 30
            height: 30
            opacity: 1
            property bool colorFlag: false
        }


        ColorOverlay {
            y: 554
            anchors.fill: adaptive_on
            source: adaptive_on
            color: adaptive_on.colorFlag ? "#39383c" : "transparent"
        }


        Image {
            id: daytime_light
            source: "images/daytime_light.png"
            fillMode: Image.PreserveAspectFit
            x: 155
            y: 381
            width: 30
            height: 30
            opacity: 1
            property bool colorFlag: false
        }

        ColorOverlay {
            y: 554
            anchors.fill: daytime_light
            source: daytime_light
            color: daytime_light.colorFlag ? "#39383c" : "transparent"
        }
    }




    Text {
        id: alert_
        text: "Alert"
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.weight: Font.Black
        font.family: "Futura"
        color: "#d82927"
        smooth: true
        x: 483
        y: 63
        opacity: 1
        visible: true
    }





    Text {
        id: _cautionMassage
        text: "System Malfunction"
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        font.capitalization: Font.AllUppercase
        font.family: "Futura"
        color: "#ffffff"
        smooth: true
        x: 360
        y: 89
        width: 306
        height: 19
        opacity: 1
        visible: true
    }



    Text {
        id: alert_sleep
        text: "Alert"
        font.pixelSize: 18
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.weight: Font.Black
        font.family: "Futura"
        color: "#d82927"
        smooth: true
        x: 483
        y: 63
        opacity: 1
        visible: false
    }

    Text {
        id: sleep_cautionMassage
        text: "System Malfunction"
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.bold: true
        font.capitalization: Font.AllUppercase
        font.family: "Futura"
        color: "#ffffff"
        smooth: true
        x: 360
        y: 89
        width: 306
        height: 19
        opacity: 1
        visible: false
    }




    Image {
        id: lower_right
        x: 805
        y: 532
        width: 336
        height: 68
        opacity: 1
        source: "images/lower_status.png"
        fillMode: Image.PreserveAspectFit
    }

    Text {
        id: clockdate
        text: "00:00"
        anchors.verticalCenter: lower_right.verticalCenter
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        font.styleName: "Black"
        font.family: "Arial"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 865
        opacity: 1
    }

    Text {
        id: clockDateSign
        text: "PM"
        font.pixelSize: 12
        font.styleName: "Black"
        font.family: "Arial"
        font.bold: true
        color: "#7f7f7f"
        smooth: true
        x: 927
        y: 562
        opacity: 1
    }




    Text {
        id: tempLabel
        text: "--"
        anchors.verticalCenter: lower_right.verticalCenter
        font.pixelSize: 22
        horizontalAlignment: Text.AlignHCenter
        font.styleName: "Black"
        font.weight: Font.Black
        font.family: "Arial"
        color: "#ffffff"
        smooth: true
        x: 957
        opacity: 1

        Text {
            id: tempDegree
            text: "o"
            font.pixelSize: 15
            font.family: "Futura"
            color: "#7f7f7f"
            smooth: true
            x: 31
            y: -6
            opacity: 1
        }
        Text {
            id: tempSign
            text: "c"
            font.pixelSize: 22
            horizontalAlignment: Text.AlignHCenter
            font.styleName: "Bold"
            font.weight: Font.Black
            font.family: "Arial"
            color: "#7f7f7f"
            smooth: true
            x: 33
            y: 3
            width: 22
            height: 27
            opacity: 1
        }
    }





    Image {
        id: rightlabel
        x: 595
        y: 21
        width: 35
        height: 35
        source: "images/right.png"
        fillMode: Image.PreserveAspectFit
        opacity:0
        visible: true

        SequentialAnimation {
            running: true
            loops: Animation.Infinite  // Infinite looping

            NumberAnimation {
                target: rightlabel
                property: "opacity"
                to: 0
                duration: 750  // Adjust the duration of the fade-out
            }

            NumberAnimation {
                target: rightlabel
                property: "opacity"
                to: 1
                duration: 500  // Adjust the duration of the fade-in
            }
        }
    }




    Image {
        id: leftlabel
        x: 395
        y: 21
        width: 35
        height: 35
        source: "images/left.png"
        fillMode: Image.PreserveAspectFit
        opacity:0
        visible: true

        SequentialAnimation {
            running: true
            loops: Animation.Infinite  // Infinite looping

            NumberAnimation {
                target: leftlabel
                property: "opacity"
                to: 0
                duration: 750  // Adjust the duration of the fade-out
            }

            NumberAnimation {
                target: leftlabel
                property: "opacity"
                to: 1
                duration: 500  // Adjust the duration of the fade-in
            }
        }
    }



    Image {
        id: wanring_massage
        x: 327
        y: 335
        source: "images/wanring_massage.png"
        cache: false
        transformOrigin: Item.Center
        width: 366
        height: 190
        opacity: 1
        visible: true
        Item{
            id: engineMulfunction
            visible: true
            Image {
                id: caution_icon_Engine
                x: 36
                y: 29
                width: 42
                height: 38
                source: "images/check-engine-light-icon-1616189100.png"
                sourceSize.height: 0
                sourceSize.width: 0
                fillMode: Image.PreserveAspectFit
            }
            Text {
                id: _errorTitle
                x: 100
                y: 36
                width: 245
                height: 23
                color: "#d92a27"
                text: qsTr("Engine Malfunction")
                font.pixelSize: 19
                verticalAlignment: Text.AlignVCenter
                font.family: "Futura"
                font.capitalization: Font.Capitalize
                font.weight: Font.ExtraBold
            }
            Text {
                id: _errorEngine
                x: 35
                y: 68
                width: 300
                height: 89
                color: "#ffffff"
                text: qsTr("Engine operating at reduced output. Possible to continue. Drive with caution. Have the system checked by nearest service center.")
                font.pixelSize: 17
                verticalAlignment: Text.AlignTop
                lineHeight: 0.9
                wrapMode: Text.Wrap
                font.family: "Futura"
                font.weight: Font.DemiBold
                font.preferShaping: true
                font.kerning: true
            }
        }

        Item{
            id: roadImprefection
            visible: false
            Image {
                id: caution_icon_Road_Imprefection
                x: 32
                y: 13
                width: 60
                height: 60
                source: "images/layer_2.png"
                sourceSize.height: 0
                sourceSize.width: 0
                fillMode: Image.Stretch
            }
            Text {
                id: _errorTitle2
                x: 80
                y: 40
                width: 255
                height: 23
                color: "#d97b27"
                text: qsTr("Road Imprefection Detected")
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
                font.family: "Futura"
                font.capitalization: Font.Capitalize
                font.weight: Font.ExtraBold
            }
            Text {
                id: _errorRoadImprefections
                x: 35
                y: 68
                width: 300
                height: 89
                color: "#ffffff"
                text: qsTr("Alert an imperfection has been dectected please slow down. Drive with caution. Nearest road bump in 10 meters away.")
                font.pixelSize: 17
                verticalAlignment: Text.AlignTop
                lineHeight: 0.9
                wrapMode: Text.Wrap
                font.family: "Futura"
                font.weight: Font.DemiBold
                font.preferShaping: true
                font.kerning: true
            }
        }

        Item{
            id: radarDetected
            visible: false
            Image {
                id: caution_icon_errorRadarDetected
                x: 36
                y: 30
                width: 38
                height: 37
                source: "images/speed_limit.png"
                sourceSize.height: 0
                sourceSize.width: 0
                fillMode: Image.PreserveAspectFit
            }
            Text {
                id: _errorTitle3
                x: 100
                y: 36
                width: 245
                height: 23
                color: "#d92a27"
                text: qsTr("Speed Radar Detected")
                font.pixelSize: 19
                verticalAlignment: Text.AlignVCenter
                font.family: "Futura"
                font.capitalization: Font.Capitalize
                font.weight: Font.ExtraBold
            }
            Text {
                id: _errorRadarDetected
                x: 35
                y: 68
                width: 299
                height: 89
                color: "#ffffff"
                text: qsTr("Attention, Radar is near you, Please slow down and keep focused on the road.")
                font.pixelSize: 17
                verticalAlignment: Text.AlignTop
                lineHeight: 0.9
                wrapMode: Text.Wrap
                font.family: "Futura"
                font.weight: Font.DemiBold
                font.preferShaping: true
                font.kerning: true
            }
        }

        Item{
            id: airBagError
            visible: false
            Image {
                id: caution_icon_airBagError
                x: 39
                y: 29
                width: 39
                height: 35
                source: "images/367-200.png"
                sourceSize.height: 0
                sourceSize.width: 0
                fillMode: Image.Stretch
            }
            Text {
                id: _errorTitle4
                x: 84
                y: 35
                width: 254
                height: 23
                color: "#d92a27"
                text: qsTr("Airbag System Fault")
                font.pixelSize: 19
                verticalAlignment: Text.AlignVCenter
                font.family: "Futura"
                font.capitalization: Font.Capitalize
                font.weight: Font.ExtraBold
            }
            Text {
                id: _errorAirbag
                x: 35
                y: 67
                width: 303
                height: 95
                color: "#ffffff"
                text: qsTr("SRS system detected a fault in the system. Continue wearing safety belt. consult nearest service center.")
                font.pixelSize: 17
                verticalAlignment: Text.AlignTop
                lineHeight: 0.9
                wrapMode: Text.Wrap
                font.family: "Futura"
                font.weight: Font.DemiBold
                font.preferShaping: true
                font.kerning: true
            }
        }


        Item{
            id: electricSteeringError
            visible: false
            Image {
                id: caution_icon_electricSteeringError
                x: 35
                y: 32
                width: 36
                height: 33
                source: "images/steering_error.png"
                sourceSize.height: 0
                sourceSize.width: 0
                fillMode: Image.PreserveAspectFit
            }
            Text {
                id: _errorTitle5
                x: 82
                y: 37
                width: 238
                height: 23
                color:"#d92a27"
                text: qsTr("Electric Steering Failed")
                font.pixelSize: 19
                verticalAlignment: Text.AlignVCenter
                font.family: "Futura"
                font.capitalization: Font.Capitalize
                font.weight: Font.ExtraBold
            }
            Text {
                id: _errorSteering
                x: 35
                y: 65
                width: 312
                height: 89
                color: "#ffffff"
                text: qsTr("Steering system may have some communictaion issues or broken parts. Drive with caution. Have the system checked by nearest service center.")
                font.pixelSize: 17
                verticalAlignment: Text.AlignTop
                lineHeight: 0.9
                wrapMode: Text.Wrap
                font.family: "Futura"
                font.weight: Font.DemiBold
                font.preferShaping: true
                font.kerning: true
            }
        }

    }

    Image {
        id: lower_status2
        x: -94
        y: 532
        width: 336
        height: 68
        opacity: 1
        source: "images/lower_status.png"
        fillMode: Image.PreserveAspectFit
        property bool colorFlag: false
    }

    Image {
        id: fota_update_icon
        fillMode: Image.PreserveAspectFit
        x: 23
        source: "/images/update_icon.png"
        sourceSize.height: 40
        sourceSize.width: 40
        width: 35
        height: 35
        opacity: 1
        visible: update_flag !== 0
        anchors.verticalCenter: lower_status2.verticalCenter
        property bool colorFlag: update_flag == 0
        MouseArea {
            anchors.fill: parent
            onClicked: {
                fota_open.visible=!fota_open.visible;
            }
        }
    }
    ColorOverlay {
        anchors.fill: fota_update_icon
        source: fota_update_icon
        color: fota_update_icon.colorFlag ? "#515151" : "transparent"
    }
    Image {
        id: warning_icon
        source: "/images/warning.png"
        fillMode: Image.PreserveAspectFit
        sourceSize.height: 40
        sourceSize.width: 40
        x: 80
        width: 40
        height: 40
        opacity: 1
        visible: true
        anchors.verticalCenter: lower_status2.verticalCenter
        MouseArea {
            anchors.fill: parent
            onClicked: {
                wanring_massage.visible=!wanring_massage.visible;
            }
        }
    }
    Image {
        id: autopilot_mode_button
        source: "images/Autopilot.png"
        cache: false
        fillMode: Image.PreserveAspectFit
        sourceSize.height: 40
        sourceSize.width: 40
        x: 143
        width: 40
        height: 40
        opacity: 1
        visible: false
        anchors.verticalCenter: lower_status2.verticalCenter
        property bool colorFlag: autopilot !==0
    }

    MouseArea {
        anchors.fill: autopilot_mode_button
        onClicked: {
            autopilot_mode_button.colorFlag=!autopilot_mode_button.colorFlag;
        }
    }
    ColorOverlay {
        anchors.fill: autopilot_mode_button
        source: autopilot_mode_button
        color: autopilot_mode_button.colorFlag ? "#06a660" : "#515151"
    }
    Fota {
        id:fota_open
        visible:false;
        Component.onCompleted: {
            update_flag=update;
            console.log("Fota component initialized with update value:", update)
        }

        onUpdateChanged: {
            update_flag=update;
            console.log("Fota component update value changed to:", update)
        }
    }

    Connections {
        target: serialManager
        function onJsonDataParsed(temperature, humidity, door, gear) {
            tempLabel.text = ""+temperature;
            if(door){
                door_open.colorFlag = true;
                door_open.visible=false;
            }else{
                door_open.colorFlag = false;
                door_open.visible=true;
            }
            selected_gear.text=gear;
            if (selected_gear.text === "P") {
                drive_mode.text="Parking"
                _P.color = "#ffffff";
                if(lSignal===false && rSignal===false){
                    camera.stop() // Stop the camera (not start)
                    viewfinder.visible = false // Hide the viewfinder
                }
            } else {
                _P.color = "#7f7f7f";
            }
            if (selected_gear.text === "N") {
                drive_mode.text="Neutral"
                _N.color = "#ffffff";
                if(lSignal===false && rSignal===false){
                    camera.stop() // Stop the camera (not start)
                    viewfinder.visible = false // Hide the viewfinder
                }
            } else {
                _N.color = "#7f7f7f";
            }
            if (selected_gear.text === "D") {
                if(autopilot==0){
                    drive_mode.text="Driving Mode"
                }else{
                    drive_mode.text="Autopilot Mode"
                }
                _D.color = "#ffffff";
                if(lSignal===false && rSignal===false){
                    camera.stop() // Stop the camera (not start)
                    viewfinder.visible = false // Hide the viewfinder
                }
            } else {
                _D.color = "#7f7f7f";
            }
            if (selected_gear.text === "R") {
                drive_mode.text="Reversing"
                _R.color = "#ffffff";
                camera.start() // Start the camera
                viewfinder.visible = true // Show the viewfinder
            } else {
                _R.color = "#7f7f7f";
            }
        }
    }

    Item{
        id:lower_alert
        y:560
        width: 573
        height: 186
        visible: false
        anchors.horizontalCenter: parent.horizontalCenter
        Image{
            id:alert_lower_bg
            y: -33
            width: 500
            height: 160
            visible: true
            source: "/images/wanring_massage.png"
            anchors.horizontalCenter: parent.horizontalCenter
            sourceSize.height: 186
            sourceSize.width: 600
            cache: true
            enabled: true
            smooth: true
            fillMode: Image.Stretch
        }
        Image{
            id:no_wifi_icon
            x: 70
            y: -10
            width: 40
            height: 40
            visible: true
            source:"/images/no-wifi_white.png"
            sourceSize.height: 45
            sourceSize.width: 45
            fillMode: Image.PreserveAspectFit
        }
        Text{
            x: 115
            y: 0
            width: 398
            height: 24
            color: "white"
            text: "there is no internet connection, please reconnect."
            font.letterSpacing: 1
            font.pixelSize: 15
            horizontalAlignment: Text.AlignLeft
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WrapAnywhere
            font.wordSpacing: 0
            font.capitalization: Font.Capitalize
            font.styleName: "Black"
            font.family: "Arial"
        }
    }

    Connections{
        target:carDataReceiver
        onCarlaJsonDataParsed:{
            speedAnimation.stop();
            speed_read.speedValue=0;
            speed_read.speedValue=speed;
            // speed_read.text = ""+speed;
            // console.log(speed);
            if(autoPilotFlag===1){
                // gear.visible=false;
                // gearAuto.visible=true;
                autopilot=1;
                selected_gear.text=AGear;
                if (selected_gear.text === "P") {
                    drive_mode.text="Parking"
                    _P.color = "#ffffff";
                    if(lSignal===false && rSignal===false){
                        camera.stop() // Stop the camera (not start)
                        viewfinder.visible = false // Hide the viewfinder
                    }
                } else {
                    _P.color = "#7f7f7f";
                }
                if (selected_gear.text === "N") {
                    drive_mode.text="Neutral"
                    _N.color = "#ffffff";
                    if(lSignal===false && rSignal===false){
                        camera.stop() // Stop the camera (not start)
                        viewfinder.visible = false // Hide the viewfinder
                    }
                } else {
                    _N.color = "#7f7f7f";
                }
                if (selected_gear.text === "D") {
                    if(autopilot==0){
                        drive_mode.text="Driving Mode"
                    }else{
                        drive_mode.text="Autopilot Mode"
                    }
                    _D.color = "#ffffff";
                    if(lSignal===false && rSignal===false){
                        camera.stop() // Stop the camera (not start)
                        viewfinder.visible = false // Hide the viewfinder
                    }
                } else {
                    _D.color = "#7f7f7f";
                }
                if (selected_gear.text === "R") {
                    drive_mode.text="Reversing"
                    _R.color = "#ffffff";
                    camera.start() // Start the camera
                    viewfinder.visible = true // Show the viewfinder
                } else {
                    _R.color = "#7f7f7f";
                }

                if(leftSignal===1){
                    lSignal=true;
                    leftlabel.visible=true;
                    camera.start() // Start the camera
                    viewfinder.visible = true // Show the viewfinder
                }else if (leftSignal===0){
                    lSignal=false;
                    leftlabel.visible=false;
                }

                if(rightSignal===1){
                    rSignal=true;
                    rightlabel.visible=true;
                    camera.start() // Start the camera
                    viewfinder.visible = true // Show the viewfinder
                }else if (rightSignal===0){
                    rSignal=false;
                    rightlabel.visible=false;
                }
                if(rightSignal===1 && leftSignal===1 && (selected_gear.text !== "R")){
                    camera.stop() // Stop the camera (not start)
                    viewfinder.visible = false // Hide the viewfinder
                }
            }else{
                gear.visible=true;
                gearAuto.visible=false;
                autopilot==0;
                if(leftSignal===1){
                    lSignal=true;
                    leftlabel.visible=true;
                    camera.start() // Start the camera
                    viewfinder.visible = true // Show the viewfinder
                }else if (leftSignal===0){
                    lSignal=false;
                    leftlabel.visible=false;
                }

                if(rightSignal===1){
                    rSignal=true;
                    rightlabel.visible=true;
                    camera.start() // Start the camera
                    viewfinder.visible = true // Show the viewfinder
                }else if (rightSignal===0){
                    rSignal=false;
                    rightlabel.visible=false;
                }
                if(rightSignal===1 && leftSignal===1 && (selected_gear.text !== "R")){
                    camera.stop() // Stop the camera (not start)
                    viewfinder.visible = false // Hide the viewfinder
                }
            }
            if(warning===false){
                wanring_massage.visible=false;
                _cautionMassage.visible=false;
                alert_.visible=false;

                assist_disable.visible=false;
                steering_error.visible=false;
                low_beam.visible=false;
                low_bat.visible=false;
                seat_belt.visible=false;
                daytime_light.visible=false;
                assist_disable.colorFlag=true;
                steering_error.colorFlag=true;
                low_beam.colorFlag=true;
                low_bat.colorFlag=true;
                seat_belt.colorFlag=true;
                daytime_light.colorFlag=true;
                hasRealData= true;
            }

            if(highBeam===true){
                high_beam.visible=true;
                high_beam.colorFlag=false;
            }else{
                high_beam.visible=false;
                high_beam.colorFlag=true;
            }

            if(adaptiveLight===true){
                adaptive_on.visible=true;
                adaptive_on.colorFlag=false;
            }else{
                adaptive_on.visible=false;
                adaptive_on.colorFlag=true;
            }

            if(handBrake===true){
                parking_break.visible=true;
                parking_break.colorFlag=false;
            }else{
                parking_break.visible=false;
                parking_break.colorFlag=true;
            }
            if(trafficSign==="speed_30"){
                speed_limit.source="images/Set 1/06.png"
            }
            if(trafficSign==="speed_60"){
                speed_limit.source="images/Set 1/12.png"
            }
            if(trafficSign==="speed_80"){
                speed_limit.source="images/Set 1/16.png"
            }
            if(trafficSign==="speed_120"){
                speed_limit.source="images/Set 1/24.png"
            }
            if(trafficSign==="speed_140"){
                speed_limit.source="images/Set 1/28.png"
            }
            if(trafficSign===""){
                speed_limit.source="images/Set 1/signs.png"
            }
            if(drowsinessDetection){
                sleep_cautionMassage.visible=true;
                sleep_cautionMassage.text="You Need To Take a Brake";
                alert_sleep.visible=true;
            }
        }
        onNoConnection:{
            if(warning===true){
                autopilot=0;
                wanring_massage.visible=true;
                _cautionMassage.visible=true;
                alert_.visible=true;
                assist_disable.visible=true;
                steering_error.visible=true;
                low_beam.visible=true;
                low_bat.visible=true;
                seat_belt.visible=true;
                daytime_light.visible=true;
                assist_disable.colorFlag=false;
                steering_error.colorFlag=false;
                low_beam.colorFlag=false;
                low_bat.colorFlag=false;
                seat_belt.colorFlag=false;
                daytime_light.colorFlag=false;
                hasRealData= false;
                high_beam.visible=true;
                high_beam.colorFlag=false;
                adaptive_on.visible=true;
                adaptive_on.colorFlag=false;
                parking_break.visible=true;
                parking_break.colorFlag=false;
                speed_read.speedValue=0;
                speedAnimation.start()
                speed_limit.source="images/Set 1/signs.png"
                sleep_cautionMassage.visible=false;
                sleep_cautionMassage.text="You Need To Take a Brake";
                alert_sleep.visible=false;
            }

            if (selected_gear.text === "D") {
                if(autopilot==0){
                    drive_mode.text="Driving Mode"
                }else{
                    drive_mode.text="Autopilot Mode"
                }
                _D.color = "#ffffff";
                if(lSignal===false && rSignal===false){
                    camera.stop() // Stop the camera (not start)
                    viewfinder.visible = false // Hide the viewfinder
                }
            } else {
                _D.color = "#7f7f7f";
            }
        }
    }


    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            clockdate.text = formatTimeWithoutAMPM(new Date())
            clockDateSign.text = Qt.formatTime(new Date(), "AP")
        }
        function formatTimeWithoutAMPM(dateTime) {
            var hours = dateTime.getHours()
            var minutes = dateTime.getMinutes()

            // Convert to 12-hour format
            var ampm = hours >= 12 ? "PM" : "AM"
            hours = hours % 12
            hours = hours ? hours : 12  // Handle midnight (12:00 AM)

            // Add leading zeros
            hours = ("0" + hours).slice(-2)
            minutes = ("0" + minutes).slice(-2)

            return hours + ":" + minutes
        }
    }

    Connections{
        target: spotify
        function onSpotifyReceivedData( Track_Name, Artist_Name, Album_Name, Album_Img_URL,is_Playing,currentTime,duration, currentTimeformatted, durationformatted){
            if(Album_Name===""){
                artistImage.visible=false
                playingNow.visible=false
                musicProgress.visible = false
                finish_time.text="00:00"
                current_time.text="00:00"
            }
            else{
                finish_time.text=durationformatted
                current_time.text=currentTimeformatted
                musicProgress.visible = true
                musicProgress.value = currentTime
                musicProgress.to = duration
                artistImage.visible=true
                playingNow.visible=true
                if(is_Playing){
                    isPlaying=is_Playing;
                    playingNow.text="Playing Now"
                }else{
                    isPlaying=is_Playing;
                    playingNow.text="Music Puased"
                }
                artistImg.source = Album_Img_URL
                songTitle.text=Track_Name
                artistName.text=Artist_Name
            }
        }
        function onIsConnectedChanged(status){
            lower_alert.visible=!status;
        }
    }

        // Python spotify
    // Connections{
    //     target: SpotifyReceiver
    //     function onSpotifyReceivedData( Track_Name, Artist_Name, Album_Name, Album_Img_URL,isPlaying){
    //         if(Album_Name===""){
    //             artistImage.visible=false
    //             playingNow.visible=false
    //         }
    //         else{
    //             artistImage.visible=true
    //             playingNow.visible=true
    //             if(isPlaying){
    //                 playingNow.text="Playing Now"
    //             }else{
    //                 playingNow.text="Music Puased"
    //             }
    //             artistImg.source = Album_Img_URL
    //             songTitle.text=Track_Name
    //             artistName.text=Artist_Name
    //         }
    //     }
    // }

}

