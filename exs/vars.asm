section .data
    value_A dd 50
    value_B dd 10

section .text
    global _start

_start:

    mov eax, [value_A]
    
    
    mov ecx, [value_B]
    
    sub eax, ecx
    
    add eax, 20
    
    mov ebx, eax
   
    mov eax, 1
    int 0x80
