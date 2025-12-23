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
@ num_pizzas_string: text to confirm how many pizzas the client wants to order
num_pizzas_string:
    .ascii "You have ordered %d pizzas.\012\000"
    .align 2
@ total_cost_string: text to confirm the total cost
total_cost_string:
    .ascii "Your total is $%d.\012\000"
    .align 2
@ thank_you_string: prompt to thank you the client
thank_you_string:
    .ascii "Thank you! Please stop by for a byte again sometime!\012\000"
    .align 2
@ input: input string to get the value
input:
    .ascii "%d\000"
    .align 2
@ pizza_price: price of pizza
pizza_price:
    .word 15

@ main function
    .text
    .global main
main:
@ save registers fp and lr
    push {fp, lr}
    add fp, sp, #4
@ set up the stack frame with 2 local variables
    sub sp, sp, #8
@ [fp, #-8] is parameter num_pizzas
@ [fp, #-12] is parameter total_cost

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

@ calculate the total cost of the order
@ load the value of number_pizzas into the register r0
    ldr r0, [fp, #-8]
@ load the value of pizza_price into the register r1
    ldr r1, =pizza_price
    ldr r1, [r1]	
@ load the address of total_cost into r2
    sub r2, fp, #12
@ store the total cost into r0 by multiplication
    mul r0, r0, r1
@ store the value into total_cost
    str r0, [r2]

@ print out the total cost the client orders
@ load total_cost_string_ptr into the register r0
    ldr r0, total_cost_string_ptr
@ load the value of total_cost into r1
    ldr r1, [fp, #-12]
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
@ total_cost_string_ptr: pointer for total_cost_string
total_cost_string_ptr:
    .word total_cost_string
@ input_ptr: pointer for input
input_ptr:
    .word input
