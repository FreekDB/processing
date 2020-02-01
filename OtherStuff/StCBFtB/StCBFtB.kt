// Title: See the City But For the Buildings.
// Author: Freek de Bruijn.
// Languages: Processing + Kotlin (a very promising partnership).
// Date: October 3rd, 2019 (in Java) and January 21st, 2020 (in Kotlin).
// Link: http://bit.ly/StCBFtB

import freek.processingkotlin.ProcessingSketch
import kotlin.random.Random

fun main() {
    SeeTheCityButForTheBuildings().runProcessingSketch()
}

class SeeTheCityButForTheBuildings : ProcessingSketch() {
    // Nice reproducible randomness.
    private val randomGenerator = Random(seed = 642)

    // Settings: run in full screen mode.
    override fun settings() {
        fullScreen()
    }

    // Setup: rectangles are drawn with a white border and not filled;
    // drawing is not done continuously.
    override fun setup() {
        stroke(color = white)
        noFill()

        noLoop()
    }

    // Draw: pick a random number of rectangles and draw with random coordinates.
    override fun draw() {
        background(color = black)

        val rectangleCount = (10 until 1000).random(random = randomGenerator)
        println("The algorithm has decided to draw $rectangleCount rectangles.")

        repeat(rectangleCount) {
            val x1 = (0 until width).random(random = randomGenerator)
            val y1 = (0 until height).random(random = randomGenerator)
            val x2 = (0 until width).random(random = randomGenerator)
            val y2 = (0 until height).random(random = randomGenerator)

            // Draw a rectangle between two random points? Serendipity strikes
            // again! The values of the second point are actually used as width
            // and height! This leads to more rectangles in the bottom right
            // corner and fewer in the upper left corner, which I really like :-)
            rect(x = x1, y = y1, width = x2, height = y2)
        }
    }

    // Key pressed: fill the screen with new random rectangles.
    override fun keyPressed() {
        redraw()
    }
}
