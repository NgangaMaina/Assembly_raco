section .text
    global _start

power:
    push ebp
    mov ebp, esp
    push ebx
    push ecx
    
    mov eax, [ebp+8]     ; base
    mov ecx, [ebp+12]    ; exponent
    
    cmp ecx, 0
    je .zero_exp
    
    mov ebx, eax
    dec ecx
    
.loop:
    cmp ecx, 0
    je .done
    
    push ecx
    push eax
    mov ecx, ebx
    xor eax, eax
.multiply:
    add eax, [esp]
    loop .multiply
    add esp, 4
    pop ecx
    
    dec ecx
    jmp .loop
    
.zero_exp:
    mov eax, 1
    
.done:
    pop ecx
    pop ebx
    mov esp, ebp
    pop ebp
    ret 8

_start:
   
    push 4
    push 3
    call power
    
    push 5
    push 2
    call power
    
    push 0
    push 5
    call power
    
    push 2
    push 10
    call power
    
    mov ebx, eax
    mov eax, 1
    int 0x80
