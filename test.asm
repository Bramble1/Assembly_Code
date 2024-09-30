section .data
    number dq 2                       ; Define a number in memory

section .text
    global _start

_start:
    ; Loading the address of 'number' into rsi
    mov rsi, number                   ; rsi = address of 'number'

    ; Dereferencing to load the value of 'number' into rax
    mov rax, [rsi]                    ; rax = value at address rsi (which is 2)

    ; Convert number in rax to ASCII
    add rax, '0'                      ; rax = ASCII of '2'

    ; Now we need to store the ASCII value in memory to print it
    push rax                          ; Push ASCII '2' onto the stack

    ; Write the ASCII character to stdout
    mov rax, 1                        ; Syscall number for sys_write
    mov rdi, 1                        ; File descriptor 1 (stdout)
    mov rsi, rsp                      ; Use the stack pointer (rsp) as address of the ASCII character
    mov rdx, 1                        ; Write 1 byte
    syscall

    ; Clean up the stack
    add rsp, 8                        ; Adjust stack pointer

    ; Exit the program
    mov rax, 60                       ; Syscall number for exit
    xor rdi, rdi                      ; Exit code 0
    syscall
