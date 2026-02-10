section .data
    ;This is our 'hello world' meassage
    msg db 'Hello, World!', 0xA    ; Our string with newline
    msg_len equ $ - msg            ; Length of string

section .text
    global _start

_start:
    ; Write system call
    mov rax, 1          ; sys_write
    MOV rdi, 1          ; stdout
    mov rsi, msg        ; message
    mov rdx, msg_len    ; message length
    syscall
    
    ; Exit system call
    mov rax, 60         ; sys_exit
    mov rdi, 0          ; exit status
    syscall
