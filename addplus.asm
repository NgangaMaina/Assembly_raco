; -----------------------------------------------------------------------------
; A simple 32-bit NASM program to calculate 5 + 6 and store the result.
; -----------------------------------------------------------------------------

section .data
    ; This section is for initialized data. We create a memory location
    ; named 'result' to store the answer after the calculation.
    result dd 0     ; dd = Define Doubleword (4 bytes). Initialize it to 0.

section .text
    ; This section contains the executable code.
    global _start   ; Makes the '_start' label visible to the linker.
                    ; The linker needs to know where the program execution begins.

_start:
    ; This is the entry point of our program.

    ; Step 1: Place the first number (5) into a register.
    mov eax, 5      ; 'mov' copies the value 5 into the 32-bit EAX register.
                    ; EAX will act as our accumulator.

    ; Step 2: Add the second number (6) to the value in the register.
    add eax, 6      ; 'add' adds the value 6 to the current value in EAX.
                    ; After this line, EAX will hold the sum (5 + 6 = 11).

    ; Step 3: Store the final result from the register into memory.
    mov [result], eax ; Copy the value FROM the EAX register TO the memory
                      ; location we named 'result'. The brackets [] mean
                      ; "the memory address of".

    ; --- Standard program exit sequence for 32-bit Linux ---
    ; To exit cleanly, we need to tell the operating system (Linux kernel).
    ; This is done using a system call (syscall).

    mov eax, 1      ; Syscall number for 'exit' is 1. We place this number in EAX.
    mov ebx, 0      ; The exit code. 0 means the program ran successfully.
                    ; We place this code in EBX.
    int 0x80        ; 'int 0x80' is the instruction to "interrupt" the CPU and
                    ; ask the kernel to perform the syscall we set up in EAX.
