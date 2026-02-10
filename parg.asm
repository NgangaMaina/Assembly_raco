section .text
    global _start
_start:
    push 3
    push 5
    push 6
    push 10
    call calculate_expression
    add esp, 10
    mov ebx, eax
    mov eax, 1
    int 0x80

calculate_expression:
    push ebp
    mov ebp, esp
    sub esp, 4
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    mul ebx
    mov [ebp - 4], eax
    mov eax, [ebp + 16]
    mov ebx, [ebp + 20]
    mul ebx
    add eax, [ebp - 4]
    mov esp, ebp

    pop ebp
    ret
