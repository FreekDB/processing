// Original by Antonio Belluscio: https://www.openprocessing.org/sketch/193632
// Slightly modified by Freek de Bruijn.
// Demonstrates the use of the pixels array (with loadPixels and updatePixels), the modulo operator and frameCount.


boolean drawFast = true;

void setup() {
  size(720, 720);
  loadPixels();
}

void draw() {
  for (int pixelIndex = 0; pixelIndex < pixels.length; pixelIndex++)  {
    pixels[pixelIndex] = color(((pixelIndex % frameCount) == 0) ? 255 : 0);
  }

  println(frameCount);
  
  updatePixels();
}

void mouseReleased() {
  drawFast = !drawFast;
  frameRate(drawFast ? 60 : 1);

  frameCount = 0;
  redraw();
}
