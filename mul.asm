section .data
    factor1 dd 12

section .text
    global _start

_start:
    mov eax, [factor1]    
    mov ecx, 9           
    
    mul ecx            
    
    mov ebx, eax         
    
    mov eax, 1             
    int 0x80              
