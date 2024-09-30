section .data
    no_arg_msg db "No arguments provided.", 0x0A
    no_arg_len equ $ - no_arg_msg

section .text
    global _start

_start:
    ; Check if argc > 1 (rdi holds argc)
    cmp rdi, 1                ; Compare argc with 1 (program name)
    jle no_argument            ; If argc <= 1, jump to no_argument

    ; Load argv[1] (first argument) into rsi
    mov rsi, [rsi + 16]         ; rsi = argv[1] (first argument)

    ; Calculate the length of the argument string
    call string_length          ; rax will contain the length of argv[1]

    ; Write the argument string to stdout
    mov rdi, 1                 ; File descriptor: stdout
    mov rdx, rax               ; rdx = length of the string (from string_length)
    mov rax, 1                 ; sys_write syscall number (1)
    syscall                    ; Call the kernel to write the string

    ; Exit the program
    mov rax, 60                ; sys_exit syscall number (60)
    xor rdi, rdi               ; Exit code 0
    syscall                    ; Call the kernel to exit

no_argument:
    ; If no arguments are provided, print a message
    mov rdi, 1                 ; File descriptor: stdout
    mov rsi, no_arg_msg        ; Address of "No arguments provided" message
    mov rdx, no_arg_len        ; Length of the message
    mov rax, 1                 ; sys_write syscall number (1)
    syscall                    ; Call the kernel to write the message

    ; Exit the program
    mov rax, 60                ; sys_exit syscall number (60)
    xor rdi, rdi               ; Exit code 0
    syscall                    ; Call the kernel to exit

; Function: string_length
; Calculates the length of a null-terminated string
; Input: rsi = pointer to the string
; Output: rax = length of the string
string_length:
    xor rax, rax               ; Clear rax (to hold the length)
.string_loop:
    cmp byte [rsi + rax], 0    ; Compare current byte with null terminator (0)
    je .done                   ; If null terminator is found, end the loop
    inc rax                    ; Increment the length counter
    jmp .string_loop           ; Repeat the loop

.done:
    ret
