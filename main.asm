

bits 16

org 0x7c00

start:
    mov dl, 0x80
    mov ah, 0x02
    mov al, 1
    mov bx, 0x8000
    mov ch, 0x00
    mov cl, 0x02
    int 0x13
    jmp 0x8000

times 510-($-$$) db 0
dw 0xaa55 ; Tell the BIOS it can run this disk

