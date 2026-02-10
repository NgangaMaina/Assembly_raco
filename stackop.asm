section .text
    global _start

_start:
    ; This is our main function that calls the subroutine.
    ; We want to calculate (10 * 5) + (6 * 3)

    ; Push arguments onto the stack in reverse order (d, c, b, a)
    push 3           ; Argument d = 3
    push 6           ; Argument c = 6
    push 5           ; Argument b = 5
    push 10          ; Argument a = 10

    call calculate_expression

    ; The result (68) is now in EAX.
    ; Clean up the 4 arguments we pushed (4 bytes each = 16 bytes).
    add esp, 16

    ; For this demo, use the result as the exit code.
    mov ebx, eax
    mov eax, 1
    int 0x80

;----------------------------------------------------
; calculate_expression:
;   Calculates (a * b) + (c * d).
;   - Expects four arguments on the stack: a, b, c, d.
;   - Uses one local variable for temporary storage.
;   - Returns the final result in EAX.
;
;   Stack layout inside this function:
;   [ebp + 20] -> Argument d
;   [ebp + 16] -> Argument c
;   [ebp + 12] -> Argument b
;   [ebp + 8]  -> Argument a
;   [ebp + 4]  -> Return Address
;   [ebp]      -> Old EBP
;   [ebp - 4]  -> Local variable (to store a * b) <-- This is our local variable!
;----------------------------------------------------
calculate_expression:
    ; --- Function Prologue ---
    push ebp             ; Save the caller's base pointer
    mov ebp, esp         ; Set up our new stack frame base
    sub esp, 4           ; Allocate 4 bytes on the stack for one local variable

    ; --- Function Body ---
    ; 1. Calculate a * b
    mov eax, [ebp + 8]   ; Get argument 'a'
    mov ebx, [ebp + 12]  ; Get argument 'b'
    mul ebx              ; EAX = a * b (result is in EAX)

    ; 2. Store the intermediate result in our local variable
    mov [ebp - 4], eax   ; Store the result of a*b at [ebp - 4]

    ; 3. Calculate c * d
    mov eax, [ebp + 16]  ; Get argument 'c'
    mov ebx, [ebp + 20]  ; Get argument 'd'
    mul ebx              ; EAX = c * d (this overwrites the previous EAX)

    ; 4. Add the stored result: (c * d) + (a * b)
    add eax, [ebp - 4]   ; EAX = EAX + (value of our local variable)

    ; --- Function Epilogue ---
    mov esp, ebp         ; Deallocate the local variable by resetting the stack pointer
    pop ebp              ; Restore the caller's base pointer
    ret                  ; Return to the caller
