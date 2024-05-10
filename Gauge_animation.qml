import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Controls.Styles 1.4
import QtQuick.Extras 1.4
import QtQuick.Extras.Private 1.0
import QtGraphicalEffects 1.0

CircularGauge {
    id: gauge

    style: CircularGaugeStyle {
        minimumValueAngle: -150
        maximumValueAngle: 150

        background: Rectangle {
            implicitHeight: gauge.height
            implicitWidth: gauge.width
            color:  "#0039383c"
            anchors.centerIn: parent
            radius: 360

            Image {
                anchors.fill: parent
                source: "qrc:/img/background.svg"
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

                onPaint: {
                    var ctx = getContext("2d");
                    ctx.reset();
                    ctx.beginPath();
                    ctx.strokeStyle = "#39383c"
                    ctx.lineWidth = 46
                    ctx.arc(outerRadius,
                          outerRadius,
                          outerRadius - ctx.lineWidth / 2,
                          degreesToRadians(valueToAngle(gauge.value) - 90),
                          degreesToRadians(valueToAngle(gauge.maximumValue + 1) - 90)
                            );
                    ctx.stroke();
                }
            }
        }

        foreground: Item {
            Text {
                x: 114
                y: 261
                font.family: "GoogleSansDisplay-Bold"
                font.bold: true
                smooth: true
                anchors.centerIn: parent
                text: gauge.value.toFixed(0)
                font.pixelSize: 80
                color: "white"
                antialiasing: true
            }
        }

        tickmarkLabel: Text {
            visible: false
        }

        tickmark: Rectangle {
            visible: false
        }
        needle: Item {
            visible: false
        }
        minorTickmark: Rectangle {
            visible: false
        }
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
