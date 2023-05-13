.model small
.stack 100h

.data
    x1 dw 10  ; Punto de inicio (x1, y1)
    y1 dw 10
    x2 dw 30  ; Punto final (x2, y2)
    y2 dw 20
    
.code
    mov ax, @data
    mov ds, ax
    
    ; Inicializar el modo de vídeo
    mov ax, 13h
    int 10h
    
    ; Dibujar la línea
    mov ax, x1
    mov bx, y1
    mov cx, x2
    mov dx, y2
    call Bresenham
    
    ; Salir del programa
    mov ax, 4c00h
    int 21h
    
Bresenham proc
    push ax
    push bx
    push cx
    push dx
    
    mov ax, 0A000h   ; Segmento de video en modo gráfico 13h
    mov es, ax
    
    mov ax, cx
    sub ax, bx       ; dx = x2 - x1
    mov dx, ax
    jns @skip1       ; Saltar si dx >= 0
    
    neg dx           ; dx = -dx
    neg ax           ; Invertir x1
    
@skip1:
    mov bx, dx       ; bx = |dx|
    
    mov ax, dx
    mov cx, ax       ; cx = |dx|
    shl cx, 1        ; cx = 2 * |dx|
    shl ax, 2        ; ax = 4 * |dx|
    add ax, cx       ; ax = 5 * |dx|
    
    mov cx, ax       ; cx = 5 * |dx|
    shr cx, 1        ; cx = (5 * |dx|) / 2
    mov dx, 0        ; dy = 0
    
    mov ax, x1
    mov bx, y1
    mov di, bx       ; di = y1
    
    mov ax, x2
    cmp ax, x1
    jl @skip2        ; Saltar si x2 < x1
    
    mov ax, 1        ; Incremento positivo para x
    mov si, x2       ; si = x2
    
    jmp @skip3
    
@skip2:
    mov dx, ax
    sub ax, y2       ; dx = y1 - y2
    jns @skip3       ; Saltar si dx >= 0
    
    neg dx           ; dx = -dx
    neg ax           ; Invertir y1
    
@skip3:
    mov bx, dx       ; bx = |dx|
    
    mov ax, dx
    mov cx, ax       ; cx = |dx|
    shl cx, 1        ; cx = 2 * |dx|
    shl ax, 2        ; ax = 4 * |dx|
    add ax, cx       ; ax = 5 * |dx|
    
    mov cx, ax       ; cx = 5 * |dx|
    shr cx, 1        ; cx = (5 * |dx|) / 2
    mov dx, 0        ; dy
    mov ax, y1
    
@loop:
    push ax          ; Guardar el valor actual de y
    
    mov ax, bx
    cmp ax, cx
    jge @skip4      ; Saltar si bx >= cx
    
    mov ax, 1       ; Incremento positivo para x
    
@skip4:
    mov dx, ax
    sub ax, y2       ; dx = y1 - y2
    jns @skip5       ; Saltar si dx >= 0
    
    neg dx           ; dx = -dx
    neg ax           ; Invertir y1
    
@skip5:
    mov bx, dx       ; bx = |dx|
    
    mov ax, dx
    mov cx, ax       ; cx = |dx|
    shl cx, 1        ; cx = 2 * |dx|
    shl ax, 2        ; ax = 4 * |dx|
    add ax, cx       ; ax = 5 * |dx|
    
    mov cx, ax       ; cx = 5 * |dx|
    shr cx, 1        ; cx = (5 * |dx|) / 2
    mov dx, 0        ; dy = 0
    
    mov ax, y1
    cmp ax, y2
    jge @skip6       ; Saltar si y1 >= y2
    
    mov ax, 1        ; Incremento positivo para y
    
@skip6:
    add di, ax       ; Incrementar di (posición de y)
    sub cx, bx       ; cx = cx - bx
    
    jnz @skip7       ; Saltar si cx != 0
    
    add ax, dx       ; Incrementar y (dy = dy + 1)
    mov cx, ax       ; cx = dy
    
@skip7:
    mov ax, x1
    mov bx, x2
    cmp ax, bx
    je @skip8        ; Saltar si x1 == x2
    
    mov ax, x1
    mov bx, 320      ; Ancho de la pantalla
    
    mul bx           ; ax = x1 * 320
    
    add ax, di       ; ax = x1 * 320 + di
    
    mov bx, ax       ; bx = dirección de memoria
    
    mov word ptr es:[bx], 15h  ; Dibujar el píxel
    
    mov ax, 1        ; Incremento positivo para x
    add x1, ax
    jmp @skip7
    
@skip8:
    pop dx
    pop cx
    pop bx
    pop ax
    
    ret
Bresenham endp

end
