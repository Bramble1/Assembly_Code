section .data
    msg db "Number: ", 0x00
    msg_len equ $ - msg

section .bss
    buffer resb 20                ; Reserve space for the ASCII string (20 bytes should be enough)

section .text
    global _start

_start:
    ; Prepare the number and call the conversion function
    mov rdi, 12345               ; Load the number to convert into rdi
    lea rsi, [buffer]           ; Address where the ASCII string will be stored (rsi points to buffer)
    call convert_to_ascii       ; Call the conversion function

    ; Calculate the length of the ASCII string
    lea rax, [buffer + 20]      ; rax = end of buffer
    sub rax, rsi                ; rax = length of the string

    ; Print the message "Number: "
    mov rdi, 1                  ; File descriptor: stdout
    mov rsi, msg                ; Address of the "Number: " message
    mov rdx, msg_len            ; Length of the message
    mov rax, 1                  ; sys_write syscall number
    syscall                     ; Call the kernel to write the message

    ; Print the converted number
    mov rdi, 1                  ; File descriptor: stdout
    mov rsi, buffer             ; Address of the number string in buffer
    mov rdx, rax                ; Length of the number string (calculated earlier)
    mov rax, 1                  ; sys_write syscall number
    syscall                     ; Call the kernel to write the number

    ; Exit the program
    mov rax, 60                 ; sys_exit syscall number
    xor rdi, rdi                ; Exit code 0
    syscall                     ; Call the kernel to exit

; Function: convert_to_ascii
; Converts the integer in rdi to an ASCII string and stores it in rsi
; Returns: Length of the ASCII string in rax
convert_to_ascii:
    mov rbx, 10                 ; Divisor for modulo operation
    lea rdi, [rsi + 19]         ; Point to the end of the buffer (last byte)
    mov byte [rdi], 0           ; Null-terminate the string
    dec rdi                      ; Move pointer backward to write the first digit

    test rdi, rdi                ; Check if the number is zero
    jz .zero                     ; If zero, handle the special case

.convert_loop:
    xor rdx, rdx                 ; Clear rdx (to hold remainder)
    div rbx                      ; Divide rdi by 10, remainder in rdx
    add dl, '0'                  ; Convert remainder to ASCII
    mov [rdi], dl                ; Store the ASCII character in the buffer
    dec rdi                      ; Move pointer backward in the buffer
    test rax, rax                ; Check if quotient is zero
    jnz .convert_loop            ; If not zero, continue the loop

    ; Calculate the length of the string
    lea rax, [buffer + 20]       ; rax = end of buffer
    sub rax, rdi                 ; rax = length of the string
    ret

.zero:
    mov byte [rdi], '0'          ; Store '0' in buffer
    lea rax, [buffer + 20]       ; rax = end of buffer
    sub rax, rdi                 ; rax = length of the string
    ret
