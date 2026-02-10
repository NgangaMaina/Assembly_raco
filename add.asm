; add.asm - Adds two numbers and returns the sum as an exit code.
; Written for Linux using NASM (Netwide Assembler)
; Run the following
;   nasm -f elf32 add.asm
;   ld -m elf_i386 -o add add.o
;   ./add
;   echo $?
; one liner: nasm -f elf32 add.asm && ld -m elf_i386 -o add add.o && ./add && echo $?
; Explanations

; nasm -f elf32 add.asm
; nasm: The Netwide Assembler
;   -f elf32: Output format as 32-bit ELF (Executable and Linkable Format) object file
;   add.asm: Your source assembly file
;   Creates add.o object file

; ld -m elf_i386 -o add add.o
;   ld: The GNU linker
;   -m elf_i386: Target 32-bit x86 architecture
;   -o add: Output executable named "add"
;   add.o: Input object file to link

section .text
global _start

_start:
    mov eax, 5      ; Put the number 5 into the eax register
    add eax, 6      ; Add the number 6 to eax (eax now holds 11)

    ; Exit the program, using our result as the exit code
    mov ebx, eax    ; Copy the result (11) from eax to ebx for the exit code
    mov eax, 1      ; Tell Linux we want to exit (1 is the code for exit)
    int 0x80        ; Call Linux to execute the exit command
