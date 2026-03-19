%define SYS_READ    0
%define SYS_WRITE   1
%define SYS_EXIT   60
%define OUTBUF_SIZE (1000 * 5 + 2)

section .bss
    n:      resq 1
    dist:   resw 1001*1001
    queue:  resd 1001*1001
    inbuf:  resb 16
    outbuf: resb OUTBUF_SIZE

section .data
    deltas: db -2,-1, -2,1, -1,-2, -1,2, 1,-2, 1,2, 2,-1, 2,1

section .text
global _start

_start:
    mov  rax, SYS_READ
    xor  rdi, rdi
    lea  rsi, [inbuf]
    mov  rdx, 16
    syscall

    lea  rsi, [inbuf]
    xor  rbx, rbx
.parse:
    movzx eax, byte [rsi]
    inc   rsi
    sub   al, '0'
    cmp   al, 9
    ja    .parse_done
    imul  rbx, rbx, 10
    add   rbx, rax
    jmp   .parse
.parse_done:
    mov  [n], rbx

    lea  rdi, [dist]
    mov  rcx, [n]
    imul rcx, rcx
    mov  ax, 0xFFFF
    rep  stosw

    mov  word [dist], 0
    mov  dword [queue], 0
    xor  r8, r8
    mov  r9, 1

.bfs_loop:
    cmp  r8, r9
    jge  .bfs_done

    mov  ebx, dword [queue + r8*4]
    inc  r8

    mov  rax, rbx
    xor  rdx, rdx
    div  qword [n]
    mov  r10, rax
    mov  r11, rdx

    movzx r12, word [dist + rbx*2]
    lea   rsi, [deltas]
    mov   r13, 8

.move_loop:
    movsx rax, byte [rsi]
    movsx rcx, byte [rsi+1]
    add   rsi, 2

    add   rax, r10
    add   rcx, r11

    test  rax, rax
    js    .next_move
    cmp   rax, [n]
    jge   .next_move
    test  rcx, rcx
    js    .next_move
    cmp   rcx, [n]
    jge   .next_move

    mov   rbx, rax
    imul  rbx, [n]
    add   rbx, rcx

    cmp   word [dist + rbx*2], 0xFFFF
    jne   .next_move

    lea   rdx, [r12 + 1]
    mov   word  [dist + rbx*2], dx
    mov   dword [queue + r9*4], ebx
    inc   r9

.next_move:
    dec   r13
    jnz   .move_loop
    jmp   .bfs_loop

.bfs_done:
    xor  r14, r14

.print_rows:
    cmp  r14, [n]
    jge  .exit

    lea  rdi, [outbuf]
    xor  r15, r15

.print_cols:
    cmp  r15, [n]
    jge  .print_line

    mov  rax, r14
    imul rax, [n]
    add  rax, r15
    movzx rax, word [dist + rax*2]

    mov  rbx, 10
    mov  rcx, rdi
.itoa:
    xor  rdx, rdx
    div  rbx
    add  dl, '0'
    mov  byte [rdi], dl
    inc  rdi
    test rax, rax
    jnz  .itoa

    mov  rsi, rcx
    lea  rdx, [rdi - 1]
.rev:
    cmp  rsi, rdx
    jge  .rev_done
    mov  al, [rsi]
    mov  ah, [rdx]
    mov  [rsi], ah
    mov  [rdx], al
    inc  rsi
    dec  rdx
    jmp  .rev
.rev_done:
    mov  byte [rdi], ' '
    inc  rdi
    inc  r15
    jmp  .print_cols

.print_line:
    dec  rdi
    mov  byte [rdi], 10
    inc  rdi

    lea  rsi, [outbuf]
    mov  rdx, rdi
    sub  rdx, rsi

    mov  rax, SYS_WRITE
    mov  rdi, 1
    syscall

    inc  r14
    jmp  .print_rows

.exit:
    mov  rax, SYS_EXIT
    xor  rdi, rdi
    syscall
    



