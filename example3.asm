section .data
	userMsg db 'Please enter a number:'
	lenUserMsg equ $-userMsg	;expression for string length
	dispMsg db 'You have entered: '
	lenDispMsg equ $-dispMsg
	number dd 2
	power equ 2^2
section .bss	;uninitialized data
	num resb 5

section .text
	global _start

_start:


	

	mov eax,4	;writing to stdout fd
	mov ebx,1	;stdout
	mov ecx,userMsg	;pointer to byte array of chars
	mov edx,lenUserMsg ;how much data to write(the entire size of array)
	int 80h


	mov eax,1	;exit systemcall
	mov ebx,0
	int 80h

