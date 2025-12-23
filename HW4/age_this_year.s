	.section .data
current_year:
	.word 0
birth_year:
	.word 0
age:
	.word 0

	.section .rodata
current_year_prompt_str:
	.ascii "Enter the current year: \000"
	.align 2
birth_year_prompt_str:
	.ascii "Enter your birth year: \000"
	.align 2
current_year_str:
	.ascii "This current year is %d. \012\000"
	.align 2
year_old_str:
	.ascii "This year I turn %d years old. \012\000"
	.align 2
specific_year_old_str:
	.ascii "In %d, I will turn %d years old. \012\000"
	.align 2
input:
	.ascii "%d\000"
	.align 2

	.text
	.global main
main:
	push {fp,lr}
	add fp, sp, #4
	
	ldr r0, current_year_prompt_str_ptr
	bl printf

	ldr r1, =current_year
	ldr r0, input_ptr
	bl scanf

	ldr r0, birth_year_prompt_str_ptr
	bl printf
	
	ldr r1, =birth_year
	ldr r0, input_ptr
	bl scanf

	ldr r0, current_year_str_ptr
	ldr r1, =current_year
	ldr r1, [r1]
	bl printf

	ldr r1, =current_year
	ldr r1, [r1]
	ldr r2, =birth_year
	ldr r2, [r2]
	sub r3, r1, r2
	ldr r0, =age
	str r3, [r0]

	ldr r0, year_old_str_ptr
	ldr r1, =age
	ldr r1, [r1]
	bl printf

	ldr r1, =current_year
	ldr r1, [r1]
	add r1, r1, #1
	ldr r2, =birth_year
	ldr r2, [r2]
	sub r3, r1, r2
	ldr r0, =age
	str r3, [r0]
	ldr r0, =current_year
	str r1, [r0]

	ldr r0, specific_year_old_str_ptr
	ldr r1, =current_year
	ldr r1, [r1]
	ldr r2, =age
	ldr r2, [r2]
	bl printf

	mov r0, #0
	pop {fp, pc}
	
	.align 2

current_year_prompt_str_ptr:
	.word current_year_prompt_str
birth_year_prompt_str_ptr:
	.word birth_year_prompt_str
current_year_str_ptr:
	.word current_year_str
year_old_str_ptr:
	.word year_old_str
specific_year_old_str_ptr:
	.word specific_year_old_str
input_ptr:
	.word input
	
	
