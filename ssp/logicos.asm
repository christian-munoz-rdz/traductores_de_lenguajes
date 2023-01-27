org 100h
jmp inicio
var1 dw 45h
var2 dw 57h
var3 db 45h
var4 db 57h

inicio: mov ax,var1
        mov bx,var2
        AND ax,bx
        mov al,var3
        mov bl,var4
        AND al,bl
        
        OR ax,bx
        XOR ax,bx
        NOT ax
        NEG ax