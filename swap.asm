section .text
    global _start

_start:
    mov eax, 111
    mov ebx, 222

    call comp_registers

    mov eax, 1
    int 0x80

comp_registers:
    push eax
    push ebx

    pop eax
    pop ebx
    ret
