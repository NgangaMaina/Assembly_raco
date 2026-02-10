section .data
    msg1 db 'Hi!', 0xA
    len1 equ $ - msg1

    msg2 db 'How are you!', 0xA
    len2 equ $ - msg2


%macro print 2
    mov eax, 4       
    mov ebx, 1       
    mov ecx, %1           
    mov edx, %2         
    int 0x80
%endmacro

section .text
global _start
_start:
    print msg1, len1    
    print msg2, len2    

  
    mov eax, 1
    mov ebx, 0
    int 0x80
