%include 'std_lib.asm'

struc STAT
	.st_dev		resq	1
	.st_ino		resq	1
	.st_nlink	resq	1
	.st_mode	resd	1
	.st_uid		resd	1
	.st_gid		resd	1
	.pad0		resb	4
	.st_rdev	resq	1
	.st_size	resq	1
	.st_blksize	resq	1
	.st_blocks	resq	1
	.st_atime	resq	1
	.st_atime_nsec	resq	1
	.st_mtime	resq	1
	.st_mtime_nsec	resq	1
	.st_ctime	resq	1
	.st_ctime_nsec	resq	1
endstruc

section .data
	size:	dq	0
	length:	dq	0
	open_msg:	db	'error opening file',0
	buffer:	db	'\0',3

section .text
global _start

_start:
	mov	rbp,rsp

	open_file:
		mov	rdi,[rbp+16]
		mov	rax,2
		mov	rsi,0x402
		syscall

		cmp	rax,0
		jng	open_error
		jmp	obtain_file_size

		open_error:
			push	open_msg
			push	qword[length]
			call	bytelen
			pop	qword[length]
			push	qword[length]
			call	write_buffer
			add	rsp,16
			jmp	end
	
	obtain_file_size:
		mov	rdi,[rbp+16]
		mov	rsi,rsp
		mov	rax,4
		syscall
		
		mov	rsi,[rsp+STAT.st_size]
		mov	[size],rsi

	output_file_size:
			push	qword[size]
			push	buffer
			call	write_integer
			add	rsp,16

	end:
		call	exit
