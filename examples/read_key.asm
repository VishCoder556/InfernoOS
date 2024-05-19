org 0x8000               ; Set the origin to 0x7C00 (standard address for boot sector)

section .text
_start:
get_key:
    mov ah, 0x00
    int 0x16
    
    mov dl, al

    mov ah, 0x0E
    int 0x10
    jmp get_key