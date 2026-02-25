section .data
    fmt db "gcd(%d, %d) = %d", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    mov rdi, 48
    mov rsi, 18
    call gcd
    mov rbx, rax

    sub rsp, 16               ; ← key fix
    lea rdi, [rel fmt]
    mov rsi, 48
    mov rdx, 18
    mov rcx, rbx
    xor eax, eax
    call printf
    add rsp, 16

    xor edi, edi
    mov eax, 231
    syscall
    ; ret   ← optional if you keep syscall exit


gcd:
.loop:
    cmp rsi, 0
    je .done

    mov rax, rdi
    xor edx, edx         
    div rsi

    mov rdi, rsi
    mov rsi, rdx

    jmp .loop

.done:
    mov rax, rdi
    ret
