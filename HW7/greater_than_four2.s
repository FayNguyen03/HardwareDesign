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
@ greater_response: formatting string for the computer's response when input is greater than 4
greater_response:
	.ascii "That number is greater than 4\012\000"
	.align 2
@ not_greater_response: formatting string for the computer's response when input is not greater than 4
not_greater_response:
	.ascii "That number is not greater than 4\012\000"
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

@ load the value of x into r0
	ldr r0, [fp, #-8]
@ compare x with 4 and go to if branch if x <= 4
	cmp r0, #4
	ble if

@ if the input is stricly greater than 4, print out the response
	ldr r0, greater_response_ptr
	bl printf
	b endif

@ if the input is smaller than or equal to 4, print out the response
if:
	ldr r0, not_greater_response_ptr
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
@ greater_response_ptr: pointer to the formatting string response when the input is larger than 4
greater_response_ptr:
	.word greater_response
@ not_greater_response_ptr: pointer to the formatting string response when the input is not larger than 4
not_greater_response_ptr:
	.word not_greater_response
