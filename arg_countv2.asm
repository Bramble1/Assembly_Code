;This version uses the stack, thus no global variables and only local variables
;to each stackframe

section .text
global	_start
_start:
	;setup up the stack frame
	push	rbp
	mov	rbp,rsp
	
	;step 1 get argc from the stack,already at the top of the stack
	mov	rax,[rbp]
	
	;step 2 check if argc > 1
	cmp	rax,1
	je	no_argument

	;step 3 convert argc to a string and store it on bss	
