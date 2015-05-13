;kernel.asm
;Michael Black, 2007

;kernel.asm contains assembly functions that you can use in your kernel

	.global _putInMemory
	.global _putChar
	.global _readChar
	.global _readSector

;void readSector();
_readSector:

	push bp
	mov bp,sp
	push ds

	mov ax, [bp+6]
	mov cl, #36
	div cl
	mov [bp+8], #0

	;relative
	mov dl, #0     
	mov ax, [bp+6]
	mov cx, #18
	div cx
	inc dl
	mov [bp+10],#13

	mov dl, #0 
	mov ax, [bp+6]
	mov cx, #18
	div cx
	and al, #1
	xor dx, dx
	mov dl, al
	mov [bp+12],#1

	mov ah, #2
	mov al, #1
	mov bx, [bp+4]
	mov ch, [bp+8]
	mov cl, [bp+10]
	mov dh, [bp+12]
	mov dl, #0
	
	int 0x13

	pop ds
	pop bp
	ret	

;void putChar(char c);
_putChar:
	push bp
	mov bp,sp
	push ds
	mov al, [bp+4]
	mov ah, #0x0e
	int 0x10
;IF backspace
	cmp al, #0x8
	jne return;
	mov al, #0x20
	mov ah, #0x0e
	int 0x10
	mov al, #0x8
	mov ah, #0x0e
	int 0x10
return:
	pop ds
	pop bp
	ret

;void readChar(char c);
_readChar:
	push bp
	mov bp,sp
	push ds
	mov ah, #0
	int 0x16
	pop ds
	pop bp
	ret
	

;void putInMemory (int segment, int address, char character)
_putInMemory:
	push bp
	mov bp,sp
	push ds
	mov ax,[bp+4]
	mov si,[bp+6]
	mov cl,[bp+8]
	mov ds,ax
	mov [si],cl
	pop ds
	pop bp
	ret


