ORG 100h ; Direccion de inicio del programa

JMP START ; Salto incondicional a la etiqueta START

CORX0 DW ? ; Variable para almacenar la coordenada X inicial
CORY0 DW ? ; Variable para almacenar la coordenada Y inicial

CORX1 DW ? ; Variable para almacenar la coordenada X final
CORY1 DW ? ; Variable para almacenar la coordenada Y final


COLOR EQU 0Fh ; Definicion de la constante COLOR con el valor 0Fh

MACRO DRAW ; Macro para dibujar con el color definido
    MOV AH, 0Ch ; Carga el número de la funcion en AH
    MOV AL, COLOR ; Carga el color en AL
    INT 10h ; Llama a la interrupcion del BIOS para dibujar
ENDM ; Fin de la macro DRAW

START: ; Etiqueta START: punto de inicio del programa

    MOV AX, @DATA ; Carga el segmento de datos en AX
    MOV DS, AX ; Asigna el valor del segmento de datos al registro DS

    MOV AH, 0 ; Limpia el registro AH
    MOV AL, 13h ; Carga el modo de video 13h en AL
    INT 10h ; Llama a la interrupcion del BIOS para establecer el modo de video

    MOV AH, 0h ; Limpia el registro AH
    INT 33h ; Llama a la interrupcion del BIOS para obtener las coordenadas del mouse

REPITE: ; Etiqueta REPITE: inicio del bucle

    MOV AX, 03h ; Carga el número de la funcion en AX
    INT 33h ; Llama a la interrupcion del BIOS para actualizar las coordenadas del mouse

    MOV CORX0, CX ; Almacena la coordenada X inicial en la variable
    MOV CORY0, DX ; Almacena la coordenada Y inicial en la variable

    CMP BX, 1 ; Compara el valor de BX con 1
    MOV BX, 0 ; Si no son iguales, se establece BX en 0
    JNE REPITE ; Salta a la etiqueta REPITE si no son iguales

REPITE1: ; Etiqueta REPITE1: inicio del bucle

    MOV AX, 03h ; Carga el número de la funcion en AX
    INT 33h ; Llama a la interrupcion del BIOS para actualizar las coordenadas del mouse

    MOV CORX1, CX ; Almacena la coordenada X final en la variable
    MOV CORY1, DX ; Almacena la coordenada Y final en la variable

    CMP BX, 1 ; Compara el valor de BX con 1
    JNE REPITE1 ; Salta a la etiqueta REPITE1 si no son iguales

    MOV AH, 0Ch ; Carga el número de la funcion en AH
    MOV AL, COLOR ; Carga el color en AL

    MOV CX, CORX0 ; Carga la coordenada X inicial en CX
    MOV DX, CORY0 ; Carga la coordenada Y inicial en DX

DIBUJAX0: ; Etiqueta DIBUJAX0: inicio del bucle

    INT 10h ; Llama a la interrupcion del BIOS para dibujar
    INC CX ; Incrementa la coordenada X
    CMP CX,CORX1 ; Compara la coordenada X con CORX1
    JNE DIBUJAX0 ; Salta a la etiqueta DIBUJAX0 si no son iguales

DIBUJAY1: ; Etiqueta DIBUJAY1: inicio del bucle

    INT 10h ; Llama a la interrupcion del BIOS para dibujar
    INC DX ; Incrementa la coordenada Y
    CMP DX, CORY1 ; Compara la coordenada Y con CORY1
    JNE DIBUJAY1 ; Salta a la etiqueta DIBUJAY1 si no son iguales

DIBUJAX1: ; Etiqueta DIBUJAX1: inicio del bucle

    INT 10h ; Llama a la interrupcion del BIOS para dibujar
    DEC CX ; Decrementa la coordenada X
    CMP CX, CORX0 ; Compara la coordenada X con CORX0
    JNE DIBUJAX1 ; Salta a la etiqueta DIBUJAX1 si no son iguales

DIBUJAY0: ; Etiqueta DIBUJAY0: inicio del bucle

    INT 10h ; Llama a la interrupcion del BIOS para dibujar
    DEC DX ; Decrementa la coordenada Y
    CMP DX, CORY0 ; Compara la coordenada Y con CORY0
    JNE DIBUJAY0 ; Salta a la etiqueta DIBUJAY0 si no son iguales

    MOV AH, 0h ; Limpia el registro AH
    INT 16h ; Llama a la interrupcion del BIOS para esperar una tecla

RET ; Retorno del programa principal                  