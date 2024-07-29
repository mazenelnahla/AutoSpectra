import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Styles 1.4
Item{
    id:fota
    property int loading:0
    width:1024
    height:600
    Image {
        id: fota_bg
        source: "images/fota_bg.png"
        x: 177
        y: 143
        opacity: 1
    }
    function show() {
        fota.visible = true;
    }
    Text {
        id: new_firmware_update
        text: "New Firmware Update"
        font.pixelSize: 33
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 325
        y: 167
        opacity: 1
    }
    Text {
        id: current_version_
        text: "Current Version:"
        font.pixelSize: 20
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
        text: "New Version:"
        font.pixelSize: 20
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
        x: 212
        y: 433
        value: 100
        from: 0
        to: 100
        width: 580
        height: 6
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
                width: updateProgress.visualPosition * parent.width
                height: parent.height
                radius: 2
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
        y: 403
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
        x: 213
        y: 403
        opacity: 1
    }

    Text {
        id: available
        text: "Available"
        font.pixelSize: 24
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#00b090"
        smooth: true
        x: 458
        y: 202.75
        opacity: 1
    }
    Text {
        id: new_version
        text: "v.10575.157"
        font.pixelSize: 16
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 384
        y: 246
        opacity: 1
    }
    Text {
        id: current_version
        text: "v.10579.124"
        font.pixelSize: 16
        font.family: "Arial-BoldMT"
        font.bold: true
        color: "#ffffff"
        smooth: true
        x: 353
        y: 281
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
        x: 220
        y: 452
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
        x: 601
        y: 452
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
}
