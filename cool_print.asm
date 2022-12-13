format ELF64 executable 3

segment readable executable
entry v_start

v_start:

	push	rsp
	sub	rsp,5000
	mov	r15,rsp


	call output	;we will pop the message from the prev stack when calling msg func
	msg:
	    db 0x68, 0x65, 0x6c, 0x6c, 0x0 , 0xA
	    len = $-msg

	output:
		pop	rsi
		mov	rcx,len
		lea	rdi,[r15+3001]
		
		.loop:
			lodsb		;lodsb & stosb store in rdi, which we put a pointer in to a stack offset.
					;makes it easier to write output it seems this way in assembler
			stosb
			loop	.loop

		lea	rsi,[r15+3001]
		mov	rax,1
		mov	rdi,1
		mov	rdx,len
		syscall


	cleanup:
		add	rsp,5000
		pop	rsp
		
	
	v_stop:
		xor	rdi,rdi
		mov	rax,60
		syscall
