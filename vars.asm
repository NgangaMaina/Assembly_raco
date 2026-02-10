section .data
    sum dd 0

section .text
    global main

main:
    mov eax, 5
    add eax, 6
    mov [sum], eax

    mov eax, 1
    xor ebx, ebx
    int 0x80
