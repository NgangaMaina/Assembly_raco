section .text
    global _start

_start:
    ; This is our "main" function
    mov eax, 10        ; Argument 1: place 10 in EAX
    mov ebx, 5         ; Argument 2: place 5 in EBX
    call add_two_nums_reg ; Call our addition procedure

    ; The result is now in EAX. For this demo, we'll just exit.
    ; In a real program, you would use the result here.
    mov ebx, eax       ; Move the result to EBX for the exit code
    mov eax, 1         ; System call for exit
    int 0x80           ; Kernel interrupt

;-----------------------------------------------------
; add_two_nums_reg:
;   Adds two numbers passed in registers.
;   - Expects the first number in EAX
;   - Expects the second number in EBX.
;   - Returns the sum in EAX.
;-----------------------------------------------------
add_two_nums_reg:
    add eax, ebx       ; Add EBX to EAX, store result in EAX
    ret                ; Return to the calle
