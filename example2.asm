section .text
	global _start

_start:

	mov al,'3'
	sub al,'0'
	
	mov bl,'2'
	sub bl,'0'
	mul bl
	add al,'0'


