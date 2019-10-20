// Stipple Cat by Jim Bumgardner: https://www.openprocessing.org/sketch/47364
// Modified by Freek de Bruijn: https://github.com/FreekDB/processing.

// Cat images: part of the original version of Stipple Cat by Jim Bumgardner.

// Dog images: https://wifflegif.com/gifs/192113-dalmatian-puppy-baby-dalmatian-gif

// Horse images by Eadweard Muybridge, https://en.wikipedia.org/wiki/Eadweard_Muybridge
// Animation by Nevit Dilmen - Library of Congress Prints and Photographs Division;
// http://hdl.loc.gov/loc.pnp/cph.3a45870, Public Domain, https://commons.wikimedia.org/w/index.php?curid=3828100

// GIFs were split into separate images using https://ezgif.com/split


final int CAT = 1;
final int DOG = 2;
final int HORSE = 3;

final int ANIMAL = selectAnimal();

final int FRAME_RATE = 24;
final int ANIMAL_SPEED = 2;

final int IMAGE_WIDTH = (ANIMAL == CAT) ? 136 : ((ANIMAL == DOG) ? 320 : 340);
final int IMAGE_HEIGHT = (ANIMAL == CAT) ? 68 : ((ANIMAL == DOG) ? 180 : 230);

final int WINDOW_WIDTH = 500;
final int WINDOW_HEIGHT = 320;
//final int WINDOW_WIDTH = int(1.5 * IMAGE_WIDTH);
//final int WINDOW_HEIGHT = int(1.5 * IMAGE_HEIGHT);

final float IMAGE_SCALE = (1.0 * WINDOW_WIDTH) / IMAGE_WIDTH;

final int ANIMAL_FRAME_COUNT = (ANIMAL == CAT) ? 8 : ((ANIMAL == DOG) ? 31 : 11);
final PImage[] animalImages = new PImage[ANIMAL_FRAME_COUNT];
PImage currentAnimalImage;

final int PARTICLE_COUNT = 2200;
final Particle[] particles = new Particle[PARTICLE_COUNT];

final float MINIMUM_RADIUS = sqrt((WINDOW_WIDTH * WINDOW_HEIGHT) / (PI * PARTICLE_COUNT));
final float MAXIMUM_RADIUS = MINIMUM_RADIUS * MINIMUM_RADIUS;

final float DAMPING = 0.7;
final float K_SPEED = 3.0;
final float MINIMUM_DISTANCE_FACTOR = 2.5; // area of influence - smaller numbers make rendering go faster

int selectAnimal() {
    return HORSE;
}

void settings() {
    size(WINDOW_WIDTH, WINDOW_HEIGHT);
}

void setup() {
    frameRate(FRAME_RATE);
    smooth();
    noStroke();
    background(255);

    for (int animalFrameIndex = 0; animalFrameIndex < ANIMAL_FRAME_COUNT; animalFrameIndex++) {
        String prefix = (ANIMAL == CAT) ? "cat_" : ((ANIMAL == DOG) ? "dog_" : "horse_");
        String indexWithLeadingZero = ((animalFrameIndex < 10) ? "0" : "") + animalFrameIndex;
        String extension = (ANIMAL == CAT) ? ".png" : ".gif";

        animalImages[animalFrameIndex] = loadImage(prefix + indexWithLeadingZero + extension);
    }

    currentAnimalImage = animalImages[0];

    for (int particleIndex = 0; particleIndex < PARTICLE_COUNT; particleIndex++) {
        particles[particleIndex] = new Particle(random(width), random(height));
    }
}

void draw() {
    doPhysics();

    fill(255, 64);
    rect(0, 0, width, height);

    stroke(0);
    strokeWeight(MINIMUM_RADIUS);

    for (int particleIndex = 0; particleIndex < PARTICLE_COUNT; particleIndex++) {
        point(particles[particleIndex].x, particles[particleIndex].y);
    }
}

private void doPhysics() {
    // Adjust the current animal image if needed.
    if (frameCount % ANIMAL_SPEED == 0) {
        int animalImageIndex = (frameCount / ANIMAL_SPEED) % ANIMAL_FRAME_COUNT;
        currentAnimalImage = animalImages[animalImageIndex];
    }

    // Calculate particle radius based on the current animal image and do other initializations.
    for (int particleIndex = 0; particleIndex < PARTICLE_COUNT; particleIndex++) {
        Particle particle = particles[particleIndex];

        int scaledParticleX = (int) (particle.x / IMAGE_SCALE);
        int scaledParticleY = (int) (particle.y / IMAGE_SCALE);

        if (scaledParticleX >= 0 && scaledParticleX < currentAnimalImage.width &&
            scaledParticleY >= 0 && scaledParticleY < currentAnimalImage.height) {
            //float redValue = red(currentAnimalImage.pixels[scaledParticleY * currentAnimalImage.width + scaledParticleX]);
            //particle.radius = map(redValue / 255.0, 0, 1, MINIMUM_RADIUS, MAXIMUM_RADIUS);
            float blueValue = blue(currentAnimalImage.pixels[scaledParticleY * currentAnimalImage.width + scaledParticleX]);
            particle.radius = map(blueValue / 255.0, 0, 1, MINIMUM_RADIUS, MAXIMUM_RADIUS);

            particle.fx = 0; 
            particle.fy = 0; 
            particle.wt = 0;
    
            particle.vx *= DAMPING;
            particle.vy *= DAMPING;
        }
    }

    // Handle interactions between all particles.
    for (int particleIndex1 = 0; particleIndex1 < PARTICLE_COUNT - 1; particleIndex1++) {
        Particle particle1 = particles[particleIndex1];

        for (int particleIndex2 = particleIndex1 + 1; particleIndex2 < PARTICLE_COUNT; particleIndex2++) {
            Particle particle2 = particles[particleIndex2];

            // Freek: Why is the threshold only influenced by particle1 and not by particle2?
            float threshold = particle1.radius * MINIMUM_DISTANCE_FACTOR;
            if (abs(particle1.x - particle2.x) <= threshold && abs(particle1.y - particle2.y) <= threshold) {
                adjustParticlesForInteraction(particle1, particle2);
            }
        }
    }

    // Keep the particles within the edges of the window.
    for (int particleIndex = 0; particleIndex < PARTICLE_COUNT; particleIndex++) {
        Particle particle = particles[particleIndex];

        // Left edge.
        adjustParticleForEdge(particle.x, 0, particle.x, particle);
        
        // Right edge.
        adjustParticleForEdge(particle.x - width, 0, width - particle.x, particle);

        // Top edge.
        adjustParticleForEdge(0, particle.y, particle.y, particle);

        // Bottom edge.
        adjustParticleForEdge(0, particle.y - height, height - particle.y, particle);
        
        // Adjust particle speed.
        if (particle.wt > 0) {
            particle.vx += particle.fx / particle.wt;
            particle.vy += particle.fy / particle.wt;
        }

        // Adjust particle position.
        particle.x += particle.vx;
        particle.y += particle.vy;
    }
}

private void adjustParticlesForInteraction(Particle particle1, Particle particle2) {
    double distanceX = particle1.x - particle2.x;
    double distanceY = particle1.y - particle2.y;
    double distance = Math.sqrt(distanceX * distanceX + distanceY * distanceY);

    double maximumDistance = particle1.radius + particle2.radius;
    double difference = maximumDistance - distance;

    if (difference > 0) {
        double scale = difference / maximumDistance;

        scale = scale * scale;
        particle1.wt += scale;
        particle2.wt += scale;
        
        scale = scale * K_SPEED / distance;
        particle1.fx += distanceX * scale;
        particle1.fy += distanceY * scale;
        particle2.fx -= distanceX * scale;
        particle2.fy -= distanceY * scale;
    }
}

private void adjustParticleForEdge(double distanceX, double distanceY, double distance, Particle particle) {
    double maximumDistance = particle.radius;
    double difference = maximumDistance - distance;
  
    if (difference > 0) {
        double scale = difference / maximumDistance;
        scale = scale * scale;
        
        particle.wt += scale;
        
        scale = scale * K_SPEED / distance;
        particle.fx += distanceX * scale;
        particle.fy += distanceY * scale;
    }
}
