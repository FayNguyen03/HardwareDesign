@ Global constants
	.section .rodata
@ dogs_prompt: asks how many dogs the user has
dogs_prompt:
	.ascii "How many dogs do you have?\000"
	.align 2
@ input: formatting string for getting user input
input:
	.ascii "%d\000"
	.align 2
@ response: formatting string for the computer's response
response:
	.ascii "I have %d dog(s).\012\000"
	.align 2
@ main function
	.text
	.global main
main:	
@ save registers fp and lr
	push {fp, lr}
	add fp, sp, #4
@ set up the stack frame, 1 local variable
	sub sp, sp, #4
@ [fp, #-8] is an integer, num_dogs, storing the number of dogs

@ print the question asking the user how many dogs they have
	ldr r0, dogs_prompt_ptr
	bl printf

@ load the address of num_dogs in register r1
	sub r1, fp, #8
@ load the address of the input formatting string in register r0
	ldr r0, input_ptr
@ call scanf
	bl scanf


@ load the value of the variable num_dogs into r0
	ldr r0, [fp, #-8]
@ increment the value in r0 by 1
	add r0, r0, #1
@ store the value in r0 to the variable num_dogs
	str r0, [fp, #-8]
	
@ setting up call to printf:
@ load the value of num_dogs into register r1
	ldr r1, [fp, #-8]
@ load the address of the string response in register r0
	ldr r0, response_ptr
@ call printf
	bl printf
	
@ return 0
	mov r0, #0
@ move sp back to original position
	sub sp, fp, #4
@ restore fp and pc
	pop {fp, pc}
	.align 2
@ Pointers
@ dogs_prompt_ptr: pointer to the question that asks how many dogs the user has
dogs_prompt_ptr:
	.word dogs_prompt
@ input_ptr: pointer to the formatting string for user input
input_ptr:
	.word input
@ response_ptr: pointer to the formatting string response
response_ptr:
	.word response
