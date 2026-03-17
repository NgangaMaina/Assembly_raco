global _start

section .data
minus1: db '-1'

section .bss
input:  resb 1000002
output: resb 1000001
freq:   resd 26

section .text
_start:
    ;Read input
    mov rax, 0      ;sys_read
    mov rdi, 0      ;stdin
    lea rsi, [input]
    mov rdx, 1000001
    syscall

    mov rbx, rax
    test rax, rax
    jz print_minus1

    dec rax
    cmp byte [input + rax], 10
    jne no_newline
    dec rbx

no_newline:
    mov r12, rbx
    
    ;Count frequencies
    mov rcx, rbx
    lea rsi, [input]

count_loop:
    test rcx, rcx
    jz count_done
    movzx rax, byte [rsi]
    sub rax, 'A'
    inc dword [freq + rax*4]
    inc rsi
    dec rcx
    jmp count_loop

count_done:
    ;Build output
    lea rdi, [output]
    mov r9, 0

build_loop:
    test r12, r12
    jz build_done

    xor r13, r13

try_candidate:
    cmp r13, 26
    je print_minus1

    mov eax, dword [freq + r13*4]
    test eax, eax
    jz next_candidate

    mov r14, r13
    add r14, 'A'
    cmp r14b, r9b
    je next_candidate

    dec dword [freq + r13*4]

    xor r15d, r15d
    xor rcx, rcx

max_loop:
    cmp rcx, 26
    je max_done
    mov edx, dword [freq + rcx*4]
    cmp edx, r15d
    cmovg r15d, edx
    inc rcx
    jmp max_loop

max_done:
    mov eax, r12d
    shr eax, 1
    cmp r15d, eax
    jg restore

    mov byte [rdi], r14b
    inc rdi
    mov r9, r14
    dec r12
    jmp build_loop

restore:
    inc dword [freq + r13*4]

next_candidate:
    inc r13
    jmp try_candidate

build_done:
    ;Write output
    mov rax, 1
    mov rdi, 1
    lea rsi, [output]
    mov rdx, rbx
    syscall
    jmp exit_program

print_minus1:
    mov rax, 1
    mov rdi, 1
    lea rsi, [minus1]
    mov rdx, 2
    syscall

exit_program:
    mov rax, 60
    xor rdi, rdi
    syscall


