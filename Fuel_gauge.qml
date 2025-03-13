import QtQuick 2.12
import QtGraphicalEffects 1.0

Item {
    width: 200
    height: 200

    // Fuel level property (range: 0.0 to 1.0)
    property real fuelLevel: 0.75

    // Redraw the canvas whenever the fuel level changes
    onFuelLevelChanged: {
        canvas.requestPaint()
    }
    Image{
        id:gas_icon_fuel
        source:"/images/Gas_icon.png"
        height:20
        width:20
        x:305
        y:20
        visible: false
    }
    ColorOverlay {
        anchors.fill: gas_icon_fuel
        source: gas_icon_fuel
        color:  "white"
    }

    Canvas {
        id: canvas
        anchors.fill: parent

        Component.onCompleted: {
            requestPaint()
        }

        onPaint: {
            var ctx = getContext("2d");

            // Clear the canvas
            ctx.clearRect(0, 0, width, height);

            // Adjusted center and radius
            var padding = 10;
            var radius = (Math.min(width, height) / 2) - padding;
            var centerX = width - padding - radius;
            var centerY = padding + radius;

            // Draw the background arc (full quarter circle)
            ctx.beginPath();
            ctx.lineWidth = 15;
            ctx.lineCap = "round";
            ctx.strokeStyle = "black";
            ctx.arc(centerX, centerY, radius, Math.PI * 1.5, Math.PI * 2, false);
            ctx.stroke();

            // Calculate the end angle based on the fuel level
            var endAngle = Math.PI*2 - (Math.PI / 2) * fuelLevel;

            // Draw the foreground arc (fuel level indicator)
            ctx.beginPath();
            ctx.lineWidth = 15;
            ctx.lineCap = "round";
            ctx.strokeStyle = "orange";
            ctx.arc(centerX, centerY, radius, Math.PI *2, endAngle, true);
            ctx.stroke();
        }
    }
}
