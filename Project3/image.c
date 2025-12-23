#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
// argc: number of cmd arguments passed
// argv: array of cmd arguments
//
// check whether there are 3 (name of the program being executed, first and second arguments)
    if (argc != 3){
	perror("Requires two arguments: width and height. No image generated.");
        return 1;
    }
    char *end = NULL;
    int width = strtol(argv[1], &end, 10);
    int height = strtol(argv[2], &end, 10);
    if (width == 0 || height == 0){
      perror("Arguments must be nonzero integers. No image generated.");
      return 1;
    }
    int max_color_value = 255;

    FILE *fp;
    fp = fopen("image.ppm", "w");

    fprintf(fp, "P3\n"); // PPM Magic number
    fprintf(fp, "%d %d\n", width, height); // Image dimensions
    fprintf(fp, "%d\n", max_color_value); // Maximum color value

    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
            // Create a black to gold gradient
            int r = 255*x*1.0/(width-1);
            int g = 215*x*1.0/(width-1);
            int b = 0;

            fprintf(fp, "%d %d %d ", r, g, b);
        }
        fprintf(fp, "\n");
    }

    fclose(fp);
    printf("PPM image 'image.ppm' created successfully.\n");

    return 0;
}
