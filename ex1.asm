;Create a simple global array of numbers which we will convert to ascii and then print
;each number iteratively from the array, we will define various array sizes
;to demonstrate the process

;Then we will alter this so we don't use global variables but local variables,
;thus using the stack.


section	.data
	numbers	dq	1,2,3,4,5		;8 bytes,integers

section	.text
global	_start
_start:
	
	push	rbp
	mov	rbp,rsp
	xor	r10,r10
	mov	r10,3
loop:
;	cmp	r10,2
;	je	exit

	sub	rsp,16
	mov	qword[rbp-8],2
	mov	qword[rbp-16],8
	call	multiply
	add	rsp,16

	;rax contains the position, being 16 along
	;obtain the position and conver to ascii and print to stdout
	mov	r9,[numbers+rax]
	
	;convert to ascii and print
	push 	r9
	call	convert_to_ascii
	pop	r9

	push	rax
	mov	rax,1
	mov	rdi,1
	mov	rdx,1
	mov	rsi,rsp				
	syscall
	
	dec	r10
	jnz	loop

				
	;reset stack
	mov	rsp,rbp
	pop	rbp
	
	call 	exit	
	 
	

	mov	r9,[numbers]
	
	push	r9
	call convert_to_ascii
	pop	r9

	;print the number
	push	rax

	mov	rax,1
	mov	rdi,1
	mov	rdx,1
	mov	rsi,rsp
	syscall

	pop	rax

	call exit	



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

multiply:
	;stack prologue
	push	rbp
	mov	rbp,rsp
	
	;number
	;multiplier
	mov	rax,[rbp+24]
	mov	rbx,[rbp+16]
	imul	rbx

	;stack epilogue
	mov	rsp,rbp
	pop	rbp

	ret
	
	

exit:
	mov	rax,60
	xor	rdi,rdi
	syscall
	
