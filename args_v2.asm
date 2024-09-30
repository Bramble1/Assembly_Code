section .data
    newline db 0x0A                ; Newline character

section .text
    global _start

_start:
    ; Access argv[1] (first command-line argument)
    mov rsi, [rsp + 16]            ; Load address of argv[1] into rsi

    ; Calculate the length of argv[1]
    mov rax, rsi                   ; Copy argv[1]'s address to rax
    call string_length              ; Call function to calculate string length
    ; Length of argv[1] is now in rax

    ; Write argv[1] to stdout
    mov rdx, rax                   ; rdx = length of argv[1]
    mov rdi, 1                     ; File descriptor (stdout)
    mov rax, 1                     ; Syscall number (sys_write)
    syscall                        ; Invoke syscall

    ; Write a newline to stdout
    mov rax, 1                     ; Syscall number (sys_write)
    mov rdi, 1                     ; File descriptor (stdout)
    mov rsi, newline               ; Address of newline character
    mov rdx, 1                     ; Length of newline character
    syscall                        ; Invoke syscall

    ; Exit the program
    mov rax, 60                    ; Syscall number (sys_exit)
    xor rdi, rdi                   ; Exit code 0
    syscall                        ; Invoke syscall

; Function: string_length
; Calculates the length of a null-terminated string
; Input: rax = pointer to the string
; Output: rax = length of the string
string_length:
    xor rcx, rcx                   ; Clear the counter (length = 0)

.loop:
    cmp byte [rax + rcx], 0        ; Compare current byte to null terminator
    je .done                       ; If null terminator, exit loop
    inc rcx                        ; Increment length counter
    jmp .loop

.done:
    mov rax, rcx                   ; Return the length in rax
    ret
