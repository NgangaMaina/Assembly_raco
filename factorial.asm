section .text
    global _start

_start:
    mov rdi, 5      ;n is set to 5
    call factorial

    ;Result in RAX, exit
    mov rax, 60
    mov rdi, 0
    syscall

factorial:
    ;Prologue
    push rbp
    mov rbp, rsp

    ;Base case
    cmp rdi, 1      ;check if n <= 1
    jle .base_case

    ;Recursive step
    push rdi        ;Preserve current 'n' on stack
    dec rdi         ;n - 1
    call factorial      ;recursive call

    pop rdi         ;Restore original 'n'
    imul rax, rdi

    jmp .end

.base_case:
    mov rax, 1

.end:
    mov rsp, rbp        ;Restore stack pointer
    pop rbp             ;Restore caller's base pointer
    ret
