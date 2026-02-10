section .text
global _start

_start:
mov eax, 0
mov ecx, 10

for_loop:
add eax, ecx
cmp ecx, 0
jg for_loop

mov ebx, eax
mov eax, 1
int 0x80
