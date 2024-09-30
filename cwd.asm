section .bss
    cwd_buffer resb 256            ; Buffer to store the current working directory (256 bytes)

section .text
    global _start

_start:
    ; Get current working directory (sys_getcwd)
    mov rax, 79                    ; Syscall number for sys_getcwd
    mov rdi, cwd_buffer            ; Buffer to store the cwd
    mov rsi, 256                   ; Size of the buffer (256 bytes)
    syscall                        ; Invoke syscall

    ; Check if syscall succeeded (rax contains -1 on error)
    cmp rax, -1
    je exit_program                ; Exit if error occurs

    ; Print current working directory (sys_write)
    mov rdx, rax                   ; Length of the cwd (returned by sys_getcwd in rax)
    mov rax, 1                     ; Syscall number for sys_write
    mov rdi, 1                     ; File descriptor 1 (stdout)
    mov rsi, cwd_buffer            ; Buffer containing the current working directory
    syscall                        ; Invoke syscall

exit_program:
    ; Exit the program (sys_exit)
    mov rax, 60                    ; Syscall number for sys_exit
    xor rdi, rdi                   ; Exit code 0
    syscall                        ; Invoke syscall
