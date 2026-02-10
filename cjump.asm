section .text
global _start
_start:
mov eax, 10
mov ebx, 5
cmp eax, ebx
jle else_block

then_block:
mov ecx, 1
jmp end_if

else_block:
mov ecx, 0

end_if:
 mov eax, 1
 int 0x80
