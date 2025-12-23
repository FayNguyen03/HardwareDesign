@ Global constants
    .section .rodata
@ welcome_string: greeting the client
welcome_string:
    .ascii "Welcome to the HD Pizza Shop, where every pizza is assembled to perfection!\012\000"
    .align 2
@ num_pizzas_prompt_string: prompt to ask how many pizzas the client wants to order
num_pizzas_prompt_string:
    .ascii "How many pizzas would you like to order?\000"
    .align 2
@ num_pizzas_string: prompt to confirm how many pizzas the client wants to order
num_pizzas_string:
    .ascii "You have ordered %d pizzas.\012\000"
    .align 2
@ thank_you_string: prompt to thank you the client
thank_you_string:
    .ascii "Thank you! Please stop by for a byte again sometime!\012\000"
    .align 2
@ input: input string to get the value
input:
    .ascii "%d\000"
    .align 2

@ main function
    .text
    .global main
main:
@ save registers fp and lr
    push {fp, lr}
    add fp, sp, #4
@ set up the stack frame with 1 local variable
    sub sp, sp, #4
@ [fp, #-8] is parameter num_pizzas

@ print out the welcome
@ load welcome_string_ptr into the register r0
    ldr r0, welcome_string_ptr
@ print out the welcome_string
    bl printf

@ print out the question for client to ask for the number of pizzas and get the input
@ load num_pizzas_prompt_string_ptr into the register r0
    ldr r0, num_pizzas_prompt_string_ptr
@ print out the num_pizzas_prompt_string
    bl printf

@ load input_ptr into the register r0
    ldr r0, input_ptr
@ store the address input_ptr into the register r0
    sub r1, fp, #8
@ scan the value
    bl scanf

@ print out the number of pizzas the client orders
@ load num_pizzas_string_ptr into the register r0
    ldr r0, num_pizzas_string_ptr
@ load the value of number_pizzas into r1
    ldr r1, [fp, #-8]
@ print out the num_pizzas_string
    bl printf

@ print out appreciation note to the client
@ load thank_you_string_ptr into the register r0
    ldr r0, thank_you_string_ptr
@ print out the thank_you_string
    bl printf
	mov r0, #0
@ move sp back to original position
    sub sp, fp, #4
@ restore fp and pc
    pop {fp, pc}

@ pointers
@ welcome_string_ptr: pointer for welcome_string
welcome_string_ptr:
    .word welcome_string
@ num_pizzas_string_ptr: pointer for num_pizzas_string
num_pizzas_prompt_string_ptr:
    .word num_pizzas_prompt_string
@ num_pizzas_string_ptr: pointer for num_pizzas_string
num_pizzas_string_ptr:
    .word num_pizzas_string
@ thank_you_string_ptr: pointer for thank_you_string
thank_you_string_ptr:
    .word thank_you_string
@ input_ptr: pointer for input
input_ptr:
    .word input
