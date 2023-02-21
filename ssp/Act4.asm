; Ejemplo de uso de diferentes modos de direccionamiento para acceder a elementos de un arreglo

.model small
.stack 100h

.data
datos db 40,44,48,52,56,60,64,67,70,72,75,77,78,79,80,80,80,79,78,77,75,72,70,67,64,60,56,52,48,44,40,36,32,28,24,20,16,13,10,8,5,3,2,1,0,0,0,1,2,3,5,8,10,13,16,20,24,28,32,36,40

.code
start:
    mov ax, @data
    mov ds, ax ; inicializa el segmento de datos

    ; Modo de direccionamiento de registro
    mov si, offset datos
    mov al, [si] ; carga el primer elemento del arreglo (40) en AL

    ; Modo de direccionamiento inmediato
    mov al, datos[3] ; carga el cuarto elemento del arreglo (52) en AL

    ; Modo de direccionamiento directo
    mov al, datos+10 ; carga el undécimo elemento del arreglo (75) en AL

    ; Modo de direccionamiento de registro indirecto
    mov si, offset datos
    mov bx, 6
    mov al, [si+bx] ; carga el séptimo elemento del arreglo (64) en AL

    ; Modo de direccionamiento de base más índice
    mov si, offset datos
    mov bx, 20
    mov al, [si+bx+3] ; carga el elemento del arreglo en el índice 23 (78) en AL

    ; Modo de direccionamiento de registro relativo
    mov si, offset datos
    mov cx, 4
    mov al, [si+cx-1] ; carga el cuarto elemento del arreglo (52) en AL

    ; Modo de direccionamiento de base relativa más índice
    mov si, offset datos
    mov bx, 14
    mov cx, 6
    mov al, [si + bx + cx - 6] ; carga el elemento del arreglo en el índice 20 (77) en AL

    ; Modo de direccionamiento de índice escalado
    mov si, offset datos
    mov al, [si + 1 + 4*3] ; carga el elemento en la posición 13 del arreglo (77) en AL

    ; Finalización del programa
    mov ah, 4ch
    int 21h
end