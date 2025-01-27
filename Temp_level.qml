import QtQuick 2.12

Item {
    width: 200
    height: 200

    // Temperature level property (range: 0.0 to 1.0)
    property real tempLevel: 0.75

    // Redraw the canvas whenever the temp level changes
    onTempLevelChanged: {
        console.log("temp level changed to: " + tempLevel)
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

            // Adjusted center and radius for top-left corner
            var padding = 10;
            var radius = (Math.min(width, height) / 2) - padding;
            var centerX = padding + radius;
            var centerY = padding + radius;

            // Draw the background arc (full quarter circle)
            ctx.beginPath();
            ctx.lineWidth = 15;
            ctx.lineCap = "round";
            ctx.strokeStyle = "black";
            // Ensure solid line for background
            ctx.setLineDash([]); // Empty array for solid line
            // Start at 270 degrees (1.5 * Math.PI) and end at 180 degrees (Math.PI), anticlockwise
            ctx.arc(centerX, centerY, radius, Math.PI * 1.5, Math.PI, true);
            ctx.stroke();

            // Calculate the end angle based on the temp level
            var endAngle = Math.PI * 1.5 - (Math.PI / 2) * tempLevel;

            // Draw the foreground arc (temp level indicator)
            ctx.beginPath();
            ctx.lineWidth = 15;
            ctx.lineCap = "round";
            ctx.strokeStyle = "#23AEBA";
            // Set dashed line pattern
            ctx.setLineDash([10, 5]); // [dash length, gap length]
            ctx.arc(centerX, centerY, radius, Math.PI * 1.5, endAngle, true);
            ctx.stroke();

            // Reset line dash pattern to solid for future drawings
            ctx.setLineDash([]);
        }
    }
}
