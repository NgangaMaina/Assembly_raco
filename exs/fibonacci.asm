section .text
    global _start

fibonacci:
    push ebx
    
    cmp ecx, 1
    je .return_zero
    cmp ecx, 2
    je .return_one
    
    mov eax, 0
    mov ebx, 1
    sub ecx, 2
    
.loop:
    mov edx, eax
    add edx, ebx
    mov eax, ebx
    mov ebx, edx
    loop .loop
    
    mov eax, ebx
    pop ebx
    ret
    
.return_zero:
    mov eax, 0
    pop ebx
    ret
    
.return_one:
    mov eax, 1
    pop ebx
    ret

_start:
    
    mov ecx, 1
    call fibonacci
    
    mov ecx, 2
    call fibonacci
    
    mov ecx, 7
    call fibonacci
     
    mov ecx, 10
    call fibonacci
    
    mov ebx, eax
    mov eax, 1
    int 0x80
