section .data
    array dd 10, -5, 3, 7, 2, 8, -1, 4
    arrSize equ 8
    newline db 10

section .bss
    buffer resb 20

section .text
    global _start


SumRange:
    push rbx
    push r12

    mov r12, rdi        ; array base
    mov rbx, rdx        ; i = j
    xor rax, rax        ; sum = 0

.loop:
    cmp rbx, rcx
    jg .done

    movsxd r8, dword [r12 + rbx*4]
    add rax, r8

    inc rbx
    jmp .loop

.done:
    pop r12
    pop rbx
    ret


itoa:
    mov rcx, 10
    mov rbx, buffer + 19
    mov byte [rbx], 0

.convert:
    dec rbx
    xor rdx, rdx
    div rcx
    add dl, '0'
    mov [rbx], dl
    test rax, rax
    jnz .convert

    mov rsi, rbx
    mov rdx, buffer + 19
    sub rdx, rsi
    ret

_start:

    ;First call
    mov rdi, array
    mov rsi, arrSize
    mov rdx, 1
    mov rcx, 4
    call SumRange

    ; print first result
    call itoa

    mov rax, 1      ; sys_write
    mov rdi, 1      ; stdout
    syscall

    ; newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ;Second call 
    mov rdi, array
    mov rsi, arrSize
    mov rdx, 2
    mov rcx, 6
    call SumRange

    ; print second result
    call itoa

    mov rax, 1
    mov rdi, 1
    syscall

    ; newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall

