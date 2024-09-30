section .data
	no_arg_msg:	db	"No arguments passed.",0x0A
	no_arg_len:	equ	$ - no_arg_msg
	
	num_msg:	db	"Number of arguments: ",0x00

section	.bss
	buffer	resb	4

section .text
global	_start

_start:
	;step 1 get argc from the stack
	mov	rax,[rsp]

	;setp 2 check if argc > 1 (there are no arguments otherwise)
	cmp	rax,1
	je	no_argument

	;step 3 concert argc to a string and store it in the buffer
	sub	rax,1		;adjust argc to exclude the program name
	call	int_to_ascii

	;step 4 print the message and the number of arguments
	mov	rdi,1
	mov	rsi,num_msg
	mov	rdx,21
	mov	rax,1
	syscall

	;step 5 write the converted number
	mov	rdi,1
	mov	rsi,buffer
	mov	rdx,4
	mov	rax,1
	syscall

	;step 6 exit the program
	mov	rax,60
	xor	rdi,rdi
	syscall

no_argument:
	;if no arguemnts are passed, print a message
	mov	rdi,1
	mov	rsi,no_arg_msg
	mov	rdx,no_arg_len
	mov	rax,1
	syscall

	;exit the program
	mov	rax,60
	xor	rdi,rdi
	syscall

;Function: int_to_ascii
;converts the number in rax to an ascii string and stores it in the buffer
int_to_ascii:
	mov	rbx,10		;divisior modulo operation
	lea	rdi,[buffer+3]	;point to end of buffer(3rd byte,since 4th is for null terminator)
	mov	byte[rdi],0	;null-terminate the string

.convert_loop:
	xor	rdx,rdx		;clear rdx to hold remainder
	div	rbx		;divide rax by 10,remainder in rdx,quotient in rax
	add	dl,'0'		;convert remainder to ascii
	dec	rdi		;move the pointer backward in the buffer
	mov	[rdi],dl	;store the ascii character in the buffer,dl is the 1 byte section of rdx
	test	rax,rax		;check if the quotient is 0
	jnz	.convert_loop	;if not zero continue the looop
	ret		
