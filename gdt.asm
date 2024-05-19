
gdt_nulldesc:
    dd 0
    dd 0

gdt_codedesc:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10011010b
    db 11001111b
    db 0x00

gdt_datadesc:
    dw 0xFFFF
    dw 0x0000
    db 0x00
    db 10010010b
    db 11001111b
    db 0x00

gdt_end:

gdt_descriptor:
    gdt_size:
        dq gdt_end - gdt_nulldesc - 1
        dd gdt_nulldesc

CODE_SEG equ gdt_codedesc - gdt_nulldesc
DATA_SEG equ gdt_datadesc - gdt_nulldesc
    