;print the supplied argument

section .data
	counter:	dd	0


section .text
global _start
_start:
	get_first_arg:
		mov	rbp,rsp
		mov	r9,[rbp+16]	;derefencing pointer points to an address on stack

	byte_count:
		cmp	byte[r9],0	;dereferencing the address to get the value it points to
		jz	print
		inc	dword[counter]	;derefencing the counter to obtain the value at memory address
		inc	r9
		jmp	byte_count
			

	print:
		mov	rax,1
		mov	rsi,[rbp+16]
		mov	rdx,[counter]
		mov	rdi,1
		syscall

	
	exit:
		mov	rax,60
		mov	rdi,1
		syscall
