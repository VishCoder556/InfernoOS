[org 0x8000]

start:
    mov ax, 0x4F02   ; Set video mode to VESA mode 0x101
    mov bx, 0x101    ; Mode number
    int 0x10

    mov ax, 0xA000   ; Set ES to VGA segment
    mov es, ax

    ; Draw a single pixel at (100, 50) with color 4 (red)
    mov di, 100 * 480 + 50 * 2   ; Calculate offset (640 pixels per row, 2 pixels per byte)
    mov byte [es:di], 4     ; Color (4 = red)

    cli              ; Halt the CPU
    hlt




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














org 0x8000
bits 16







jmp start
    

start:
    mov ax, 0x4F02
    mov bx, 0x101
    int 0x10

    ; menu bar
    mov ax, 0xA000
    mov es, ax
    mov di, 0
    mov al, 0x0F
    mov dx, 640
    mov ax, 0x0A
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    push di
    ; window
    mov ax, 0xA000
    mov es, ax
    mov dx, 300
    mov ax, 0x0F
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    call draw_row
    pop bx
    mov si, char_x
    call draw_font
    mov si, char_dash
    add bx, 10
    call draw_font
    mov si, char_box
    add bx, 10
    call draw_font



    cli
    hlt


draw_row:
    ; expects es, di,  ax, dx
    mov cx, dx
    rep stosb
    mov bx, 640
    sub bx, dx
    add di, bx
    ret


draw_font:
    ; takes in bx
    mov cx, [si]
    inc cx
    add si, 2
    loop font_loop
font_loop:
    mov ax, 0xA000
    mov es, ax
    mov di, [si]
    add di, bx
    mov al, 1
    stosb
    add si, 2
    loop font_loop
    ret
     ; load si into al


char_x: dw 14, 641, 1282, 1923, 2564, 3205, 3846, 4487, 648, 1287, 1926, 2565, 3204, 3843, 4482
char_dash: dw 5, 2561, 2562, 2563, 2564, 2565
char_box: dw 24, 641, 642, 643, 644, 645, 646, 647, 1287, 1927, 2567, 3207, 3847, 3846, 3845, 3844, 3843, 3842, 3841, 3201, 2561, 1921, 1281, 641


; UTILS



print_string:
; print_string -- accepts si as the string to print
loop:
    mov ah, 0x0E
    mov al, [si]
    cmp al, 0
    je done
    inc si
    int 0x10
    jmp loop
done:
    ret