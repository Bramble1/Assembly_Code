section .data
    number db '5'               ; The character to print (ASCII '5')
    newline db 0xA              ; Newline character

section .text
    global _start

_start:
    mov rcx, 3                  ; Set loop counter to 3

loop_start:
    ; Print the number (ASCII character)
    mov rax, 1                  ; Syscall number for sys_write
    mov rdi, 1                  ; File descriptor 1 (stdout)
    mov rsi, number             ; Address of the number to print
    mov rdx, 1                  ; Length of the number string (1 byte for '5')
    syscall                     ; Call kernel to write the number

    ; Print a newline for better readability
    mov rax, 1                  ; Syscall number for sys_write
    mov rdi, 1                  ; File descriptor 1 (stdout)
    mov rsi, newline            ; Address of the newline character
    mov rdx, 1                  ; Length of the newline character (1 byte)
    syscall                     ; Call kernel to write the newline

    ; Decrement the loop counter
    dec rcx                     ; Decrement rcx by 1
    jnz loop_start              ; Jump back to loop_start if rcx is not zero

    ; Exit the program
    mov rax, 60                 ; Syscall number for exit
    xor rdi, rdi                ; Exit code 0
    syscall
