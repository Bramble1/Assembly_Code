;Work out the length of a buffer,assumed arguments are pushed on the stack in the order:
;push message(buffer) , push length (the calculated length stored)
;_______________________________________________________________________
bytelen:
	push	rbp
	mov	rbp,rsp
	mov	r9,[rbp+24]		;message
	
	count:
		cmp	byte[r9],0
		jz	return
		inc	qword[rbp+16]
		inc	r9
		jmp	count

	return:
		pop	rbp
		ret

;Print a buffer to stdout
;push message,push length
write_buffer:
	push	rbp
	mov	rbp,rsp

	;write:
		mov	rax,1
		mov	rsi,[rbp+24]
		mov	rdx,[rbp+16]
		mov	rdi,1
		syscall

	;return:
		pop	rbp
		ret


;Exit Program
exit:
	mov	rax,60
	mov	rdi,1
	syscall
	ret


;Power Function
;Push base , Push exponent. Return value in rax register
power:
	push	rbp
	mov	rbp,rsp

	mov	r9,[rbp+16]
	mov	r10,[rbp+24]
	mov	rax,r10
	mov	rcx,r10

	calculate:
		mul	rcx
		dec	r9
		cmp	r9,1
		je	finished
		jmp	calculate

	finished:
		pop	rbp
		ret

;create stack frame function

;destroy stack frame function



;Function to open a file

;Function to obtain size of file


;FUnction to convert number into ascii bytes and store into
;buffer, which can then be printed using write_buffer()


