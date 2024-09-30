section	.data
	numbers	dq	1,2,3,4,5

section	.text
global	_start
_start:
	;loading the address of number into rsi
	mov	rsi,numbers

	;print the second element
	add	rsi,16
	
	mov	rax,[rsi]	;dereference the address

	;convert to ascii
	add	rax,'0'
	
	;push on the stack for rsi to point to a memory address
	push	rax

	;write to stdout
	mov	rax,1
	mov	rdi,1
	mov	rdx,1
	mov	rsi,rsp
	syscall

	;clean up stack
	add	rsp,8

	;exit the program
	mov	rax,60
	xor	rdi,rdi
	syscall

