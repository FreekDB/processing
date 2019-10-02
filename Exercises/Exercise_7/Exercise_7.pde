// Generative Art Workshop: https://www.meetup.com/en-AU/Delft-Developers-Designers/events/261482407/
// October 2019, Tim van den Bosch and Freek de Bruijn
// Exercise 7: PDF with random colors and lines.

// For more examples on how to create PDFs from your Processing programs, see:
// https://processing.org/reference/libraries/pdf/index.html


// Import the PDF functionality.
import processing.pdf.*;

// Setup with one-time initialization. (This function is called by Processing when it starts the program.)
void setup() {
  // Set the size of our artwork (width, height in pixels). We use the same ratio as A4 paper (210 x 297 mm).
  // Switch these numbers for landscape.
  size(594, 840);

  // Prevent the draw function below to be called continuously. For this program, the draw function will be called
  // whenever the user presses a mouse button.
  noLoop();
}

// Draw instructions to update the screen. (This function is called by Processing. For this program, Processing calls
// the draw function only when redraw is called, see the mousePressed function below. Normally, this function is called
// very often, but the noLoop function stops this.)
void draw() {
  // Start recording drawing instructions for a PDF. The "####" part is replaced with the frame number.
  beginRecord(PDF, "frame-####.pdf");

  // Pick random color parts to create a random background color.
  int redPart = int(random(255));
  int greenPart = int(random(255));
  int bluePart = int(random(255));
  background(redPart, greenPart, bluePart);

  // Pick a random number of lines to draw (from 10 up to 1,000).
  int lineCount = int(random(10, 1000));

  // Repeat the following block for each line we want to draw (lineCount times).
  for (int lineIndex = 0; lineIndex < lineCount; lineIndex++) {
    // Pick two random points on the display window to form a random line.
    float x1 = random(0, width);
    float y1 = random(0, height);
    float x2 = random(0, width);
    float y2 = random(0, height);

    // Draw a line between the two random points.
    line(x1, y1, x2, y2);
  }

  // End the recording for a PDF. It should be created in the same directory as where the Processing program is stored.
  endRecord();
}

// Handle a mouse button that was pressed by the user.
void mousePressed() {
  // Calling the redraw function makes sure the draw function above is called once.
  redraw();
}
