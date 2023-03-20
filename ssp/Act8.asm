.model small
.stack 100
.data


;Valores obtenidos del excel
X DB 254, 248, 230, 202, 166, 127, 88, 52, 24, 6, 0, 6, 24, 52, 88, 127, 166, 202, 230, 248, 254, 1
Y DB 127, 166, 202, 230, 248, 254, 248, 230, 202, 166, 127, 88, 52, 24, 6, 0, 6, 24, 52, 88, 127, 1

.code 
JMP start

COLOR EQU 4h ;Definimos el color de los pixeles

start:
    MOV AX, @data ;carga la dirección de la seccion de datos en el registro AX
    MOV ds, AX
    
    MOV AX, 0h
    MOV AL, 12h ;Definimos el tipo de video
    INT 10H
    
    MOV DI, 0 ;inicializa el registro de indice de destino para el primer elemento del arreglo X
    
ciclo: 
    
    MOV CL, X[DI] ;carga la coordenada X actual en el registro CL
    MOV DL, Y[DI] ; carga la coordenada Y actual en el registro DL
    
    MOV AL,COLOR ;Establece el color de pixel actual
    
    MOV AH, 0CH ;Establece el modo de video para escribir un píxel en la pantalla
    INT 10H ;llama a la interrupcion de video BIOS para escribir el pixel en la pantalla.
    ADD DI,1 ;Incrementa el indice del arreglo
    cmp X[DI], 1 ;compara la coordenada X actual con 1 para determinar si se ha completado el ciclo
    jnz ciclo   ;salta a la etiqueta "ciclo" si el registro de índice de destino no es igual a 1
    
    MOV AH, 0
    INT 16h

end