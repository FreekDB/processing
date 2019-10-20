class Particle {
    float x;
    float y;
    float vx;
    float vy;
    float radius;
    
    float fx;
    float fy;
    float wt;

    Particle(float x, float y) {
        this.x = x;
        this.y = y;
        this.vx = 0;
        this.vy = 0;
        this.radius = 1;
    }
}
