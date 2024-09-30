section	.data
	;define the lookup table with 10 tables,globally defined
	lookup_table	dq	10,20,30,40,50,60,70,80,90,100

	;define a string to print
	msg	db	"Value at index: ",0

section	.bss
	;space for storing the result (number to print)
	result	resb	10


section	.text
global _start
_start:
	;define the index to look up
	mov	rbx,1		;index = 2 (look up value at index 2)

	;calculate the address of the l
