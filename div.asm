section .data
    dividend dd 95

section .text
    global _start

_start:
    mov eax, [dividend]    
    mov ecx, 7            
    
    
    xor edx, edx           
    
    div ecx                
                      
    
    mov ebx, eax       
    
 
    mov eax, 1     
    int 0x80              
