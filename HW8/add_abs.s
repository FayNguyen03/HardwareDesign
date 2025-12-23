	.section .rodata
string:	.ascii "%d\0"
	.align 2

	.text
	.global main
main:
	push	{fp, lr}
	add	fp, sp, #4
	sub 	sp, sp, #12

	ldr	r0, string_ptr
	sub	r1, fp, #8
	bl	scanf

	ldr	r0, string_ptr
	sub	r1, fp, #12
	bl	scanf
	@ check whether the first operand is >= 0 or not; if so, move to compare_second section
	ldr	r0, [fp, #-8]
	cmp 	r0, #0
	bge	compare_second
	@ if not, multiply -1 into first operand
	mov	r1, #-1
	mul 	r0, r0, r1
	sub	r1, fp, #8
	str	r0, [r1]

compare_second:
	@ check whether the second operand is >= 0 or not; if so, move to end section
	ldr	r0, [fp, #-12]
	cmp	r0, #0
	bge	end
	@ if not, multiply -1 into second operand
	mov	r1, #-1
	mul	r0, r0, r1
	sub 	r1, fp, #12
	str 	r0, [r1]
end:
	@ add up two absolute values of operands
	sub	r0, fp, #16
	ldr	r1, [fp, #-8]
	ldr	r2, [fp, #-12]
	add	r1, r1, r2
	str	r1, [r0]
	ldr	r0, string_ptr
	ldr	r1, [fp, #-16]
	bl	printf

	mov	r0, #0
	sub	sp, fp, #4
	pop	{fp, pc}


string_ptr:	.word string

