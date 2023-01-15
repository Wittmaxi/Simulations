int HEIGHT = 300;
int WIDTH = 300;
float X_AREA = 2; // coords span from -X_AREA to +X_AREA
float Y_AREA = 2;

float C_IM = 1;
float C_RE = 1;

int TOTAL_ITERATIONS = 100;

//

public void settings () {
    size (WIDTH, HEIGHT, P2D);
}

void setup () {
}

int amountIterationsBeforeDivergence (float re, float im) {
    float prevRe = re;
    float prevIm = im;
    for (int i = 0; i < TOTAL_ITERATIONS; i++) {
        float newRe = prevRe * prevRe - prevIm * prevIm + C_RE;
        float newIm = 2 * prevRe * prevIm + C_IM;
        
        if (newRe > 100)
            return i;

        prevRe = newRe;
        prevIm = newIm;
    }
    return 0;
}

void draw () {
    background (255, 255, 255);
    for (int i = 0; i < WIDTH; i++) {
        for (int j = 0; j < HEIGHT; j++) {
            float re = map (i, 0, WIDTH, -1 * X_AREA, X_AREA);
            float img = map (j, 0, HEIGHT, -1 * Y_AREA, Y_AREA);
            int iterations = amountIterationsBeforeDivergence (re, img);
            if (iterations > 0)  {
                point (i, j);
                stroke (map (iterations, 0, TOTAL_ITERATIONS, 30, 255), 0, 0);

            }
        }
    }
    C_RE += 0.01;
    C_IM += 0.01;
}

