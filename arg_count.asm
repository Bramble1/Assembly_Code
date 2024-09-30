section .data
    no_arg_msg db "No arguments passed.", 0x0A
    no_arg_len equ $ - no_arg_msg

    num_msg db "Number of arguments: ", 0x00

section .bss
    buffer resb 4                ; Reserve space to store the number (max 3 digits + null terminator)

section .text
    global _start

_start:
    ; Step 1: Get argc from the stack (argc is at [rsp])
    mov rax, [rsp]              ; rax = argc

    ; Step 2: Check if argc > 1 (i.e., there are arguments)
    cmp rax, 1                  ; Compare argc with 1 (just program name)
    je no_argument               ; If argc == 1, jump to no_argument

    ; Step 3: Convert argc to a string and store it in the buffer
    sub rax, 1                  ; Adjust argc to exclude the program name
    call int_to_ascii            ; Convert the number in rax to ASCII (result in buffer)

    ; Step 4: Print the message and the number of arguments
    mov rdi, 1                  ; File descriptor: stdout
    mov rsi, num_msg            ; Address of "Number of arguments: " message
    mov rdx, 21                 ; Length of the message
    mov rax, 1                  ; sys_write syscall number (1)
    syscall                     ; Call the kernel to write the message

    ; Step 5: Write the converted number
    mov rdi, 1                  ; File descriptor: stdout
    mov rsi, buffer             ; Address of the number string in buffer
    mov rdx, 4                  ; Length of the number string (max 3 digits)
    mov rax, 1                  ; sys_write syscall number (1)
    syscall                     ; Call the kernel to write the number

    ; Step 6: Exit the program
    mov rax, 60                 ; sys_exit syscall number (60)
    xor rdi, rdi                ; Exit code 0
    syscall                     ; Call the kernel to exit

no_argument:
    ; If no arguments are passed, print a message
    mov rdi, 1                  ; File descriptor: stdout
    mov rsi, no_arg_msg         ; Address of "No arguments passed" message
    mov rdx, no_arg_len         ; Length of the message
    mov rax, 1                  ; sys_write syscall number (1)
    syscall                     ; Call the kernel to write the message

    ; Exit the program
    mov rax, 60                 ; sys_exit syscall number (60)
    xor rdi, rdi                ; Exit code 0
    syscall                     ; Call the kernel to exit

; Function: int_to_ascii
; Converts the number in rax to an ASCII string and stores it in the buffer
int_to_ascii:
    mov rbx, 10                 ; Divisor for modulo operation
    lea rdi, [buffer + 3]       ; Point to the end of the buffer (3rd byte, since 4th is for null terminator)
    mov byte [rdi], 0           ; Null-terminate the string
.convert_loop:
    xor rdx, rdx                ; Clear rdx (to hold remainder)
    div rbx                     ; Divide rax by 10, remainder in rdx, quotient in rax
    add dl, '0'                 ; Convert remainder to ASCII
    dec rdi                     ; Move pointer backward in the buffer
    mov [rdi], dl               ; Store the ASCII character in the buffer
    test rax, rax               ; Check if the quotient is 0
    jnz .convert_loop           ; If not zero, continue the loop
    ret
