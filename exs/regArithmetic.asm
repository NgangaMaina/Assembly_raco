section .text
    global _start

_start:
    
    mov eax, 15
    
    add eax, 5
    
    mov ebx, eax
    
    mov eax, 1    
    int 0x80       
