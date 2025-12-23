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
@response: formatting string for the computer's response for number that is larger than 4
response:
	.ascii "That number is greater than 4\012\000"
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
@ [fp, #-8] is integer x

@ print the question asking the user to enter the number x
	ldr r0, prompt_ptr
	bl printf

@ load the address of x into register r1
	sub r1, fp, #8
@ load the address of the input formatting string into register r0
	ldr r0, input_ptr
@ call scanf
	bl scanf

@ compare the input number with 4
@ load the value of x into r0
	ldr r0, [fp, #-8]
@ compare x with 4
	cmp r0, #4
	ble endif

@ if the input is stricly greater than 4, print out the response
	ldr r0, response_ptr
	bl printf

@ if the input is stricly greater than 4,do not print out anything
endif:
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
@ addition_response_ptr: pointer to the formatting string response 
response_ptr:
	.word response

