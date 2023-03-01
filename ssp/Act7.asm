org 100h
jmp inicio
direccion db "C:\EMU8086\MyBuild\practica07", 0
direccion2 db "C:\EMU8086\MyBuild", 0
dirAux db "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 0
dirAux2 db "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 0
archivo db "C:\EMU8086\MyBuild\practica07\munoz.txt", 0


nombre db "Christian Geovany Munoz Rodriguez"
edad db 13, "24 anos"


handler dw ?


inicio:
    mov ah, 39h
    mov dx, offset direccion
    int 21h
    
    mov ah, 3Bh
    mov dx, offset direccion
    int 21h
    
    mov ah, 47h
    mov dl, 0
    mov si, offset dirAux
    int 21h
    
    mov ah, 3ch
    mov cx, 0
    mov dx, offset archivo
    mov ah, 3ch
    int 21h
    mov handler, ax
    
    mov bx, handler
    mov ah, 40h
    mov cx, 26
    mov dx, offset nombre
    int 21h
    
    mov bx, handler
    mov ah, 40h
    mov cx, 8
    mov dx, offset edad
    int 21h
    
    mov ax, 0
    mov ah, 3eh
    int 21h
    
    mov ah, 3bh
    mov dx, offset direccion2
    int 21h
    
    mov ah, 47h
    mov dl, 0
    mov si, offset dirAux2
    int 21h
    ret