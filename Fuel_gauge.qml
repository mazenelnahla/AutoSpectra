import QtQuick 2.12

Item {
    width: 200
    height: 200

    // Fuel level property (range: 0.0 to 1.0)
    property real fuelLevel: 0.75

    // Redraw the canvas whenever the fuel level changes
    onFuelLevelChanged: {
        console.log("Fuel level changed to: " + fuelLevel)
        canvas.requestPaint()
    }
    Canvas {
        id: canvas
        anchors.fill: parent

        Component.onCompleted: {
            console.log("Canvas component completed")
            requestPaint()
        }

        onPaint: {
            console.log("Canvas onPaint called")
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
            var endAngle = Math.PI * 1.5 + (Math.PI / 2) * fuelLevel;

            // Draw the foreground arc (fuel level indicator)
            ctx.beginPath();
            ctx.lineWidth = 15;
            ctx.lineCap = "round";
            ctx.strokeStyle = "red";
            ctx.arc(centerX, centerY, radius, Math.PI * 1.5, endAngle, false);
            ctx.stroke();
        }
    }
}
