;Example of division and multiplications
section .data
	mval:	dd	664751
	dval:	dd	8

section .text
global _start
_start:
	;MUL 1-operand
	mov	eax,[mval]
	mov	ebx,8
	mul	ebx

	;IMUL 1-operand (IMUL & IDIV - also allows us to work with signed(negatives)
	mov	eax,[mval]
	mov	ebx,8
	imul	ebx

	;IMUL 2-operand
	mov	eax,8
	imul	eax,[mval]

	;IMUL 3-operand
	imul	eax,[mval],8	;multiply by 8 and store in eax

	;DIV 1-operand
	mov	edx,0		;remainder register
	mov	eax,5318008	;numerator
	mov	ecx,[dval]	;divisor
	div	ecx

	;IDIV 1-operand
	mov	edx,0
	mov	eax,5318008
	mov	ecx,[dval]
	idiv	ecx

	
	;exit
	mov	eax,1
	mov	ebx,0
	int	80h


;the result ,depending on the size of the data being operated on is stored in two seperate registers being edx and eax and it's 64bit,16bit,8bit
;counterparts. Again need to write a function to convert the numbers into their ascii byte counter parts to then print the result.
