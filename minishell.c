#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <unistd.h>
#include <dirent.h>
#include <sys/types.h>
#include <string.h>

void pwd(){
  char *path_string;
  int size = 1024; 

  // Allocate memory for the buffer
  path_string = (char *)malloc(size);
  if (path_string == NULL) {
      perror("Failed to allocate memory for path string");
  }
  // Get the current working directory
  if (getcwd(path_string, size) != NULL) {
    printf("Current working directory: %s\n", path_string);
  } else {
    perror("Failed to get current directory");
  }

  // Free the allocated memory
  free(path_string);
}

void cd(const char* directory_path){
  int status = chdir(directory_path);
  if (status == 0) {
    printf("Successfully direct to '%s'.\n", directory_path);  
  } else {
    printf("Failted to direct to '%s'.\n", directory_path);
  }
}

void ls(){
  DIR *dp;             // Pointer to a directory stream
  struct dirent *ep;   // Pointer to a directory entry

  // Open the current directory. "." represents the current directory.
  dp = opendir("./");

  if (dp != NULL) {
    // Read directory entries one by one until readdir returns NULL
    while ((ep = readdir(dp)) != NULL) {
        // Print the name of the current entry
        puts(ep->d_name);
    }
    // Close the directory stream
    closedir(dp);
  } else {
    // Handle error if the directory cannot be opened
    perror("Couldn't open the directory");
  }
}

int concatenate(const char* filename) {
    FILE *file_ptr;
    int character;

    // Open the file in read mode ("r")
    file_ptr = fopen(filename, "r");

    // Check if the file was opened successfully
    if (file_ptr == NULL) {
        // Print error message to stderr
        fprintf(stderr, "Error: Could not open file %s.\n", filename);
        return 1; // Return error status
    }

    // Read characters one by one until the end of the file (EOF) is reached
    while ((character = fgetc(file_ptr)) != EOF) {
        // Print each character directly to stdout using putchar or printf
        putchar(character);
    }

    // Close the file
    fclose(file_ptr);

    return 0; // Return success status
}

int os_define() {
    #if defined(_WIN32) || defined(_WIN64)
        return 0;
    #elif defined(__linux__)
        return 1;
    #elif defined(__APPLE__)
        return 2;
    #elif defined(__unix__)
        return 3;
    #else
        return 4;
    #endif

    return 4;
}

int echo(const char* input) {
    if(os_define() == 1 || os_define() == 2){
      system("clear");
    }
    else if(os_define() == 0){
      system("cls");
    }
    else{
      printf("Have no idea OS\n");
    }
    printf("%s", input);
    printf("\n");
    return 0;
}

int main(){
	int command_num = 0;
	bool continue_shell = true;
  char input_buffer[100];
	while(continue_shell){
		printf("You can call a command by selecting the corresponding number\n1.pwd\n2.cd\n3.exit\n4.ls\n5.cat\n6.echo\n");
    printf("Enter an integer: ");
    fgets(input_buffer, sizeof(input_buffer), stdin);
    input_buffer[strcspn(input_buffer, "\n\r")] = '\0';
    command_num = strtol(input_buffer, NULL, 10); 
    if (command_num == 0){
      perror("Arguments must be nonzero integers.");
      return 1;
    }
		switch (command_num) {
      case 1:
        printf("You called pwd.\n");
        pwd();
        break;
      case 2:
        printf("You called cd. Please provide me the directory your want to direct to.");
        fgets(input_buffer, sizeof(input_buffer), stdin);
        input_buffer[strcspn(input_buffer, "\n\r")] = '\0';
        cd(input_buffer);
        pwd();
        break;
      case 3:
        printf("You called exit. Exit the shell\n");
        continue_shell = false;
        break;
      case 4:
        printf("You called ls.\n");
        ls();
        break;
      case 5:
        printf("You called cat.\n");
        printf("You called cat. Please provide me the file your want to print out to the stdout.");
        fgets(input_buffer, sizeof(input_buffer), stdin);
        input_buffer[strcspn(input_buffer, "\n\r")] = '\0';
        concatenate(input_buffer);
        break;
      case 6:
        printf("You called echo.\n");
        printf("You called echo. Please provide me the input your want to print out to the stdout.");
        fgets(input_buffer, sizeof(input_buffer), stdin);
        echo(input_buffer);
        break;
      default:
        printf("You chose an incorrect option\n");
        break;
    }	
    printf("\n");	
	}
	return 0;
}
