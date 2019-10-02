// Generative Art Workshop: https://www.meetup.com/en-AU/Delft-Developers-Designers/events/261482407/
// October 2019, Tim van den Bosch and Freek de Bruijn
// Exercise 5: background, stroke and fill color.


// Set the size of our artwork (width, height in pixels).
size(480, 640);

// Background color: black.
background(0);

// Stroke color: white. This color is used to draw lines and borders around shapes.
stroke(255);

// Fill color: yellow. This color is used to fill shapes and draw text.
fill(250, 180, 20);

// Draw a rectangle with a stroke width of 12 pixels (= border width).
strokeWeight(12);
rect(80, 80, 320, 480);

// Text is drawn in fill color.
textSize(24);
text("I love fill color!", 154, 600);
