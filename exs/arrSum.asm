section .data
    array dd 10, 25, 30, 5, 15
    array_len equ 5
    
    msg_sum db "Sum of array elements: ", 0
    msg_len equ $ - msg_sum
    newline db 10
    
section .bss
    result resb 10

section .text
    global _start

_start:
    xor eax, eax
    mov ecx, array_len
    mov esi, array
    
.loop:
    add eax, [esi]
    add esi, 4
    loop .loop
    
    push eax
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_sum
    mov edx, msg_len
    int 0x80
    
    pop eax
    call print_number
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    mov eax, 1
    xor ebx, ebx
    int 0x80

print_number:
    push eax
    push ebx
    push ecx
    push edx
    
    mov ecx, result
    add ecx, 9
    mov byte [ecx], 0
    mov ebx, 10
    
.convert_loop:
    xor edx, edx
    div ebx
    add dl, '0'
    dec ecx
    mov [ecx], dl
    test eax, eax
    jnz .convert_loop
    
    mov eax, result
    add eax, 9
    sub eax, ecx
    mov edx, eax
    
    mov eax, 4
    mov ebx, 1
    int 0x80
    
    pop edx
    pop ecx
    pop ebx
    pop eax
    ret
