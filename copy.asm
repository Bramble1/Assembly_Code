section	.bss
	cwd_buffer	resb	256

section	.text
global _start
_start:

	;char *buffer[256]
	push	rbp
	mov	rbp,rsp
	sub	rsp,256

	

	;get current working directory
	mov	rax,79
	lea	rdi,[rbp-256]
	mov	rsi,256
	syscall

	cmp	rax,-1
	je	exit_program

	;print the working directory
	mov	rdx,rax
	mov	rax,1
	mov	rdi,1
	lea	rsi,[rbp-256]
	syscall

exit_program:

reset_stack:
	pop	rbp
	mov	rsp,rbp

	mov	rax,60
	xor	rdi,rdi
	syscall
