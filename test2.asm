section	.data
	numbers	dq	2

section	.text
global	_start
_start:
	;loading the address of number into rsi
	mov	rsi,numbers

	;dereferencing the load value of the number into rax
	mov	rax,[rsi]

	;convert the number into ascii, byte size
	add	rax,'0'

	;now we need to store the ascii value in memory to print it
	push	rax

	;write the ascii character to stdout
	mov	rax,1
	mov	rdi,1
	mov	rsi,rsp
	mov	rdx,1
	syscall

	;clean up the stack
	add	rsp,8

	;exit the program
	mov	rax,60
	xor	rdi,rdi
	syscall
