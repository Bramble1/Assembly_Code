section	.data
	numbers	dq	1,2,3,4,5

section	.text
global	_start

_start:
	push	rbp
	mov	rbp,rsp
	xor	r10,r10
	mov	r10,0

loop:
	;get the current index into the array
	mov	rax,r10
	inc	rax
	imul	rax,8
	sub	rax,8
	;load the number from the array
	mov	r9,[numbers+rax]

	;convert to ascii and print
	push	r9
	call	convert_to_ascii
	pop	r9

	;print the number in rax to stdout
	push	rax
	mov	rax,1
	mov	rdi,1
	mov	rsi,rsp
	mov	rdx,1
	syscall
	pop	rax

	inc	r10
	cmp	r10,5
	jne	loop

	;exit the program
	mov	rsp,rbp
	pop	rbp
	call	exit

convert_to_ascii:
	;stack prologue
	push	rbp
	mov	rbp,rsp

	mov	rax,[rbp+16]
	add	rax,'0'

	;stack epilogue
	mov	rsp,rbp
	pop	rbp
	ret

exit:
	mov	rax,60
	xor	rdi,rdi
	syscall
