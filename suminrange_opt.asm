section .data
    array    dd 10, -5, 3, 7, 2, 8, -1, 4
    newline  db 10

section .bss
    buffer   resb 24    ; Increased for safety (sign + 20 digits + null)

section .text
    global _start

; ---------------------------------------------------------------------------
; SumRange: Optimized summation using pointer arithmetic
; Inputs:  RDI = array base, RDX = start index, RCX = end index
; Returns: RAX = sum
; ---------------------------------------------------------------------------
SumRange:
    lea rsi, [rdi + rdx*4]   ; RSI = start pointer
    lea rdx, [rdi + rcx*4]   ; RDX = end pointer
    xor rax, rax             ; RAX = accumulator

    cmp rsi, rdx
    jg .done

.loop:
    movsxd r8, dword [rsi]   ; Sign-extend 32-bit to 64-bit
    add rax, r8              ; Accumulate in 64-bit register
    add rsi, 4               ; Increment pointer
    cmp rsi, rdx
    jle .loop

.done:
    ret

; ---------------------------------------------------------------------------
; PrintInt: Converts RAX to string (handles negatives) and prints to stdout
; ---------------------------------------------------------------------------
PrintInt:
    mov r8, buffer + 23      ; Start from end of buffer
    mov byte [r8], 0         ; Null terminator
    
    mov r9, rax              ; Copy for sign check
    test rax, rax
    jns .positive
    neg rax                  ; Make positive for conversion

.positive:
    mov rcx, 10
.convert:
    dec r8
    xor rdx, rdx
    div rcx                  ; Divide RAX by 10
    add dl, '0'
    mov [r8], dl
    test rax, rax
    jnz .convert

    test r9, r9
    jns .print
    dec r8
    mov byte [r8], '-'       ; Add negative sign if necessary

.print:
    ; Calculate length
    mov rsi, r8              ; RSI = string start
    mov rdx, buffer + 23
    sub rdx, rsi             ; RDX = length

    mov rax, 1               ; sys_write
    mov rdi, 1               ; stdout
    syscall
    ret

_start:
    ; --- First Call (Index 1 to 4) ---
    mov rdi, array
    mov rdx, 1
    mov rcx, 4
    call SumRange
    call PrintInt

    ; Print Newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; --- Second Call (Index 2 to 6) ---
    mov rdi, array
    mov rdx, 2
    mov rcx, 6
    call SumRange
    call PrintInt

    ; Print Newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit
    mov rax, 60
    xor rdi, rdi
    syscall
