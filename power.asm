%include 'std_lib.asm'

section .data

	buffer:	db	'\0',3

section .text
global _start,_power

_start:
	mov	rbp,rsp
	push	2
	push	2
;	call	_power
	call	power		
	add	rsp,16		;resetting rsp pointer
	
	add	rax,48
	mov	[buffer],rax
	push	buffer
	push	1
	call	write_buffer
	add	rsp,16
	

	call	exit
						
