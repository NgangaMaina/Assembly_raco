section .bss
    result resd 1  

section .text
    global _start

_start:

    mov eax, 80
    

    sub eax, 35
    

    mov [result], eax
    
  
    mov ebx, [result]
    
   
    mov eax, 1
    int 0x80
