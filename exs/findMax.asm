section .text
    global _start

find_max:
    cmp eax, ebx
    jge .done
    mov eax, ebx
.done:
    ret

_start:
   
    mov eax, 15
    mov ebx, 20
    call find_max
    
    mov eax, 50
    mov ebx, 30
    call find_max
    
    mov eax, 10
    mov ebx, 10
    call find_max
    
    mov ebx, eax
    mov eax, 1
    int 0x80
