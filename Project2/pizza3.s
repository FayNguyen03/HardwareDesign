@ Global constants
    .section .rodata
@ welcome_string: greeting the client
welcome_string:
    .ascii "Welcome to the HD Pizza Shop, where every pizza is assembled to perfection!\012\000"
    .align 2
@ num_pizzas_small_prompt_string: prompt to ask how many small pizzas the client wants to order
num_pizzas_small_prompt_string:
    .ascii "How many small pizzas would you like to order?\000"
    .align 2
@ num_pizzas_medium_prompt_string: prompt to ask how many medium pizzas the client wants to order
num_pizzas_medium_prompt_string:
    .ascii "How many medium pizzas would you like to order?\000"
    .align 2
@ num_pizzas_large_prompt_string: prompt to ask how many large pizzas the client wants to order
num_pizzas_large_prompt_string:
    .ascii "How many large pizzas would you like to order?\000"
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
@ set up the stack frame with 5 local variables
    sub sp, sp, #20
@ [fp, #-8] is parameter num_small
@ [fp, #-12] is parameter num_medium
@ [fp, #-16] is parameter num_large
@ [fp, #-20] is parameter total_cost
@ [fp, #-24] is parameter num_pizzas

@ print out the welcome
@ load welcome_string_ptr into the register r0
    ldr r0, welcome_string_ptr
@ print out the welcome_string
    bl printf

@ print out the question for client to ask for the number of small pizzas and get the input
@ load num_pizzas_small_prompt_string_ptr into the register r0
    ldr r0, num_pizzas_small_prompt_string_ptr
@ print out the num_pizzas_small_prompt_string
    bl printf

@ load input_ptr into the register r0
    ldr r0, input_ptr
@ store the address num_small into the register r0
    sub r1, fp, #8
@ scan the value
    bl scanf

@ print out the question for client to ask for the number of medium pizzas and get the input
@ load num_pizzas_medium_prompt_string_ptr into the register r0
    ldr r0, num_pizzas_medium_prompt_string_ptr
@ print out the num_pizzas_medium_prompt_string
    bl printf

@ load input_ptr into the register r0
    ldr r0, input_ptr
@ store the address num_medium into the register r0
    sub r1, fp, #12
@ scan the value
    bl scanf

@ print out the question for client to ask for the number of large pizzas and get the input
@ load num_pizzas_large_prompt_string_ptr into the register r0
    ldr r0, num_pizzas_large_prompt_string_ptr
@ print out the num_pizzas_large_prompt_string
    bl printf

@ load input_ptr into the register r0
    ldr r0, input_ptr
@ store the address num_large into the register r0
    sub r1, fp, #16
@ scan the value
    bl scanf

@ calculate the total number of pizzas and store it into total_cost
@ store the address of num_pizzas into the register r0
    sub r0, fp, #24
@ load the value of num_small into the register r1
    ldr r1, [fp, #-8]
@ load the value of num_small into num_pizzas
    str r1, [r0]

@ store the address of num_pizzas into the register r0
    sub r0, fp, #24
@ load the value of num_medium into the register r1
    ldr r1, [fp, #-12]
@ load the value of num_pizzas into the register r2
    ldr r2, [fp, #-24]
@ add the number of medium pizzas into number of pizzas
    add r1, r1, r2
@ store this value into num_pizzas
    str r1, [r0]

@ store the address of num_pizzas into the register r0
    sub r0, fp, #24
@ load the value of num_large into the register r1
    ldr r1, [fp, #-16]
@ load the value of num_pizzas into the register r2
    ldr r2, [fp, #-24]
@ add the number of large pizzas into number of pizzas
    add r1, r1, r2
@ store this value into num_pizzas
    str r1, [r0]

@ print out the number of pizzas the client orders
@ load num_pizzas_string_ptr into the register r0
    ldr r0, num_pizzas_string_ptr
@ load the value of number_pizzas into r1
    ldr r1, [fp, #-24]
@ print out the num_pizzas_string
    bl printf

@ calculate the total cost of the order
@ load the value of number_pizzas into the register r0
    ldr r0, [fp, #-24]
@ load the value of pizza_price into the register r1
    ldr r1, =pizza_price
    ldr r1, [r1]
@ load the address of total_cost into r2
    sub r2, fp, #20
@ store the total cost into r0 by multiplication
    mul r0, r0, r1
@ store the value into total_cost
    str r0, [r2]

@ print out the total cost the client orders
@ load total_cost_string_ptr into the register r0
    ldr r0, total_cost_string_ptr
@ load the value of total_cost into r1
    ldr r1, [fp, #-20]
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
@ num_pizzas_small_prompt_string_ptr: pointer for num_pizzas_small_prompt_string
num_pizzas_small_prompt_string_ptr:
    .word num_pizzas_small_prompt_string
@ num_pizzas_medium_prompt_string_ptr: pointer for num_pizzas_medium_prompt_string
num_pizzas_medium_prompt_string_ptr:
    .word num_pizzas_medium_prompt_string
@ num_pizzas_large_prompt_string_ptr: pointer for num_pizzas_large_prompt_string
num_pizzas_large_prompt_string_ptr:
    .word num_pizzas_large_prompt_string
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
