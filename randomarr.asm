;Program to fill an array with N random integers in range [j, k]

section .data
    msg_array1 db "first array(N = 5, range[10, 50]):", 10, 0
     msg_array2 db 10, "Second array (N=8, range [100, 200]):", 10, 0
     msg_element db " Elem,ent %d: %d", 10, 0
     newline db 10, 0


section .bss
    ;Test Arrays
    array1 resd 5
    array2 resd 8


section .text
    global main     ;Linker's entry point
    extern printf   ;external C printing function
    extern time     ;external C function to get current time
    extern srand    ;External C function to seed random number generator
    extern rand     ;External C function to generate random numbers


main:
    ;Stack Frame setup
    push rbp        ;Save base pointer (Caller's stack frame)
    mov rbp, rsp   ;set up our sttack frame base
    
    ;call time to get the current time as seed
    xor rdi, rdi
    call time
    mov rdi, rax
    call srand

    ;Print first message
    lea rdi, [msg_array1]   ;Load Effective Address of message into RDI
    xor rax, rax
    call printf

    ;Call proc for first array
    lea rdi, [array1]
    mov rsi, 5
    mov rdx, 10
    mov rcx, 50
    call fill_random_array

    ;Print first Array
    lea rdi, [array1]
    mov rsi, 5
    call print_array

    ;Print second message
    lea rdi, [msg_array2]
    xor rax, rax
    call printf

    ;Proc for second array
    lea rdi, [array2]
    mov rsi, 8
    mov rdx, 100
    mov rcx, 200
    call fill_random_array

    ;Print 2nd array
    lea rdi, [array2]
    mov rsi, 8
    call print_array

    ;Exit program
    xor rax, rax
    leave       ;Restore the stack frame(equivalent to pop rbp)
    ret         


;fill_random_array to fill array with N random integers in the range
fill_random_array:
    push rbp
    mov rbp, rsp

    ;Save callee-saved registers(registers we'll use that must be preserved)
    push rbx    ;RBX for array pointer
    push r12    ;counter
    push r13    ;j(min)
    push r14    ;k(max)
    push r15    ;range calculation

    ;Save parameters to callee-saved registers
    mov rbx, rdi
    mov r12, rsi
    mov r13, rdx
    mov r14, rcx

    ;Calculate range(range = k - j + 1) as the number of possible values
    mov r15, r14
    sub r15, r13
    inc r15

    ;Initialize loop counter
    xor r8, r8

.loop:
    cmp r8, r12     ;Compare index with N
    jge .done       ; if index >= N, exit loop

    ;Generate random number
    push r8     ;Save the loop counter (Callee-saved register)
    call rand   ;Get random number in rax
    pop r8      ;Restore the loop counter

    xor rdx, rdx
    div r15

    add rdx, r13

    mov [rbx + r8*4], edx

    inc r8      ;Increment the counter
    jmp .loop


.done:
    ;Restore registers and cleanup
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx

    leave
    ret


;Print array contents (RDI - Array pointer, RSI - No. of elements)
print_array:
    push rbp
    mov rbp, rsp
    push rbx
    push r12
    push r13

    mov rbx, rdi
    mov r12, rsi
    xor r13, r13    ;index


.print_loop:
    cmp r13, r12
    jge .print_done

    ;printf
    lea rdi, [msg_element]
    mov rsi, r13
    mov edx, [rbx + r13*4]
    xor rax, rax

    push r13
    call printf
    pop r13

    inc r13
    jmp .print_loop


.print_done:
    pop r13
    pop r12
    pop rbx
    leave
    ret
    


