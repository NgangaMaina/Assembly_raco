section .text
    global _start

factorial:
    push ebx
    
    cmp ecx, 0
    je .zero_case
    
    mov eax, 1
    mov ebx, 1
    
.loop:
    cmp ebx, ecx
    jg .done
    
    push ecx
    push eax
    mov ecx, ebx
    xor eax, eax
.multiply:
    add eax, [esp]
    loop .multiply
    add esp, 4
    pop ecx
    
    inc ebx
    jmp .loop
    
.zero_case:
    mov eax, 1
    
.done:
    pop ebx
    ret

_start:
    ; Test 1: 0! = 1
    mov ecx, 0
    call factorial
    
    mov ecx, 5
    call factorial
   
    mov ecx, 4
    call factorial
    
    mov ecx, 6
    call factorial
    
    mov ebx, eax
    mov eax, 1
    int 0x80
