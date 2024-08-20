import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
import fota.backend 1.0
Item{
    id:fota
    property int update:0
    property int loading:0
    property string current_Version
    property string new_Version
    width:1024
    height:600
    y:50
    function show() {
        fota.visible = true;
    }
    Image {
        id: fota_bg
        source: "images/fota_bg.png"
        x: 177
        y: 143
        width: 667
        height: 359
        opacity: 1
    }

    Text {
        id: new_firmware_update
        y: 168
        width: 500
        height: 40
        text: "New Firmware Update"
        font.pixelSize: 30
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: fota_bg.horizontalCenter
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true

        opacity: 1
    }
    Text {
        id: available
        text: "Available"
        font.pixelSize: 25
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        anchors.horizontalCenter: fota_bg.horizontalCenter
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#00b090"
        smooth: true
        y: 209
        width: 200
        height: 25
        opacity: 1
    }
    Text {
        id: current_version_
        text: "Current Version: "+ current_Version
        font.pixelSize: 18
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 212
        y: 243
        opacity: 1
    }
    Text {
        id: new_version_
        text: "New Version: " + new_Version
        font.pixelSize: 18
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 213
        y: 279
        opacity: 1
    }

    ProgressBar {
        id:updateProgress
        y: 409
        value: 50
        anchors.horizontalCenter: parent.horizontalCenter
        from: 0
        to: 100
        width: 560
        height: 6
        background: Rectangle {
            implicitWidth: 560
            implicitHeight: 6
            color: "#7f7f7f"
            radius: 3
        }
        contentItem: Item {
            implicitWidth: 560
            implicitHeight: 4

            Rectangle {
                width: updateProgress.visualPosition * parent.width
                height: parent.height
                radius: 5
                color: "#ffffff"
            }
        }
    }
    Text {
        id: completePresent
        text: loading + " %"
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 303
        y: 378
        opacity: 1
    }
    Text {
        id: progress
        text: "Progress:"
        font.pixelSize: 16
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 214
        y: 378
        opacity: 1
    }


    Text {
        id: details_
        text: "Details:"
        font.pixelSize: 20
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 213
        y: 315
        opacity: 1
    }
    Text {
        id: update_description
        text: "Updating Steering wheel and paddles firmware"
        font.pixelSize: 16
        wrapMode: Text.WrapAnywhere
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 296
        y: 317
        width: 489
        height: 53
        opacity: 1
    }

    Item {
        id: updateNowButton
        width: 200
        height: 50
        x: 212
        y: 426
        Image {
            source: "images/button_frame.png"
            anchors.fill: parent
            opacity: 1
        }
        Text {
            text: "Update Now"
            font.pixelSize: 18
            anchors.centerIn: parent
            font.capitalization: Font.AllUppercase
            font.family: "Arial-BoldMT"
            font.bold: true
            color: "#ffffff"
            smooth: true
            opacity: 1
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Update Now clicked")
                // Add your action for "Update Now" here
            }
        }
    }

    Item {
        id: updateLaterButton
        width: 200
        height: 50
        x: 604
        y: 426
        Image {
            source: "images/button_frame.png"
            anchors.fill: parent
            opacity: 1
        }
        Text {
            text: "Hide"
            font.pixelSize: 18
            anchors.centerIn: parent
            font.capitalization: Font.AllUppercase
            font.family: "Arial-BoldMT"
            font.bold: true
            color: "#ffffff"
            smooth: true
            opacity: 1
        }
        MouseArea {
            anchors.fill: parent
            onClicked: {
                console.log("Update Later clicked")
                fota.visible=false;
            }
        }
    }
    Connections{
        target:fota_back
        function onFotaInfo(currentVersion ,newVersion ,description ,updateFlag ,totalFileSize , sentSize, indexUpdate){
            updateProgress.value=(sentSize/totalFileSize)*100;
            loading=(sentSize/totalFileSize)*100;
            update=updateFlag;
            current_Version=currentVersion;
            new_Version=newVersion;
        }
    }
}
