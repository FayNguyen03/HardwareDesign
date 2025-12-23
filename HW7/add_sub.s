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
@ subtraction_a_b_response: formatting string for the computer's response for the subtraction of a - b
subtraction_a_b_response:
	.ascii "%d - %d = %d\012\000"
	.align 2
@ subtraction_b_a_response: formatting string for the computer's response for the subtraction of b - a
subtraction_b_a_response:
	.ascii "%d - %d = %d\012\000"
	.align 2

@ sum function
	.text
	.global sum
sum:	
@ save registers fp and lr
	push {fp, lr}
	add fp, sp, #4
@ set up the stack frame, 2 local variable
	sub sp, sp, #8
@ [fp, #-8] is parameter x
@ [fp. #-12] is	parameter y

@ load the value of parameter x
	str r0, [fp, #-8]
@ load the value of parameter y
	str r1, [fp, #-12]

@ load the value of parameter x into r0
    ldr r0, [fp, #-8]
@ load the value of parameter y into r1
    ldr r1, [fp, #-12]
@ find the sum of x and y and store it into r0
    add r0, r0, r1

@ move sp back to original position
	sub sp, fp, #4
@ restore fp and pc
	pop {fp, pc}

@ difference function
	.text
	.global difference
difference:	
@ save registers fp and lr
	push {fp, lr}
	add fp, sp, #4
@ set up the stack frame, 2 local variable
	sub sp, sp, #8
@ [fp, #-8] is parameter x
@ [fp. #-12] is	parameter y

@ load the value of parameter x
	str r0, [fp, #-8]
@ load the value of parameter y
	str r1, [fp, #-12]

@ load the value of parameter x into r0
    ldr r0, [fp, #-8]
@ load the value of parameter y into r1
    ldr r1, [fp, #-12]
@ find the sum of x and y and store it into r0
    sub r0, r0, r1

@ move sp back to original position
	sub sp, fp, #4
@ restore fp and pc
	pop {fp, pc}

@ main function
	.text
	.global main
main:	
@ save registers fp and lr
	push {fp, lr}
	add fp, sp, #4
@ set up the stack frame, 5 local variable
	sub sp, sp, #20
@ [fp, #-8] is integer a
@ [fp. #-12] is	integer b
@ [fp. #-16] is	integer c
@ [fp. #-20] is	integer d
@ [fp. #-24] is	integer e

@ print the question asking the user to enter the number a
	ldr r0, prompt_ptr
	bl printf

@ load the address of a into r1
	sub r1, fp, #8
@ load the address of the input formatting string into r0
	ldr r0, input_ptr
@ call scanf
	bl scanf

@ print the question asking the user to enter the number b
	ldr r0, prompt_ptr
	bl printf

@ load the address of b into r1
	sub r1, fp, #12
@ load the address of the input formatting string into r0
	ldr r0, input_ptr
@ call scanf
	bl scanf

@ load the value of a into r0
    ldr r0, [fp, #-8]
@ load the value of b into r1
    ldr r1, [fp, #-12]
@ call function sum with a and b
    bl sum
@ store the result of the function call to c
    sub r1, fp, #16
    str r0, [r1]

@ load the response string
    ldr r0, addition_response_ptr
@ load the value of a into r1
    ldr r1, [fp, #-8]
@ load the value of b into r2
    ldr r2, [fp, #-12]
@ load the value of c into r3
    ldr r3, [fp, #-16]
@ print out the sum
    bl printf

@ load the value of a into r0
    ldr r0, [fp, #-8]
@ load the value of b into r1
    ldr r1, [fp, #-12]
@ call function difference with a and b
    bl difference
@ store the result of the function call to d
    sub r1, fp, #20
    str r0, [r1]   

@ load the response string
    ldr r0, subtraction_a_b_response_ptr
@ load the value of b into r1
    ldr r1, [fp, #-8]
@ load the value of a into r2
    ldr r2, [fp, #-12]
@ load the value of d into r3
    ldr r3, [fp, #-20]
@ print out the sum
    bl printf

@ load the value of b into r0
    ldr r0, [fp, #-12]
@ load the value of a into r1
    ldr r1, [fp, #-8]
@ call function difference with b and a
    bl difference
@ store the result of the function call to e
    sub r1, fp, #24
    str r0, [r1]

@ load the response string
    ldr r0, subtraction_b_a_response_ptr
@ load the value of b into r1
    ldr r1, [fp, #-12]
@ load the value of a into r2
    ldr r2, [fp, #-8]
@ load the value of e into r3
    ldr r3, [fp, #-24]
@ print out the sum
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
@ subtraction_a_b_response_ptr: pointer to the formatting string response of the difference of a and b
subtraction_a_b_response_ptr:
	.word subtraction_a_b_response
@ subtraction_b_a_response_ptr: pointer to the formatting string response of the product of b and a
subtraction_b_a_response_ptr:
	.word subtraction_b_a_response


