section .data
    char_to_print db 'A'       ; Character to print
    newline db 0xA             ; Newline character
    count db 3                 ; Number of times to print the character

section .text
    global _start

_start:
    movzx r9, byte [count]    ; Load the count into rcx as zero-extended to 64 bits

print_loop:
    ; Print the character
    mov rax, 1                 ; Syscall number for sys_write
    mov rdi, 1                 ; File descriptor 1 (stdout)
    mov rsi, char_to_print     ; Address of the character to print
    mov rdx, 1                 ; Length of the character (1 byte)
    syscall                    ; Call kernel to write the character

    ; Print a newline character for readability
    mov rax, 1                 ; Syscall number for sys_write
    mov rdi, 1                 ; File descriptor 1 (stdout)
    mov rsi, newline           ; Address of the newline character
    mov rdx, 1                 ; Length of the newline character (1 byte)
    syscall                    ; Call kernel to write the newline

    ; Decrement the loop counter
    dec r9                    ; Decrement rcx
    jnz print_loop             ; Jump back to print_loop if rcx is not zero

    ; Exit the program
    mov rax, 60                ; Syscall number for exit
    xor rdi, rdi               ; Exit code 0
    syscall
