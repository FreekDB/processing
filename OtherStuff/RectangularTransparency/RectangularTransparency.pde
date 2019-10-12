// Generative Art Workshop: https://www.meetup.com/en-AU/Delft-Developers-Designers/events/261482407/
// October 2019, Tim van den Bosch and Freek de Bruijn
// Transparent rectangles.


// Setup with one-time initialization. (This function is called by Processing when it starts the program.)
void setup() {
  // Full screen mode.
  fullScreen();

  // Borders are drawn in white and rectangles (and other shapes) are transparent (not filled).
  stroke(255);
  noFill();

  // Prevent the draw function below to be called continuously. For this program, the draw function will be called
  // whenever the user presses a mouse button or a key.
  noLoop();
}

// Draw instructions to update the screen. (This function is called by Processing. For this program, Processing calls
// the draw function only when redraw is called, see the mousePressed function below. Normally, this function is called
// very often, but the noLoop function stops this.)
void draw() {
  // Use black as the background color and clear the screen.
  background(0);

  // Pick a random number of rectangles to draw (from 10 up to 1,000).
  int rectangleCount = int(random(10, 1000));
  println("The algorithm has decided to draw " + rectangleCount + " rectangles.");

  // Repeat the following block for each rectangle we want to draw (rectangleCount times).
  for (int rectangleIndex = 0; rectangleIndex < rectangleCount; rectangleIndex++) {
    // Pick two random points on the display window to form a random rectangle.
    float x1 = random(0, width);
    float y1 = random(0, height);
    float x2 = random(0, width);
    float y2 = random(0, height);

    // Draw a rectangle between the two random points?
    // Actually, the coordinates of the second point are used as width and height. This results in more rectangles in
    // the bottom right corner and fewer rectangles in the upper left corner, which I like.
    rect(x1, y1, x2, y2);
  }
}

// Handle a mouse button that was pressed by the user.
void mousePressed() {
  // Calling the redraw function makes sure the draw function above is called once.
  redraw();
}

// Handle a key that was pressed by the user.
void keyPressed() {
  // Calling the redraw function makes sure the draw function above is called once.
  redraw();
}
