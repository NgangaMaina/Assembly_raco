section .text
    global _start

is_even:
    test eax, 1
    jz .even
    mov eax, 0
    ret
.even:
    mov eax, 1
    ret

_start:
   
    mov eax, 4
    call is_even
  
    mov eax, 7
    call is_even
 
    mov eax, 100
    call is_even
    
    mov eax, 15
    call is_even
    
    mov eax, 0
    call is_even
    
    mov ebx, eax
    mov eax, 1
    int 0x80
