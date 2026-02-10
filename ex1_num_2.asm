section .data
    ; --- Define your variables here ---
    value_A dd 50      ; 1. Define value_A with the value 50.
    value_B dd 10      ; 1. Define value_B with the value 10.

section .text
global _start

_start:
    ; --- Write your code here ---
    mov eax, [value_A] ; 2. Load value_A (50) from memory into EAX.
    mov ecx, [value_B] ; 3. Load value_B (10) from memory into ECX.
    sub eax, ecx       ; 4. Subtract ECX from EAX (50 - 10 = 40). EAX is now 40.
    add eax, 20        ; 5. Add the immediate value 20 to EAX (40 + 20 = 60). EAX is now 60.
    mov ebx, eax       ; 6. Move the final result from EAX to EBX.

    ; --- Standard program exit ---
    mov eax, 1
    int 0x80

