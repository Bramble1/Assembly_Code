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
;__________________________________________________________________
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
;__________________________________________________________________
exit:
	mov	rax,60
	mov	rdi,1
	syscall
	ret


;Power Function
;Push base , Push exponent. Return value in rax register
;__________________________________________________________________
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
;_______________________________


;destroy stack frame function
;________________________________________



;Function to open a file
;_____________________________________________



;Function to obtain size of file
;_____________________________________________



;Function: Convert and print an integer to stdout
;Arguments: push number,push buffer
;_____________________________________________________
write_integer:
	push	rbp
	mov	rbp,rsp

	push	10
	push	10
	call	power
	mov	r10,rax		;r10 contains the base 
	add	rsp,16
	
	mov	r11,[rbp+16]	;buffer
	mov	r9,[rbp+24]	;r9 contains the number

	mov	r12,0
	
	base_check1:
		
		mov	r11,[rbp+16]	;[!]

		mov	rax,r9		;number - numerator
		xor	rdx,rdx
		mov	rcx,r10		;base	- divisor
		div	rcx		

		cmp	rax,0
		jne	correct1
		je	incorrect1
		
		
	correct1:


		mov	r11,[rbp+16]
		mov	rax,r9
		xor	rdx,rdx
		mov	rcx,r10
		div	rcx



		mov	r12,1		;encounterd first digit
;		cmp	rdx,0
;		je	last_digit1	;because of this,we're not at the
					;last digit,so need another way to 
					;determine last digit
					;by checking if r10(base) is not less than 1
	
		cmp	r10,1		;base
		je	last_digit1

		
		mov	r9,rdx		;remainder into number
		add	rax,48
		mov	[r11],rax	;buffer
		mov	rax,1
		mov	rsi,r11
		mov	rdx,1
		mov	rdi,1
		syscall

		jmp	reduce_base1

		last_digit1:
			add	rax,48
			mov	[r11],rax
			mov	rax,1
			mov	rsi,r11
			mov	rdx,1
			mov	rdi,1
			syscall
			jmp	ret2
		
	incorrect1:
		jmp	reduce_base1

	reduce_base1:
		
		cmp	r10,0	;base is 0
		je	ret2
		
		mov	rax,r10
		xor	rdx,rdx
		mov	rcx,10
		div	rcx
		mov	r10,rax


		cmp	r12,0
		je	base_check1

		cmp	r12,1
		jmp	correct1
		

	ret2:
		pop	rbp
		ret



