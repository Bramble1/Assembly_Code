section	.data
	numbers	dq	1,2,3,4,5
	len	dq	5
section	.text
global	_start
_start:
	mov	rsi,numbers

	xor	rcx,rcx
	mov	r8,[len]
print_loop:
	cmp	rcx,4
	jg	exit
	
	;print
	mov	rax,[rsi]
	;add	rax,r9
	add	rax,'0'
	push	rax

	mov	rax,1
	mov	rdi,1
	mov	rdx,1
	mov	rsi,rsp
	syscall

	;cleanup stack
	add	rsp,8
	;increment
	;add	r9,8
	;inc	rcx	

	inc	rcx
	jmp	print_loop


exit:
	mov	rax,60
	xor	rdi,rdi
	syscall	
