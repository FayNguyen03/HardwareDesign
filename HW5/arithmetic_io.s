@ Global constants
	.section .rodata
@ prompt: asks the user to enter the value of a and b
prompt:
	.ascii "Enter a number:\000"
	.align 2
@ input: formatting string for getting user input
input:
	.ascii "%d\000"
	.align 2
@ addition_response: formatting string for the computer's response for the addition of the two inputs
addition_response:
	.ascii "%d + %d = %d\012\000"
	.align 2
@ subtraction_response: formatting string for the computer's response for the subtraction of the two inputs
subtraction_response:
	.ascii "%d - %d = %d\012\000"
	.align 2
@ multiplication_response: formatting string for the computer's response for the multiplication Of the two inputs
multiplication_response:
	.ascii "%d * %d = %d\012\000"
	.align 2
@ main function
	.text
	.global main
main:	
@ save registers fp and lr
	push {fp, lr}
	add fp, sp, #4
@ set up the stack frame, 2 local variable
	sub sp, sp, #8
@ [fp, #-8] is integer a
@ [fp. #-12] is	integer b

@ print the question asking the user to enter the number a
	ldr r0, prompt_ptr
	bl printf

@ load the address of a in register r1
	sub r1, fp, #8
@ load the address of the input formatting string in register r0
	ldr r0, input_ptr
@ call scanf
	bl scanf

@ print the question asking the user to enter the number b
	ldr r0, prompt_ptr
	bl printf

@ load the address of b in register r1
	sub r1, fp, #12
@ load the address of the input formatting string in register r0
	ldr r0, input_ptr
@ call scanf
	bl scanf

@ compute the sum of a and b and set up the printf
@ load address of a into register r1
	sub r1, fp, #8
@ load value of a into register r1
	ldr r1, [r1]
@ load address of b into register r2
	sub r2, fp, #12
@ load value of b into register r2
	ldr r2, [r2]
@ load sum of the variable a and b into r3
	add r3, r1, r2
@ load the addition report response to registerr r0
	ldr r0, addition_response_ptr
@ call printf
	bl printf

@ compute the subtraction of a and b and set up the printf
@ load address of a into register r1
	sub r1, fp, #8
@ load value of a into register r1
	ldr r1, [r1]
@ load address of b into register r2
	sub r2, fp, #12
@ load value of b into register r2
	ldr r2, [r2]	
@ load subtraction of the variable a and b into r3 
	sub r3, r1, r2
@ load the subtraction response to register r0
	ldr r0, subtraction_response_ptr
@ call printf
	bl printf
	
@ compute the multiplication of a and b and set up the printf
@ load address of a into register r1
	sub r1, fp, #8
@ load value of a into register r1
	ldr r1, [r1]
@ load address of b into register r2
	sub r2, fp, #12
@ load value of b into register r2
	ldr r2, [r2]
@ load multiplication of the variable a and b into r3 
	mul r3, r1, r2
@ load the multiplication response to register r0
	ldr r0, multiplication_response_ptr
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
@ prompt_ptr: pointer to the question that asks user to input the value
prompt_ptr:
	.word prompt
@ input_ptr: pointer to the formatting string for user input
input_ptr:
	.word input
@ addition_response_ptr: pointer to the formatting string response of the sum of a and b
addition_response_ptr:
	.word addition_response
@ subtraction_response_ptr: pointer to the formatting string response of the difference of a and b
subtraction_response_ptr:
	.word subtraction_response
@ multiplication_response_ptr: pointer to the formatting string response of the product of a and b
multiplication_response_ptr:
	.word multiplication_response

