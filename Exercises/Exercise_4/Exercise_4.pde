// Generative Art Workshop: https://www.meetup.com/en-AU/Delft-Developers-Designers/events/261482407/
// October 2019, Tim van den Bosch and Freek de Bruijn
// Exercise 4: a whole bunch of shapes.


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
