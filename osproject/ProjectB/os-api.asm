;kernel.asm
;Michael Black, 2007

;kernel.asm contains assembly functions that you can use in your kernel

	.global _syscall_printString
	.global _syscall_readString
	.global _syscall_readSector

;void syscall_printString(char *str)
_syscall_printString:
	push bp
	mov bp, sp
	mov ax, #0
	mov bx, [bp+4]
	int #0x21
	pop bp
	ret

;void syscall_readString(char *str)
_syscall_readString:
	push bp
	mov bp, sp
	mov ax, #1
	mov bx, [bp+4]
	int #0x21
	pop bp
	ret

;void syscall_readSector(char *buffer, int sector)
_syscall_readSector:
	push bp
	mov bp, sp
	mov ax, #2
	mov bx, [bp+4]
	mov cx, [bp+6]
	int #0x21
	pop bp
	ret
