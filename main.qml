import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import com.company.serialmanager 1.0
import MyPythonScript 1.0
import com.company.cardatareceiver 1.0
import QtQuick.Controls.Styles 1.4
import QtGraphicalEffects 1.0
import QtMultimedia 5.12
Window {
    id: window
    maximumHeight: 600
    maximumWidth: 1024
    minimumHeight: 600
    minimumWidth: 1024
    width: 1024
    height: 600
    visible: true
    //    visibility: "FullScreen"
    //    screen: Qt.application.screens[1]
    title: qsTr("Instrument Cluster")
    color: "#3e3c3c"
    Image {
        id: color_fill_1
        source: "images/color_fill_1.png"
        x: 0
        y: 0
        opacity: 1
    }

    Image {
        id: rectangle_1
        source: "images/rectangle_1.png"
        x: 200
        y: 153
        opacity: 0.83921568627451
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

    Image {
        id: right_side
        source: "images/right_side.png"
        x: 616
        y: 113
        opacity: 1
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
        maximumValue: 250
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
            text: qsTr("250")
            font.pixelSize: 17
            font.bold: true
        }
    }

    Image {
        id: upper_status
        source: "images/upper_status.png"
        x: -51
        y: -150
        opacity: 1
    }
    Image {
        id: lower_status
        source: "images/lower_status.png"
        x: 250
        y: 507
        opacity: 1
    }
    Text {
        id: miles_value
        text: "0000"
        font.pixelSize: 16
        font.family: "Arial-Black"
        color: "#d0d0d0"
        smooth: true
        x: 793
        y: 389
        opacity: 1
    }
    Text {
        id: gear
        text: "Gear"
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.capitalization: Font.AllUppercase
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#e7bf8c"
        smooth: true
        x: 798
        y: 239
        opacity: 1
    }
    Text {
        id: speed_read
        text: "0"
        font.pixelSize: 80
        horizontalAlignment: Text.AlignHCenter
        font.family: "GoogleSansDisplay-Bold"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 118
        y: 261
        width: 167
        height: 97
        opacity: 1
        visible: false
    }
    Text {
        id: selected_gear
        text: "P"
        font.pixelSize: 80
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "GoogleSansDisplay-Bold"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 737
        y: 261
        width: 170
        height: 86
        opacity: 1
    }

    Image {
        id: speed_limit
        source: "images/speed_limit.png"
        x: 247
        y: 363
        opacity: 1
        visible: true
    }
    Image {
        id: door_open
        source: "images/door_open.png"
        x: 77
        y: 17
        opacity: 1
    }
    Image {
        id: low_bat
        source: "images/low_bat.png"
        x: 782
        y: 72
        opacity: 1
        visible: true
    }
    Image {
        id: parking_break
        source: "images/parking_break.png"
        x: 144
        y: 49
        opacity: 1
        visible: true
    }
    Image {
        id: seat_belt
        source: "images/seat_belt.png"
        x: 210
        y: 65
        opacity: 1
        visible: true
    }
    Image {
        id: steering_error
        source: "images/steering_error.png"
        x: 853
        y: 44
        opacity: 1
        visible: true
    }
    Image {
        id: assist_disable
        source: "images/assist_disable.png"
        x: 919
        y: 15
        opacity: 1
        visible: true
    }
    Image {
        id: high_beam
        source: "images/high_beam.png"
        x: 393
        y: 551
        opacity: 1
    }
    Image {
        id: low_beam
        source: "images/low_beam.png"
        x: 521
        y: 551
        opacity: 1
    }
    Image {
        id: adaptive_off
        source: "images/adaptive_off.png"
        x: 457
        y: 551
        opacity: 1
    }
    Image {
        id: adaptive_on
        source: "images/adaptive_on.png"
        x: 457
        y: 551
        opacity: 1
    }
    Image {
        id: daytime_light
        source: "images/daytime_light.png"
        x: 584
        y: 553
        opacity: 1
    }
    Text {
        id: alert_
        text: "Alert:"
        font.pixelSize: 18
        font.capitalization: Font.AllUppercase
        font.weight: Font.Black
        font.family: "Arial-Black"
        color: "#d82927"
        smooth: true
        x: 323
        y: 83
        opacity: 1
        visible: false
    }
    Text {
        id: _cautionMassage
        text: "Driver need to take a break!"
        font.pixelSize: 18
        font.bold: true
        font.capitalization: Font.AllUppercase
        font.family: "Arial-Black"
        color: "#ffffff"
        smooth: true
        x: 393
        y: 83
        width: 306
        height: 19
        opacity: 1
        visible: false
    }
    Text {
        id: clockdate
        text: "00:00"
        font.pixelSize: 20
        font.family: "GoogleSansDisplay-Bold"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 304
        y: 34
        opacity: 1
    }
    Text {
        id: clockDateSign
        text: "PM"
        font.pixelSize: 12
        font.family: "GoogleSansDisplay-Bold"
        font.bold: true
        color: "#7f7f7f"
        smooth: true
        x: 368
        y: 42
        opacity: 1
    }
    Text {
        id: tempLabel
        text: "Nan"
        font.pixelSize: 22
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Black
        font.family: "Arial-Black"
        color: "#ffffff"
        smooth: true
        x: 647
        y: 37
        width: 44
        height: 27
        opacity: 1

        Text {
            id: tempDegree
            text: "o"
            font.pixelSize: 15
            font.family: "ArialMT"
            color: "#7f7f7f"
            smooth: true
            x: 47
            y: -6
            width: 7
            opacity: 1
        }
        Text {
            id: tempSign
            text: "c"
            font.pixelSize: 23
            font.family: "ArialMT"
            color: "#7f7f7f"
            smooth: true
            x: 52
            y: 0
            opacity: 1
        }
    }

    Image {
        id: artistImage
        source: "images/group_1.png"
        x: 425
        y: 216
        opacity: 1
        visible: true
        Text {
            id: playingNow
            text: "Playing Now"
            font.pixelSize: 21
            horizontalAlignment: Text.AlignHCenter
            font.weight: Font.Black
            font.family: "Arial-Black"
            color: "#f2f2f2"
            smooth: true
            x: 0
            y: -36
            width: 169
            height: 25
            opacity: 0.70196078431373
        }

        Text {
            id: songTitle
            text: "...ready for it?"
            font.pixelSize: 20
            horizontalAlignment: Text.AlignHCenter
            font.family: "Arial-Black"
            color: "#ffffff"
            smooth: true
            x: -11
            y: 178
            width: 180
            height: 24
            opacity: 1
        }

        Text {
            id: artistName
            text: "Taylor Swift"
            font.pixelSize: 19
            horizontalAlignment: Text.AlignHCenter
            font.family: "Arial-Black"
            color: "#ffffff"
            smooth: true
            x: 0
            y: 206
            width: 169
            height: 19
            opacity: 0.4
        }
    }
    Text {
        id: _P
        x: 776
        y: 353
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
        x: 802
        y: 353
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
        x: 828
        y: 353
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
        x: 852
        y: 353
        width: 20
        height: 20
        color: "#7f7f7f"
        text: qsTr("R")
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Black
    }
    Text {
        id: sport_mode
        text: "Sport Mode"
        font.pixelSize: 18
        horizontalAlignment: Text.AlignHCenter
        font.capitalization: Font.AllUppercase
        font.weight: Font.Black
        font.family: "Arial"
        color: "#e7bf8c"
        smooth: true
        x: 447
        y: 35
        width: 133
        height: 22
        opacity: 1
    }

    Image {
        id: rightlabel
        x: 592
        y: 29
        width: 35
        height: 35
        source: "images/right.png"
        fillMode: Image.PreserveAspectFit
        opacity:0
        visible: true

        SequentialAnimation {
            running: true
            loops: Animation.Infinite  // Infinite looping

            PropertyAction {
                target: rightlabel
                property: "opacity"
                value: 1
            }

            NumberAnimation {
                target: rightlabel
                property: "opacity"
                to: 0
                duration: 600  // Adjust the duration of the fade-out
            }

            NumberAnimation {
                target: rightlabel
                property: "opacity"
                to: 1
                duration: 600  // Adjust the duration of the fade-in
            }
        }
    }

    Image {
        id: leftlabel
        x: 399
        y: 29
        width: 35
        height: 35
        source: "images/left.png"
        fillMode: Image.PreserveAspectFit
        opacity:0

        SequentialAnimation {
            running: true
            loops: Animation.Infinite  // Infinite looping

            PropertyAction {
                target: leftlabel
                property: "opacity"
                value: 1
            }

            NumberAnimation {
                target: leftlabel
                property: "opacity"
                to: 0
                duration: 600  // Adjust the duration of the fade-out
            }

            NumberAnimation {
                target: leftlabel
                property: "opacity"
                to: 1
                duration: 600  // Adjust the duration of the fade-in
            }
        }
    }

    Image {
        id: wanring_massage
        source: "images/wanring_massage.png"
        x: 293
        y: 294
        opacity: 1
        visible: false

        Text {
            id: _errorEngine
            x: 50
            y: 91
            width: 343
            height: 89
            color: "#e8c291"
            text: qsTr("Engine operating at reduced output. Possible to continue. Drive with caution. Have the system checked by nearest service center.")
            font.pixelSize: 19
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.weight: Font.DemiBold
            layer.format: ShaderEffectSource.RGBA
            layer.textureMirroring: ShaderEffectSource.MirrorHorizontally
            layer.wrapMode: ShaderEffectSource.ClampToEdge
            font.preferShaping: true
            font.kerning: true
        }

        Text {
            id: _errorAirbag
            x: 50
            y: 91
            width: 343
            height: 89
            color: "#e8c291"
            text: qsTr("Engine operating at reduced output. Possible to continue. Drive with caution. Have the system checked by nearest service center.")
            font.pixelSize: 19
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.weight: Font.DemiBold
            layer.format: ShaderEffectSource.RGBA
            layer.textureMirroring: ShaderEffectSource.MirrorHorizontally
            layer.wrapMode: ShaderEffectSource.ClampToEdge
            font.preferShaping: true
            font.kerning: true
        }

        Text {
            id: _errorSteering
            x: 50
            y: 91
            width: 343
            height: 89
            color: "#e8c291"
            text: qsTr("Engine operating at reduced output. Possible to continue. Drive with caution. Have the system checked by nearest service center.")
            font.pixelSize: 19
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.weight: Font.DemiBold
            layer.format: ShaderEffectSource.RGBA
            layer.textureMirroring: ShaderEffectSource.MirrorHorizontally
            layer.wrapMode: ShaderEffectSource.ClampToEdge
            font.preferShaping: true
            font.kerning: true
        }

        Text {
            id: _errorRadarDetected
            x: 50
            y: 91
            width: 343
            height: 89
            color: "#e8c291"
            text: qsTr("Engine operating at reduced output. Possible to continue. Drive with caution. Have the system checked by nearest service center.")
            font.pixelSize: 19
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.Wrap
            font.weight: Font.DemiBold
            layer.format: ShaderEffectSource.RGBA
            layer.textureMirroring: ShaderEffectSource.MirrorHorizontally
            layer.wrapMode: ShaderEffectSource.ClampToEdge
            font.preferShaping: true
            font.kerning: true
        }

        Text {
            id: _errorTitle
            x: 98
            y: 52
            color: "#d92a27"
            text: qsTr("Engine malfunction")
            font.pixelSize: 19
            font.capitalization: Font.Capitalize
            font.weight: Font.ExtraBold
        }
    }

    Connections {
        target: serialManager
        onTemperatureChanged: {tempLabel.text = ""+newTemp;}
        onSpeedChanged:{if(selected_gear.text === "P"){
                speed_read.text = 0;
            }else{
                speed_read.text = ""+newSpeed;}
        }
        onDoorStatusChanged:{
            if(newDoorStatus){
                door_open.visible=false;
            }else{
                door_open.visible=true;
            }
        }
        onSelectedGearChanged:{
            selected_gear.text=selectedGear;
            if (selected_gear.text === "P") {
                _P.color = "#ffffff";
            } else {
                _P.color = "#7f7f7f";
            }
            if (selected_gear.text === "N") {
                _N.color = "#ffffff";
            } else {
                _N.color = "#7f7f7f";
            }
            if (selected_gear.text === "D") {
                _D.color = "#ffffff";
            } else {
                _D.color = "#7f7f7f";
            }
            if (selected_gear.text === "R") {
                _R.color = "#ffffff";
            } else {
                _R.color = "#7f7f7f";
            }
        }
    }

    Connections {
        target: carDataReceiver
        onSleepStatusChanged: {
            if(sleepStatus==1){
                _cautionMassage.visible=true;
                alert_.visible=true;
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
    Connections {
        target: serialManager
        onTemperatureChanged: {tempLabel.text = ""+newTemp+" C";}
        onSelectedGearChanged:{
            if(selected_gear.text === "R"){
                camera.start() // Start the camera
                viewfinder.visible = true // Show the viewfinder
                artistImage.visible=false
            }else{
                camera.stop() // Stop the camera (not start)
                viewfinder.visible = false // Hide the viewfinder
                artistImage.visible=true
            }
        }
    }



}





/*##^##
Designer {
    D{i:0;formeditorZoom:0.66}
}
##^##*/
