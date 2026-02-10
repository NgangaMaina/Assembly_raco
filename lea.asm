section .data
   
    my_array dd 10, 20, 30, 40, 50, 60, 70, 80

section .text
    global _start

_start:
    
    mov ebx, my_array
    
    lea eax, [ebx + 5*4]  
    

    lea ecx, [ebx + 40]   
     
   
    mov eax, 1
    int 0x80
