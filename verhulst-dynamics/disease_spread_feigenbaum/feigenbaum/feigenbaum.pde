
int ITERATIONS_AMOUNT = 500;
float P_NULL = 0.2;
float MIN_K = 0;
float MAX_K = 3.4;
float MIN_P = -0.5;
float MAX_P = 1.4;

int WIDTH = 1500;
int HEIGHT = 800;

public void settings() { // appearently, you can't use size() outside of the PDE... what the duck?
    size (WIDTH, HEIGHT);
}

void setup () {
    noLoop ();
}

void iterate (float k) {
    float p = P_NULL;
    float x_cord = map (k, MIN_K, MAX_K, 0, WIDTH);
    for (int i = 0; i < ITERATIONS_AMOUNT; i++) {
        stroke(0, 0, 0,map (i, 0, ITERATIONS_AMOUNT, 25, 255));
        p += p * k * (1 - p);
        float y_cord = map (p, MIN_P, MAX_P, HEIGHT, 0);
        point (x_cord, y_cord);
    }
} 

void draw () {
    strokeWeight (1);
    for (int i = 0; i < WIDTH; i++)
        iterate (map (i, 0, WIDTH, MIN_K, MAX_K));
}
