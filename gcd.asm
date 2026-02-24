section .data
    fmt db "gcd(%d, %d) = %d", 10, 0

section .text
    global main
    extern printf

main:
    push rbp
    mov rbp, rsp

    ; Stack is now 16-byte aligned (push rbp re-aligns it)
    ; No extra sub rsp, 8 needed here — gcd takes no stack space

    ; gcd(48, 18)
    mov rdi, 48
    mov rsi, 18
    call gcd
    mov rbx, rax

    ; printf — stack must be 16-byte aligned before call
    ; We need to preserve rbx, so sub 8 to keep alignment
    sub rsp, 8
    lea rdi, [rel fmt]
    mov rsi, 48
    mov rdx, 18
    mov rcx, rbx
    xor rax, rax
    call printf
    add rsp, 8

    mov rsp, rbp
    pop rbp
    ret


gcd:
.loop:
    cmp rsi, 0
    je .done

    mov rax, rdi
    xor rdx, rdx
    div rsi

    mov rdi, rsi
    mov rsi, rdx

    jmp .loop

.done:
    mov rax, rdi
    ret
