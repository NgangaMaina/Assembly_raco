section .data
    var1 dd 100
    var2 dd 200

section .text
    global _start

_start:
    
    mov eax, [var1]
 
    mov ebx, [var2]
    
    mov [var2], eax
    
    mov [var1], ebx
    
     mov ebx, [var1]
   
    mov eax, 1
    int 0x80
