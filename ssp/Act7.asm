org 100h
jmp inicio
direccion db "C:\EMU8086\MyBuild\christian", 0 ;direccion del directorio
direccion2 db "C:\EMU8086\MyBuild", 0 ;direccion del directorio padre
dirAux db "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 0
dirAux2 db "$$$$$$$$$$$$$$$$$$$$$$$$$$$$$", 0
archivo db "C:\EMU8086\MyBuild\christian\munoz.txt", 0 ;direccion del archivo
mensaje db "holacomoestasesperoestesbien" ;cadena de caracteres que se escribira en el archivo
handler dw ? ;manejador del archivo 


inicio:
    mov ah, 39h ;Funcion para establecer el directorio actual
    mov dx, offset direccion
    int 21h
    
    mov ah, 3Bh ;Funcion para crear un directorio (si no existe) o cambiar al directorio especificado
    mov dx, offset direccion
    int 21h
    
    mov ah, 47h ;Funcion para obtener el nombre del directorio actual
    mov dl, 0
    mov si, offset dirAux
    int 21h
    
    mov ah, 3ch ;Funcion para crear un archivo
    mov cx, 0
    mov dx, offset archivo
    mov ah, 3ch
    int 21h
    mov handler, ax ;Guarda el manejador del archivo en la variable "handler"
    
    mov bx, handler ;Coloca el manejador del archivo en BX para usarlo en la funcion de escritura
    mov ah, 40h ; Funcion para escribir en un archivo
    mov cx, 26 ; Longitud del mensaje que se escribir en el archivo
    mov dx, offset mensaje
    int 21h
    
    mov ax, 0 ;Funcion para cerrar el archivo
    mov ah, 3eh
    int 21h
    
    ; Funcion para borrar el archivo
    mov ah, 41h
    mov dx, offset archivo
    int 21h
    
    ; Funcion para salir del directorio actual
    mov ah, 3bh
    mov dx, offset direccion2
    int 21h
    
    ; Funcion para borrar el directorio
    mov ah, 3ah
    mov dx, offset direccion
    int 21h
    
    ; Obtener el directorio actual
    mov ah, 47h
    mov dl, 0
    mov si, offset dirAux2
    int 21h
    
    ret
