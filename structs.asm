section .data
    name_label db "Name: ", 0        ; Label for name (null-terminated)
    age_label  db "Age: ", 0         ; Label for age (null-terminated)
    newline    db 10, 0              ; Newline character

section .bss

section .text
    global _start

_start:
    ; Reserve space on the stack for the struct (16 bytes: 8 for age, 8 for name)
    sub rsp, 16                

    ; Initialize the struct fields
    mov qword [rsp], 30         ; Age (first 8 bytes) at [rsp] (age = 30)
    lea rax, [rel person_name]  ; Load the address of the name string
    mov qword [rsp+8], rax      ; Store the address of the name (next 8 bytes) at [rsp+8]

    ; Output the name label
    lea rdi, [name_label]       ; Load address of "Name: "
    call print_string

    ; Output the person's name
    mov rsi, [rsp+8]            ; Load the address of the name
    call print_string

    ; Print a newline
    lea rdi, [newline]          ; Load address of newline
    call print_string

    ; Output the age label
    lea rdi, [age_label]        ; Load address of "Age: "
    call print_string

    ; Output the person's age as a number
    mov rdi, [rsp]              ; Load the age
    call print_number           ; Convert and print the number

    ; Print a newline
    lea rdi, [newline]          ; Load address of newline
    call print_string

    ; Exit the program
    mov rax, 60                 ; Syscall: exit
    xor rdi, rdi                ; Status: 0
    syscall

; Function to print a null-terminated string
print_string:
    ; Arguments: rdi = pointer to string
    mov rax, 1                  ; Syscall: write
    mov rdi, 1                  ; File descriptor: stdout
    mov rsi, rdi                ; Set rsi to point to the string
    mov rdx, rdi                ; Set rdx to point to the string length
    call string_length          ; Get the length of the string
    syscall                     ; Perform syscall (write)
    ret

; Function to print a number (converts it to ASCII and writes to stdout)
print_number:
    ; Arguments: rdi = number to print
    mov rax, rdi                ; Copy number into rax
    xor rsi, rsi                ; Clear rsi (used for storing digits)
    mov rcx, 10                 ; Divisor (base 10)
    
convert_loop:
    xor rdx, rdx                ; Clear rdx for division
    div rcx                     ; Divide rax by 10
    add dl, '0'                 ; Convert remainder to ASCII ('0' + remainder)
    push rdx                    ; Store digit on stack
    inc rsi                     ; Increment digit count
    test rax, rax               ; Check if the quotient is zero
    jnz convert_loop            ; Repeat if quotient is non-zero

print_digits:
    pop rax                     ; Get the next digit from stack
    mov rdi, rax                ; Set rdi to the digit
    call print_char             ; Print the digit
    dec rsi                     ; Decrement digit count
    jnz print_digits            ; Repeat until all digits are printed
    ret

; Function to print a single character (used by print_number)
print_char:
    ; Arguments: rdi = ASCII character
    mov rax, 1                  ; Syscall: write
    mov rdi, 1                  ; File descriptor: stdout
    mov rsi, rdi                ; Address of the character to print
    mov rdx, 1                  ; Length (1 byte)
    syscall                     ; Perform syscall
    ret

; Helper function to get the length of a string (null-terminated)
string_length:
    ; Arguments: rdi = pointer to string
    xor rax, rax                ; Zero the counter (rax)
length_loop:
    cmp byte [rdi + rax], 0     ; Check if current byte is null
    je done                     ; If null, we're done
    inc rax                     ; Otherwise, increment the counter
    jmp length_loop             ; Repeat
done:
    ret

section .rodata
    person_name db "Bob", 0      ; Name of the person (null-terminated)

