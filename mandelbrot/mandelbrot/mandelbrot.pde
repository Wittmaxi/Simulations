int HEIGHT = 1000;
int WIDTH = 1000;
float X_AREA = 2; // coords span from -X_AREA to +X_AREA
float Y_AREA = 2;

int TOTAL_ITERATIONS = 1000;

//

public void settings () {
    size (WIDTH, HEIGHT);
}

void setup () {
    // noLoop(); // once drawn, no more need to change the mandelbrot
}

int amountIterationsBeforeDivergence (float re, float im) {
    float prevRe = re;
    float prevIm = im;
    for (int i = 0; i < TOTAL_ITERATIONS; i++) {
        float newRe = pow (prevRe, 2) - pow (prevIm, 2) + re;
        float newIm = 2 * prevRe * prevIm + im;
        
        if (newRe > 50)
            return i;

        prevRe = newRe;
        prevIm = newIm;
    }
    return 0;
}

int i = 0; // progressively draw y axis
void draw () {
    for (int j = 0; j < HEIGHT; j++) {
        float re = map (i, 0, WIDTH, -1 * X_AREA, X_AREA);
        float img = map (j, 0, HEIGHT, -1 * Y_AREA, Y_AREA);
        int iterations = amountIterationsBeforeDivergence (re, img);
        if (iterations > 0)  {
            point (i, j);
            stroke (map (iterations, 0, TOTAL_ITERATIONS, 30, 255), 0, 0);
        }
    }
    i++;
}
