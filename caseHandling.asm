section .bss
	Buff resb 1

section .data

section .text

global _start

_start:
	mov rbp, rsp

Read:
	mov rax, 0	;Sys read
	mov rdi, 0	;File descriptor
	mov rsi, Buff	;Address of buffer to read to
	mov rdx, 1
	syscall

	cmp rax, 0
	je Exit

	cmp byte [Buff], 61h	;Test input data against lowercase 'a'
	jb Write		;If below 'a' in ASCII chart, not lowercase
	cmp byte [Buff], 7Ah	;Test against lowercase 'z'
	ja Write		;If above 'z', not lowercase

	sub byte [Buff], 20h	;Subtracted from lowercase to give uppercase

Write:
	mov rax, 1
	mov rdi, 1
	mov rsi, Buff
	mov rdx, 1
	syscall
	jmp Read
Exit:
	mov rax, 60
	xor rdi, rdi
	syscall


