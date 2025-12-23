@ Global constants
	.section .rodata
@ prompt: asks the user to enter a number
prompt:
	.ascii "Enter a number:\000"
	.align 2
@ input: formatting string for getting user input
input:
	.ascii "%d\000"
	.align 2
response:
	.ascii "The sum from 1 through %d is %d\012\000"
	.align 2

@ main function
	.text
	.global main
main:
@ save registers fp and lr
	push {fp, lr}
	add fp, sp, #4
@ set up the stack frame, 2 local variables
	sub sp, sp, #12
	@[fp, #-8]: local variable x
	@[fp, #-12]: current_number
    @[fp, #-16]: current_sum

	@ print the question asking the user to enter the number x
	ldr r0, prompt_ptr
	bl printf

    @ load the address of x into register r1
    sub r1, fp, #8
    @ load the address of the input formatting string into register r0
    ldr r0, input_ptr
    @ call scanf
    bl scanf
	
    @ load the value 1 into current_number
	sub r0, fp, #12
	mov r0, #1

    @ load the value 0 into current_sum
	sub r0, fp, #16
	mov r0, #0

    @ check the condition
	b loop_condition  

loop_body:
    @ add the current number into current_sum
    @ load the address of current_sum into r0
	sub r0, fp, #16
    @ load the value of current_number into r1
	ldr r1, [fp, #-12]
    @ load the value of current_sum into r2
	ldr r2, [r0]
    @ add the current number into current_sum
	add r2, r2, r1
	@ store the new sum into the variable current_sum
    str r2, [r0]
	
    @ add 1 to the current_number
    @ load the address of current_number into r0
	sub r0, fp, #12
    @ load the value of current_number into r1
	ldr r1, [r0]
	add r1, r1, #1
    @ store the new current_number into r0
	str r1, [r0]

    @ move to the branch loop_condition
	b loop_condition
	
loop_condition:
    @ load the value of current_number into r0
	ldr r0, [fp, #-12]
    @ load the value of x into r1
	ldr r1, [fp, #-8]
    @ compare the current_number with the input value x
	cmp r0, r1
    @ if the current_number is not equal to the input value, move to the loop_body
	ble loop_body

    @ if the current_number is equal to the input value, print out the sum from 1 to x
    @ load the response pointer into the r0
	ldr r0, response_ptr
    @ load the value of x into the r1
	ldr r1, [fp, #-8]
    @ load the value of current_sum into the r2
    ldr r2, [fp, #-16]
	bl printf

@ return 0
	mov r0, #0
@ move sp back to original position
	sub sp, fp, #4
@ restore fp and pc
	pop {fp, pc}
	.align 2

	@pointers
@ prompt_ptr: pointer to the question that asks user to input the value
prompt_ptr:
	.word prompt
@ input_ptr: pointer to the formatting string for user input
input_ptr:
	.word input
@ response_ptr: pointer to the formatting string response 
response_ptr:
	.word response
