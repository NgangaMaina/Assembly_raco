section .bss
	BUFFLEN equ 128
	Buff resb BUFFLEN

section .data

section .text

global _start

_start:
	mov rbp, rsp

Read:
	mov rax, 0	;Sys read
	mov rdi, 0	;File descriptor
	mov rsi, Buff	;Address of buffer to read to
	mov rdx, BUFFLEN
	syscall
	mov r12, rax
	cmp rax, 0
	je Done

	mov rbx, rax
	mov r13, Buff
	dec r13

Scan:
	cmp byte [r13+rbx], 61h	;Test input data against lowercase 'a'
	jb .Next		;If below 'a' in ASCII chart, not lowercase
	cmp byte [r13+rbx], 7Ah	;Test against lowercase 'z'
	ja .Next		;If above 'z', not lowercase

	sub byte [r13+rbx], 20h	;Subtracted from lowercase to give uppercase
.Next:
	dec rbx
	cmp rbx, 0
	jnz Scan

Write:
	mov rax, 1
	mov rdi, 1
	mov rsi, Buff
	mov rdx, r12
	syscall
	jmp Read
Done:
	mov rax, 60
	xor rdi, rdi
	syscall


