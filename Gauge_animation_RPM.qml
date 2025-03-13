import QtQuick 2.15
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import QtGraphicalEffects 1.0

CircularGauge {
    id: gauge

    style: CircularGaugeStyle {


        background: Rectangle {
            implicitHeight: gauge.height
            implicitWidth: gauge.width
            color:  "#0039383c"
            anchors.centerIn: parent
            radius: 360
            Image {
                id:needleColor1
                visible: false
                anchors.fill: parent
                source: "/img/background60.svg"
                asynchronous: true
                sourceSize {
                    width: width
                }
            }
            Image {
                id:needleColor2
                visible: false
                anchors.fill: parent
                source: "/img/background120.svg"
                asynchronous: true
                sourceSize {
                    width: width
                }
            }
            Image {
                id:needleColor3
                visible: false
                anchors.fill: parent
                source: "/img/background.svg"
                asynchronous: true
                sourceSize {
                    width: width
                }
            }

            Canvas {
                property int value: gauge.value

                anchors.fill: parent
                onValueChanged: requestPaint()

                function degreesToRadians(degrees) {
                    return degrees * (Math.PI / 180);
                }

                Repeater {
                    model: 9
                    delegate: Text {
                        property real angle: -235 + (index * 36)
                        property real radius: gauge.width / 2 - 30 // Adjust radius as needed
                        property real xOffset: Math.cos(Math.PI * angle / 180) * radius
                        property real yOffset: Math.sin(Math.PI * angle / 180) * radius
                        x: (gauge.width / 2) + xOffset - width / 2
                        y: (gauge.height / 2) + yOffset - height / 2
                        text: (0 + (index * 1)).toFixed(0)  // Show 1k, 2k, 3k, etc.
                        color:(0 + (index * 1)) >= 6 ? "#d92a27" : "#e5e5e5"
                        font.pixelSize: 20
                        font.bold:true
                        transform: Rotation {
                            origin.x: x + width / 2
                            origin.y: y + height / 2
                            angle: angle
                        }
                    }
                }

                onPaint: {
                    if(gauge.value>0&&gauge.value<3000){
                        needleColor1.visible=true
                        needleColor2.visible=false
                        needleColor3.visible=false
                    }
                    if (gauge.value>=3000&&gauge.value<6000){
                        needleColor1.visible=false
                        needleColor2.visible=true
                        needleColor3.visible=false
                    }
                    if(gauge.value>=6000){
                        needleColor1.visible=false
                        needleColor2.visible=false
                        needleColor3.visible=true
                    }
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.beginPath();
                    ctx.strokeStyle = "#39383C"
                    ctx.lineWidth = 46
                    ctx.arc(outerRadius,
                        outerRadius,
                        outerRadius - ctx.lineWidth / 2,
                        degreesToRadians(valueToAngle(gauge.value)-90),
                        degreesToRadians(valueToAngle(gauge.maximumValue+1)-90)
                    );
                    ctx.stroke();
                }
            }
        }

        tickmarkLabel: Text {
            visible: false
        }

        tickmark: Rectangle {
            visible: styleData.value % 1000 == 0
            implicitWidth: outerRadius * 0.02
            antialiasing: true
            implicitHeight: outerRadius * 0.1
            color: styleData.value >= 6000 ? "red" : "#e5e5e5"
        }

        needle: Rectangle {
            y: outerRadius * 0.15
            implicitWidth: outerRadius * 0.03
            implicitHeight: outerRadius * 1.15
            antialiasing: true
            color: "orange"
        }

        minorTickmark: Rectangle {
            visible: styleData.value < 8000
            implicitWidth: outerRadius * 0.018
            antialiasing: true
            implicitHeight: outerRadius * 0.03
            color: styleData.value >= 6000 ? "red" : "#e5e5e5"
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
