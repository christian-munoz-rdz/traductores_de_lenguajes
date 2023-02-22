.model small
.stack 100h

.data
datos db 80,100,119,135,148,156,160,159,152,142,127,109,90,70,51,33,18,8,1,0,4,12,25,41,60,80,100,119,135,148,156,160,159,152,142,127,109,90,70

.code
start:
    mov ax, @data
    mov ds, ax ; inicializa el segmento de datos

    ; Modo de direccionamiento de registro
    mov si, offset datos
    mov al, [si] 

    ; Modo de direccionamiento inmediato
    mov al, datos[3]

    ; Modo de direccionamiento directo
    mov al, datos+10 

    ; Modo de direccionamiento de registro indirecto
    mov si, offset datos
    mov bx, 6
    mov al, [si+bx] 

    ; Modo de direccionamiento de base más indice
    mov si, offset datos
    mov bx, 20
    mov al, [si+bx+3] 

    ; Modo de direccionamiento de registro relativo
    mov si, offset datos
    mov cx, 4
    mov al, [si+cx-1]

    ; Modo de direccionamiento de base relativa mas indice
    mov si, offset datos
    mov bx, 14
    mov cx, 6
    mov al, [si + bx + cx - 6]

    ; Modo de direccionamiento de indice escalado
    mov si, offset datos
    mov al, [si + 1 + 4*3]

    ; Finalizacion del programa
    mov ah, 4ch
    int 21h
end