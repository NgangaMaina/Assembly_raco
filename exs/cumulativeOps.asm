section .data
    a dd 200
    b dd 50
    c dd 40
    d dd 10

section .bss
    temp_result resd 1

section .text
    global _start

_start:
    
    mov eax, [a]
    add eax, [b]
    mov [temp_result], eax
    
     mov eax, [c]
    add eax, [d]
   
   
    mov ebx, [temp_result]
    sub ebx, eax
    mov [temp_result], ebx
    
   
    mov ebx, [temp_result]
    
    
    mov eax, 1
    int 0x80
