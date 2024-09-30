section .data
	no_args_msg:	db	"No arguments passed.",0x0A
	no_args_msg_len:	equ	$ - no_args_msg

	num_msg:	db	"Number of arguments: ",0x00

section	.bss
	buffer	resb	4	;reserve space for 3 digits, assuming argument is 3 bytes + null

section	.text
global	_start
_start:
	;Step 1 check if argc is > 1
	mov	rax,[rsp]

	cmp	rax,1
	je	no_argument

	;step 2 convert the arg1 to a string and store it in the buffer
	mov	rax,[rsp+16]
;	call	int_to_ascii

	;step 3 print the argument
	mov	rdi,1
	mov	rsi,rax
	mov	rdx,4
	mov	rax,1
	syscall

exit:
	;step 4 exit the program
	mov	rax,60
	xor	rdi,rdi
	syscall

no_argument:
	;if no arguments are passed print a message
	mov	rdi,1
	mov	rsi,no_args_msg
	mov	rdx,no_args_msg_len
	mov	rax,1
	syscall

	;exit the program
	jmp	exit

;function converts rax to ascii string
int_to_ascii:
	mov	rbx,10	;divisor
	lea	rdi,[buffer+3]
	mov	byte[rdi],0

.convert_loop:
	xor	rdx,rdx		;hold the remainder
	div	rbx		;divide by 10
	add	dl,'0'		;rdx - dl 8 bits of register
	dec	rdi
	mov	[rdi],dl	;store the ascii byte into the buffer
	test	rax,rax		;check quotient is 0
	jnz	.convert_loop
	ret		
