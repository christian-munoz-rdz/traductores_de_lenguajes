.model small
.stack 100
.data


;Valores obtenidos del excel
array DB 40, 44, 48, 52, 56, 60, 64, 67, 70, 72, 75, 77, 78, 79, 80, 80, 80, 79, 78, 77, 75, 72, 70, 67, 64, 60, 56, 52, 48, 44, 40, 36, 32, 28, 24, 20, 16, 13, 10, 8, 5, 3, 2, 1, 0, 0, 0, 1, 2, 3, 5, 8, 10, 13, 16, 20, 24, 28, 32, 36, 40

.code 
JMP start

start:
    MOV AX, @data ;carga la direccion de la seccion de datos en el registro AX
    MOV ds, AX
    MOV AH, 0
    MOV AL, 13h
    INT 10h
    MOV BX, 0h ;Contador
    
    MOV CX, 0  ;Inicializamos
    MOV BX, CX ;Posiciones del contador
    MOV DL, array[BX]
    MOV AL, 15
    MOV AH, 0ch
    INT 10h
    
    jmp seno ;Saltamos a la funcion seno

seno:
    inc CX ;Incrementamos 
    MOV BX, CX
    MOV DL, array[BX] 
    MOV AL, 15
    MOV AH, 0ch 
    INT 10h
    cmp CX, 60 ; comparar con la longitud del array
    jnz seno

fin:
    XOR BX, BX
    MOV AH, 0

ret