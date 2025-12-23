	.section .rodata
hello_str:
	.ascii "Hello, world!\012\000"
	.align 2

	.text
	.global main
main:
	push {fp, lr}
	add fp, sp, #4

	ldr r0, hello_str_ptr
	bl printf
	
	mov r0, #0
	pop {fp, pc}

hello_str_ptr:
	.word hello_str
