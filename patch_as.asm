format ELF64 executable 3
entry start

segment readable writeable

segment readable executable

SYS_WRITE	equ	0x1
SYS_EXIT	equ	0x3c


struc ARGS {
	.base_stack_ptr		rq	1
	.argc			rq	1
	.argv			rq	1
}
virtual at 0
	ARGS ARGS
	sizeof.ARGS = $ - ARGS
end virtual



start:
	;prologue
	push	rbp
	mov	rbp,rsp

	.obtain_arg_number:
		sub	rsp,8	
		mov	r10,[rbp+ARGS.argc]
		add	r10b,'0'
		mov	[rsp],r10b

	.output_arg_number:
		mov	rax,SYS_WRITE
		mov	rdi,1
		lea	rsi,[rbp-8]
		mov	rdx,1
		syscall

	.epilogue_exit:
		mov	rsp,rbp
		pop	rbp
		mov	rax,SYS_EXIT
		syscall

		
		
