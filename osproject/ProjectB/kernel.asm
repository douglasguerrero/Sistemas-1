;kernel.asm
;Michael Black, 2007

;kernel.asm contains assembly functions that you can use in your kernel

	.global _putInMemory
	.global _putChar
	.global _readChar
	.global _readSector
	.global _makeInterrupt21
	.global _interrupt21
	.extern _handleInterrupt21
	.global _callPrintString
	.global _callReadString
	.global _callReadSector
	.global _loadProgram
	.extern _printString
	.extern _readString

;void readSector();
_readSector:

	push bp
	mov bp,sp
	sub sp, #6

	mov ax, [bp+6]
	mov cl, #36
	div cl
	xor ah, ah
	mov [bp-2], ax

	;relative    
	mov ax, [bp+6]
	mov cl, #18
	div cl
	inc ah
	mov al, ah
	xor ah, ah
	mov [bp-4], ax

	mov ax, [bp+6]
	mov cl, #18
	div cl
	and al, #1
	xor ah, ah
	mov [bp-6],ax

	mov ah, #2
	mov al, #1
	mov bx, [bp+4]
	mov ch, [bp-2]
	mov cl, [bp-4]
	mov dh, [bp-6]
	mov dl, #0
	
	int 0x13
	
	add sp, #6
	pop bp
	ret

;void putChar(char c);
_putChar:
	push bp
	mov bp,sp
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

_makeInterrupt21:
	;get the address of the service routine
	mov dx,#_interrupt21ServiceRoutine
	push ds
	mov ax, #0	;interrupts are in lowest memory
	mov ds,ax
	mov si,#0x84	;interrupt 0x21 vector (21 * 4 = 84)
	mov ax,cs	;have interrupt go to the current segment
	mov [si+2],ax
	mov [si],dx	;set up our vector
	pop ds
	ret

_interrupt21:
	push bp
	mov bp,sp
	mov ax, [bp+4]
	mov bx, [bp+6]
	mov cx, [bp+8]
	mov dx, [bp+10]
	int 0x21
	pop bp
	ret

;void handleInterrupt21 (int AX, int BX, int CX, int DX)
_interrupt21ServiceRoutine:
	push dx
	push cx
	push bx
	push ax
	call _handleInterrupt21
	pop ax
	pop bx
	pop cx
	pop dx
	iret

_callPrintString:
	push bx
	call _printString
	add sp, #2
	iret

_callReadString:
	push bx
	call _readString
	add sp, #2
	iret

_callReadSector:
	push cx
	push bx
	call _readSector
	add sp, #4
	iret

;void loadProgram();
_loadProgram:
	mov ax, #0x2000
	mov ds, ax
	mov ss, ax
	mov es, ax
	mov ax, #0xfff0 ;let's have the stack start at 0x2000:fff0
	mov sp, ax
	mov bp, ax  ; Read the program from the floppy
	mov cl, #12 ;cl holds sector number
	mov dh, #0 ;dh holds head number - 0
	mov ch, #0 ;ch holds track number - 0
	mov ah, #2 ;absolute disk read
	mov al, #1 ;read 1 sector
	mov dl, #0 ;read from floppy disk A
	mov bx, #0 ;read into offset 0 (in the segment)
	int #0x13 ;call BIOS disk read function
	jmp #0x2000:#0 ; Switch to program


