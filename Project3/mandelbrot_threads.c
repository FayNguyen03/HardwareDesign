#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>

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

// Structure to pass data to each thread - tells the thread which rows to process
typedef struct {
    int start_row;
    int end_row;
} ThreadData;

// Number of threads
int num_threads;

//Pointer to the shared image array
int *image_data;

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

// Function to define the work done by each thread
void *thread_worker(void *arg){
  // arg is used to pass data to the thread
  ThreadData *data = (ThreadData *) arg;
  for (int y = data -> start_row; y <= data -> end_row; y++) {
        for (int x = 0; x < width; x++) {
          // Map pixel coordiates to complex plane
	  double real = x_min + (double)x / width * (x_max - x_min);
	  double imag = y_min + (double)y / height * (y_max - y_min);
	  Complex c;
	  c.a = real;
	  c.b = imag;
	  image_data[y * width + x] = mandelbrot_iterations(c, max_iterations);	
        }
    }
  return NULL;
}

int main(int argc, char *argv[]) {
    // TO DO: Modify main to take three positive integer arguments, for width, height, num_threads.
    if (argc != 4){
      perror("Requires two arguments: width, height, and num_threads. No image generated.");
      return 1;
    }
    char *end = NULL;
    width = strtol(argv[1], &end, 10);
    height = strtol(argv[2], &end, 10);
    num_threads = strtol(argv[3], &end, 10);
    if (width == 0 || height == 0 || num_threads == 0){
      perror("Arguments must be nonzero integers. No image generated.");
      return 1;
    }
    int max_color_value = 255;

    // Allocate array to store the computed iteration counts for each pixel before opening the file
    image_data = (int *)malloc(width * height * sizeof(int));
    if (image_data == NULL) {
      perror("Failed to allocate image data");
      return 1;
    }

    // threads array to store the thread ID
    pthread_t threads[num_threads];
    ThreadData thread_data[num_threads];

    int rows_per_thread = height / num_threads;

    // Create and start our threads
    for (int i = 0; i < num_threads; i++){
      thread_data[i].start_row = i * rows_per_thread;
      if (i < num_threads - 1) {
	thread_data[i].end_row = (i + 1) * rows_per_thread;
      }
      else{
	thread_data[i].end_row = height - 1;
      }
      pthread_create(&threads[i], NULL, thread_worker, &thread_data[i]);
    }

    for (int i = 0; i < num_threads; i++) {
        pthread_join(threads[i], NULL);
    }

    // To DO: Open the file mandelbrot.ppm
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
    
    for (int y = 0; y < height; y++) {
        for (int x = 0; x < width; x++) {
          // Create the RGB values for each pixel
	  int r = 0, g = 0, b = 0;
	  int current_iteration = image_data[y * width + x];
	  if (current_iteration != max_iterations){
	    r = (current_iteration * 5) % 255;
      g = (current_iteration * 3) % 255;
      b = (current_iteration * 7) % 255;
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
