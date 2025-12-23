#include <stdio.h>
#include <stdlib.h>
#include <math.h>

// Define the region of the complex plane to render
double x_min = -2.0;
double x_max = 1.0;
double y_min = -1.5;
double y_max = 1.5;

// Define a complex point to be in the Mandelbrot set if it does not escape after this many iterations
int max_iterations = 100;

// width and height of images
int width;
int height;

// Define complex number
typedef struct {
    double a;
    double b;
} Complex;

// Function to calculate Mandelbrot escape time
int mandelbrot_iterations(Complex c, int max_iter) {
    Complex z = {0.0, 0.0};
    int iterations = 0;
    while (z.a * z.a + z.b * z.b < 4.0 && iterations < max_iter) {
        double new_real = z.a * z.a - z.b * z.b + c.a;
        z.b = 2 * z.a * z.b + c.b;
        z.a = new_real;
        iterations++;
    }
    return iterations;
}

int main(int argc, char *argv[]) {
    // TO DO: Modify main to take two positive integer arguments, for width and height.
    if (argc != 3){
      perror("Requires two arguments: width and height. No image generated.");
      return 1;
    }
    char *end = NULL;
    width = strtol(argv[1], &end, 10);
    height = strtol(argv[2], &end, 10);
    if (width == 0 || height == 0){
      perror("Arguments must be nonzero integers. No image generated.");
      return 1;
    }
    int max_color_value = 255;

    // TO DO: Open the file mandelbrot.ppm
    FILE * fp;
    fp = fopen("mandelbrot.ppm", "w");
    if (!fp){
      perror("Error opening file:");
      return 1;
    }
    
    // TO DO: Write file header
    fprintf(fp, "P3\n");
    fprintf(fp, "%d %d\n", width, height); // Image dimensions
    fprintf(fp, "%d\n", max_color_value); // Maximum color value

    // TO DO: Use nested for loops to compute pixel colors and write to the file mandelbrot.ppm
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // Create the RGB values for each pixel
	  Complex c;
	  c.a = x_min + (double)x / width * (x_max - x_min);
	  c.b = y_min + (double)y / height * (y_max - y_min);
	  int iterations = mandelbrot_iterations(c, max_iterations);
	  int r = 0, g = 0, b = 0;
	  if (iterations != max_iterations){
	    r = (iterations * 5) % 255;
      g = (iterations * 3) % 255;
      b = (iterations * 7) % 255;
	  }
          fprintf(fp, "%d %d %d ", r, g, b);
        }
        fprintf(fp, "\n");
    }

    // TO DO: close the file and end program
     fclose(fp);
     printf("PPM image 'mandelbrot.ppm' created successfully.\n");
     return 0;
}
