section .data
	numbers	db	1,2,3,4,5
	count	equ	5
	newline	db	10
	buffer	db	' ',0

section	.text
global	_start
_start:
	;setup the loop counter
	mov	rbx,0

print_loop:
	cmp	rbx,count
	jge	end_program

	;convert number to string
	movzx	rax,byte [numbers+rbx]
	call	num_to_string

	;write the number to stdout
	mov	rax,1
	mov	rdi,1
	lea	rsi,[buffer]
	mov	rdx,rax
	syscall

	;write newline to stdout
	mov	rax,1
	mov	rdi,1
	lea	rsi,[newline]
	mov	rdx,1
	syscall

	inc	rbx
	jmp	print_loop
