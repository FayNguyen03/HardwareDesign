@ Global constants
    .section .rodata
@ welcome_string: greeting the client
welcome_string:
    .ascii "Welcome to the HD Pizza Shop, where every pizza is assembled to perfection!\012\000"
    .align 2
@ pizza_size_prompt_string: prompt to ask which size of pizza the client wants to order
pizza_size_prompt_string:
    .ascii "What size of pizza would you like to order? (s/m/l)\000"
    .align 2
@ user_input: client input to choose the size of pizza they want to order
user_input:
    .ascii "%c\000"
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
@ small_price: price of a small pizza
small_price:
    .word 10
@ medium_price: price of a medium pizza
medium_price:
    .word 15
@ large_price: price of a large pizza
large_price:
    .word 20

@ cost function 
    .text
    .global cost
cost:
    @ save registers fp and lr
    push {fp, lr}
    add fp, sp, #4
@ set up the stack frame with 3 local variables
    sub sp, sp, #12
@ [fp, #-8] is parameter x
@ [fp, #-12] is parameter y
@ [fp, #-16] is parameter z

@ load value of parameters
    str r0, [fp, #-8]
    str r1, [fp, #-12]
    str r2, [fp, #-16]

@ calculate cost is x*small_price + y*medium_price + z*large_price
@ store 0 into r0
    mov r0, #0

@ load value of x into r1
    ldr r1, [fp, #-8]
@ load value of small_price into r2
    ldr r2, =small_price
    ldr r2, [r2]
@ multiply x * small_price
    mul r1, r1, r2
@ add x * small_price into r0
    add r0, r0, r1

@ load value of y into r1
    ldr r1, [fp, #-12]
@ load value of medium_price into r2
    ldr r2, =medium_price
    ldr r2, [r2]
@ multiply y * medium_price
    mul r1, r1, r2
@ add y * medium_price into r0
    add r0, r0, r1

@ load value of z into r1
    ldr r1, [fp, #-16]
@ load value of large_price into r2
    ldr r2, =large_price
    ldr r2, [r2]
@ multiply z * large_price
    mul r1, r1, r2
@ add z * large_price into r0
    add r0, r0, r1

@ move sp back to original position
    sub sp, fp, #4
@ restore fp and pc
    pop {fp, pc}

@ sum function 
    .text
    .global sum
sum:
    @ save registers fp and lr
    push {fp, lr}
    add fp, sp, #4
@ set up the stack frame with 3 local variables
    sub sp, sp, #12
@ [fp, #-8] is parameter x
@ [fp, #-12] is parameter y
@ [fp, #-16] is parameter z

@ load value of parameters
    str r0, [fp, #-8]
    str r1, [fp, #-12]
    str r2, [fp, #-16]

@ load value of x into r0
    ldr r0, [fp, #-8]
@ load value of y into r1
    ldr r1, [fp, #-12]
    add r0, r0, r1
@ load value of z into r1
    ldr r1, [fp, #-16]
    add r0, r0, r1

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
@ set up the stack frame with 6 local variables
    sub sp, sp, #24
@ [fp, #-8] is parameter num_small
@ [fp, #-12] is parameter num_medium
@ [fp, #-16] is parameter num_large
@ [fp, #-20] is parameter total_cost
@ [fp, #-24] is parameter num_pizzas
@ [fp, #-28] is parameter user_input
 
@ initialize num_small to 0
@ store the address of num_small into r0
    sub r0, fp, #8
@ store 0 into num_small
    mov r0, #0

@ initialize num_medium to 0
@ store the address of num_medium into r0
    sub r0, fp, #12
@ store 0 into num_medium
    mov r0, #0

@ initialize num_large to 0
@ store the address of num_large into r0
    sub r0, fp, #16
@ store 0 into num_large
    mov r0, #0
    
@ print out the welcome
@ load welcome_string_ptr into the register r0
    ldr r0, welcome_string_ptr
@ print out the welcome_string
    bl printf

@ print out the question for client to ask which size of pizza they want to order
@ load pizza_size_prompt_string_ptr into the register r0
    ldr r0, pizza_size_prompt_string_ptr
    bl printf

@ load user_input_ptr into the register r0
    ldr r0, user_input_ptr
@ store the address user_input into the register r0
    sub r1, fp, #28
@ scan the value
    bl scanf

@ load value of user_input into the register r0
    ldr r0, [fp, #-28]
@ check if thee user's input is 's'
    cmp r0, #'s'
@ if user_input != 's', direct to branch not_small
    bne not_small

@ if user_input == 's', add 1 into num_small
@ store addrress of num_small into r0
    sub r0, fp, #8
@ load value of num_small into r1
    ldr r1, [fp, #-8]
@ add 1 into r1
    add r1, r1, #1
@ store the value r1 into num_value
    str r1, [r0]
@ direct to endif branch
    b endif

@ label not_small
not_small:
@ load value of user_input into the register r0
    ldr r0, [fp, #-28]
@ check if thee user's input is 'm'
    cmp r0, #'m'
@ if user_input != 'm' direct to branch is_large
    bne is_large
    
@ if user_input == 'm', add 1 into num_medium
@ store addrress of num_medium into r0
    sub r0, fp, #12
@ load value of num_medium into r1
    ldr r1, [fp, #-12]
@ add 1 into r1
    add r1, r1, #1
@ store the value r1 into num_value
    str r1, [r0]
@ direct to endif branch
    b endif

@ label is_large
is_large:
@ if user_input == 'l', add 1 into num_large
@ store addrress of num_large into r0
    sub r0, fp, #16
@ load value of num_large into r1
    ldr r1, [fp, #-16]
@ add 1 into r1
    add r1, r1, #1
@ store the value r1 into num_value
    str r1, [r0]

@ label endif
endif:
@ calculate the total number of pizzas and store it into total_cost
@ store the value of num_small into r0
    ldr r0, [fp, #-8]
@ store the value of num_medium into r1
    ldr r1, [fp, #-12]
@ store the value of num_large into r2
    ldr r2, [fp, #-16]
@ call the function with three arguments
    bl sum
@ store the value of the function call into number_pizzas
    str r0, [fp, #-24]

@ print out the number of pizzas the client orders
@ load num_pizzas_string_ptr into the register r0
    ldr r0, num_pizzas_string_ptr
@ load the value of number_pizzas into r1
    ldr r1, [fp, #-24]
@ print out the num_pizzas_string
    bl printf

@ calculate the total cost of the order
@ store the value of num_small into r0
    ldr r0, [fp, #-8]
@ store the value of num_medium into r1
    ldr r1, [fp, #-12]
@ store the value of num_large into r2
    ldr r2, [fp, #-16]
@ call the function with three arguments
    bl cost
@ store the value of the function call into total_cost
    str r0, [fp, #-20]

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
@ pizza_size_prompt_string_ptr: pointer for pizza_size_prompt_string
pizza_size_prompt_string_ptr:
    .word pizza_size_prompt_string
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
@ user_input_ptr: pointer for user_input
user_input_ptr:
    .word user_input

