section .data
	newline:	db	0x0A

section .text
global _start
_start:
	;access argv[1] first command line argument
	mov	rsi,[rsp+16]	;load the address of argv[1] into rsi

	;calculate the length of argv[1]
	mov	rax,rsi		;copy argv[1]'s address to rax
	call	string_length	;call function to calculate string length
	;length of argv[1] is now in rax

	;write argv[1] to stdout
	mov	rdx,rax		;rdx = length of argv[1]
	mov	rdi,1
	mov	rax,1
	syscall

	;write a newline to stdout
	mov	rax,1
	mov	rdi,1
	mov	rsi,newline
	mov	rdx,1
	syscall

	;exit the program
	mov	rax,60
	xor	rdi,rdi
	syscall

;function: string length
;calculates the length of a null-terminated string
;Input: rax = pointer to the string
;Output: rax = length of the string
string_length:
	xor	rcx,rcx		;clear the counter to 0

.loop:
	cmp	byte[rax+rcx],0	;compare current byte to null terminator
	je	.done		;if null terminator, exit the loop
	inc	rcx
	jmp	.loop

.done:
	mov	rax,rcx
	ret
