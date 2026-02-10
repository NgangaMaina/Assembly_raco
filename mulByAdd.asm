section .data
    num1 dd 5         
    num2 dd 3        

section .text
    global _start

_start:
    
    mov eax, [num1]  
    mov ecx, [num2]   

    
    mov ebx, eax
    xor eax, eax   
multiply_loop:
    add eax, ebx      
    loop 

    
    mov ebx, eax     
    mov eax, 1       
    int 0x80

