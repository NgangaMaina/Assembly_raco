Section .text
    global _start
_start:
    push 10
    push 15
    call add_proc_stack
    add esp, 8
    mov ebx, eax
    mov eax, 1
    
    int 0x80


add_proc_stack:
    push ebp
    mov ebp, esp
    mov eax, [ebp + 8]
    mov ebx, [ebp + 12]
    add eax, ebx
    pop ebp
    ret
