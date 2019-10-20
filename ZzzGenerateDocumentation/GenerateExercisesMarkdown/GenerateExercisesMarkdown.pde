// Generative Art Workshop: https://www.meetup.com/en-AU/Delft-Developers-Designers/events/261482407/
// October 2019, Tim van den Bosch and Freek de Bruijn
// Generate Markdown documentation for the seven exercises and create some graphics while doing that.


import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

private static final List<String> EXERCISE_DESCRIPTIONS = Arrays.asList(
    "a point and a line",
    "println, size, background and ellipse",
    "point, line, rectangle and ellipse",
    "a whole bunch of shapes",
    "background, stroke and fill color",
    "random colors and lines",
    "PDF with random colors and lines"
);

private String baseDirectory;
private BufferedWriter markdownWriter;

private int penX;
private int penY;
private float maximumDistance;

// Setup with one-time initialization. (This function is called by Processing when it starts the program.)
void setup() {
    // Set the size of our artwork (width, height in pixels).
    size(800, 600);
    penX = width / 2;
    penY = height / 2;
    maximumDistance = (width + height) / 2.0;

    // Prevent the draw function below to be called continuously. For this program, the draw function will be called
    // once at the end of the setup.
    noLoop();

    generateExercisesMarkdown();

    redraw();
}

// Draw instructions to update the screen. (This function is called by Processing. For this program, Processing calls
// the draw function only when redraw is called, see the setup function above. Normally, this function is called
// very often, but the noLoop function stops this.)
void draw() {
    drawSquares(6, 6, color(0));
    
    drawSquares(40, 6, color(128));
    drawSquares(6, 40, color(128));
    
    drawSquares(74, 6, color(255));
    drawSquares(40, 40, color(255));
    drawSquares(6, 74, color(255));
}

private void drawSquares(int x, int y, color fillColor) {
    fill(fillColor);
    rect(x, y, 28, 28);
    rect(width - x - 28, height - y - 28, 28, 28);
}

private void generateExercisesMarkdown() {
    try {
        determineBaseDirectory();
        markdownWriter = new BufferedWriter(new FileWriter(baseDirectory + "Exercises/Exercises.md"));

        writeExercisesMarkdown();

        markdownWriter.close();
    } catch (IOException e) {
        e.printStackTrace();
    }
}

private void determineBaseDirectory() {
    String sketchDirectory = sketchPath();

    int endIndex = sketchDirectory.lastIndexOf(File.separatorChar);
    endIndex = sketchDirectory.lastIndexOf(File.separatorChar, endIndex - 1);

    baseDirectory = sketchDirectory.substring(0, endIndex + 1);
}

private void writeExercisesMarkdown() throws IOException {
    writeLine("# Exercises");
    writeLine("");
    writeLine("Seven exercises with code and screenshots.");
    writeLine("");

    for (int exerciseNumber = 1; exerciseNumber <= 7; exerciseNumber++) {
        writeLine("## Exercise " + exerciseNumber + ": " + EXERCISE_DESCRIPTIONS.get(exerciseNumber - 1));
        writeLine("");

        writeCodeBlock(exerciseNumber);

        writeLine("");

        writeScreenshotLine(exerciseNumber);

        writeLine("");
        writeLine("");
    }
}

private void writeCodeBlock(int exerciseNumber) throws IOException {
    String filePath = baseDirectory + "Exercises/Exercise_" + exerciseNumber + "/Exercise_" + exerciseNumber + ".pde";
    BufferedReader codeReader = new BufferedReader(new FileReader(filePath));

    List<String> relevantCodeLines = getRelevantCodeLines(codeReader);

    codeReader.close();

    writeLine("```java");

    for (String line : relevantCodeLines) {
        writeLine(line);
    }

    writeLine("```");
}

private List<String> getRelevantCodeLines(BufferedReader codeReader) throws IOException {
    List<String> codeLines = new ArrayList<String>();

    String line;
    boolean skippingHeaderLines = true;
    int lineIndex = 0;
    int startIndex = 0;

    while ((line = codeReader.readLine()) != null) {
        if (skippingHeaderLines && !line.isEmpty() && !line.startsWith("//")) {
            skippingHeaderLines = false;
            startIndex = lineIndex - 1;
        }

        codeLines.add(line);
        lineIndex++;
    }

    return codeLines.subList(startIndex, codeLines.size());
}

private void writeScreenshotLine(int exerciseNumber) throws IOException {
    String description = "Screenshot exercise " + exerciseNumber;
    String path = "../Images/Exercise_0" + exerciseNumber + ".png";

    writeLine("![" + description + "](" + path + "?raw=true \"" + description + "\")");
}

private void writeLine(String line) throws IOException {
    markdownWriter.write(line);
    markdownWriter.newLine();
    
    movePen(line);
}

// Graphics inspired by https://makezine.com/projects/draw-abstract-art-random-number-generator/
private void movePen(String line) {
    for (int characterIndex = 0; characterIndex < line.length(); characterIndex++) {
        // Move the pen in a direction that's based on the characters in the line.
        float direction = (2 * PI / 64.0) * (line.charAt(characterIndex) % 64);
        int moveX = (int) (Math.cos(direction) * 28) + 10;
        int moveY = (int) (Math.sin(direction) * 28) + 16;
        int newPenX = Math.min(Math.max(penX + moveX, 0), width - 1);
        int newPenY = Math.min(Math.max(penY + moveY, 0), height - 1);

        // The pen color depends on the distance to the screen center: darker closerto the center.
        int distanceX = newPenX - (width / 2);
        int distanceY = newPenY - (height / 2);
        float distance = sqrt(distanceX * distanceX + distanceY * distanceY);
        color penColor = color(int(255 * (distance / maximumDistance)));

        stroke(penColor);
        line(penX, penY, newPenX, newPenY);
        
        penX = newPenX;
        penY = newPenY;
    }
}
