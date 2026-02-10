section .data
    num1 dd 12       
    num2 dd 25   

section .text
    global _start

_start:
    mov eax, [num1]   
    mov ebx, [num2]   

    cmp eax, ebx   
    jge eax_is_max    
    mov eax, ebx   
eax_is_max:
   

    mov ebx, eax      
    mov eax, 1     
    int 0x80

