section .data
    numbers dq 1, 2, 3, 4, 5           ; Array of 64-bit numbers
    num_len equ 5                      ; Number of elements in the array
    newline db 0xA                     ; Newline character
    
section .bss
    buffer resb 20                     ; Buffer to hold converted number as ASCII

section .text
    global _start

_start:
    mov rsi, numbers                   ; Load the address of the array into rsi
    mov rcx, num_len                   ; Set loop counter to the number of elements

print_loop:
    mov rax, [rsi]                     ; Load the current number from the array
    add rsi, 8                         ; Move to the next element (64-bit numbers, so 8 bytes)

    ; Reset the buffer pointer to the end of the buffer for each iteration
    mov rdi, buffer + 20               ; Point to the end of the buffer (reverse storage)
    
    ; Convert number to string and store it in buffer
    call convert_to_string
    
    ; Print the converted number
    mov rdx, rax                       ; rax contains the string length from convert_to_string
    mov rsi, rdi                       ; rsi points to the start of the converted string
    mov rax, 1                         ; Syscall number for sys_write
    mov rdi, 1                         ; File descriptor 1 (stdout)
    syscall
    
    ; Print newline
    mov rax, 1                         ; Syscall number for sys_write
    mov rdi, 1                         ; File descriptor 1 (stdout)
    mov rsi, newline                   ; Address of the newline character
    mov rdx, 1                         ; Length of the newline character (1 byte)
    syscall

    loop print_loop                    ; Decrement rcx and repeat if rcx != 0

    ; Exit program
    mov rax, 60                        ; Syscall number for exit
    xor rdi, rdi                       ; Exit code 0
    syscall

;---------------------------------------
; Subroutine: convert_to_string
; Converts the number in rax to a string in rdi (buffer).
; Returns the length of the string in rax.
;---------------------------------------
convert_to_string:
    mov rbx, 10                        ; Divisor for base 10
    mov rcx, 0                         ; Digit count (string length)

convert_loop:
    xor rdx, rdx                       ; Clear rdx (remainder)
    div rbx                            ; Divide rax by 10, result in rax, remainder in rdx
    add dl, '0'                        ; Convert remainder to ASCII character
    dec rdi                            ; Move the destination buffer pointer backwards
    mov [rdi], dl                      ; Store the ASCII character in the buffer
    inc rcx                            ; Increase the digit count
    test rax, rax                      ; Check if the quotient is 0
    jnz convert_loop                   ; Repeat if quotient is not zero

    mov rax, rcx                       ; Return the string length in rax
    ret
