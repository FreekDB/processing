# Exercises

Seven exercises with code and screenshots.

## Exercise 1: a point and a line

```java
// Draw a point (8, 52).
point(8, 52);

// Draw a line from point (10, 50) to point (40, 10).
line(10, 50, 40, 10);
```

![Screenshot exercise 1](../Images/Exercise_01.png?raw=true "Screenshot exercise 1")


***
## Exercise 2: println, size, background and ellipse

```java
// Write a message to the console area.
println("Hello, Delft Developers & Designers!");

// Set the size of our artwork (width, height in pixels).
size(500, 500);

// Paint the background yellow (amount of red, green, blue in 0..255).
background(255, 255, 0);

// Draw a circle (x, y of center in pixels; width, height in pixels).
ellipse(300, 100, 100, 100);
```

![Screenshot exercise 2](../Images/Exercise_02.png?raw=true "Screenshot exercise 2")


## Exercise 3: point, line, rectangle and ellipse

```java
// Set the size of our artwork (width, height in pixels).
size(496, 496);

// Trying to make enough points to make them visible.
point(10, 10);
point(10, 11);
point(10, 12);

point(11, 11);

point(12, 10);
point(12, 11);
point(12, 12);

// Line.
line(20, 20, 480, 480);

// Rectangle.
rect(80, 20, 400, 40);

// Ellipse.
ellipse(150, 320, 280, 60);
```

![Screenshot exercise 3](../Images/Exercise_03.png?raw=true "Screenshot exercise 3")


## Exercise 4: a whole bunch of shapes

```java
// Set the size of our artwork (width, height in pixels).
size(480, 640);

background(255);
stroke(0);
fill(0);

// Large points, using the strokeWeight function.
strokeWeight(6);
point(310, 60);
point(320, 70);
point(330, 80);
point(340, 90);

// We can even add text!
textSize(18);
text("Try to recreate one or more shapes", 40, 140);

// Lines with different widths, using the strokeWeight function.
strokeWeight(2);
line(40, 170, 40, 240);
line(50, 170, 50, 240);

strokeWeight(1);
line(240, 170, 400, 170);
strokeWeight(2);
line(240, 180, 400, 180);
strokeWeight(3);
line(240, 190, 400, 190);
strokeWeight(4);
line(240, 200, 400, 200);
strokeWeight(5);
line(240, 210, 400, 210);
strokeWeight(6);
line(240, 220, 400, 220);

// A large square with some smaller squares on top of it.
fill(255);
strokeWeight(2);
rect(40, 300, 100, 100);
rect(40, 300, 80, 80);
rect(40, 300, 60, 60);
rect(40, 300, 40, 40);

// Some overlapping squares.
strokeWeight(1);
rect(200, 300, 40, 40);
rect(220, 320, 40, 40);
rect(240, 340, 40, 40);
rect(260, 360, 40, 40);

// Some overlapping rectangles with rounded corners.
strokeWeight(2);
rect(370, 300, 40, 40, 12);
rect(360, 320, 60, 40, 12);
rect(350, 340, 80, 40, 12);
rect(340, 360, 100, 40, 12);

// New shape: arc! An arc is part of an ellipse.
strokeWeight(1);
// x, y, width, height, start angle, stop angle (angles: 0..2 * PI)
arc(100, 500, 100, 100, 0, 2 * PI);
arc(100, 500, 80, 100, 0, 2 * PI);
arc(100, 500, 60, 100, 0, 2 * PI);
arc(100, 500, 40, 100, 0, 2 * PI);
arc(100, 500, 20, 100, 0, 2 * PI);

// New shape: triangle! Connect any three points.
triangle(180, 450, 280, 450, 280, 550);
triangle(300, 450, 300, 550, 400, 550);
```

![Screenshot exercise 4](../Images/Exercise_04.png?raw=true "Screenshot exercise 4")


## Exercise 5: background, stroke and fill color

```java
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
```

![Screenshot exercise 5](../Images/Exercise_05.png?raw=true "Screenshot exercise 5")


## Exercise 6: random colors and lines

```java
// Setup with one-time initialization. (This function is called by Processing when it starts the program.)
void setup() {
  // Set the size of our artwork (width, height in pixels). We use the same ratio as A4 paper (210 x 297 mm).
  size(420, 594);

  // Prevent the draw function below to be called continuously. For this program, the draw function will be called
  // whenever the user presses a mouse button.
  noLoop();
}

// Draw instructions to update the screen. (This function is called by Processing. For this program, Processing calls
// the draw function only when redraw is called, see the mousePressed function below. Normally, this function is called
// very often, but the noLoop function stops this.)
void draw() {
  // Pick random color parts to create a random background color.
  int redPart = int(random(255));
  int greenPart = int(random(255));
  int bluePart = int(random(255));
  background(redPart, greenPart, bluePart);

  // Pick a random number of lines to draw (from 10 up to 1,000).
  int lineCount = int(random(10, 1000));
  println("The algorithm has decided to draw " + lineCount + " lines.");

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
}

// Handle a mouse button that was pressed by the user.
void mousePressed() {
  // Calling the redraw function makes sure the draw function above is called once.
  redraw();
}
```

![Screenshot exercise 6](../Images/Exercise_06.png?raw=true "Screenshot exercise 6")


## Exercise 7: PDF with random colors and lines

```java
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
  println("The algorithm has decided to draw " + lineCount + " lines.");

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
```

![Screenshot exercise 7](../Images/Exercise_07.png?raw=true "Screenshot exercise 7")


