.MODEL SMALL
.STACK 100h

.DATA
    x1 DW 160
    y1 DW 100
    x2 DW 320
    y2 DW 200
    dxs DW ?
    dy DW ?
    E DW ?                                              
    Dn DW ?
    Dp DW ?
    x DW ?
    y DW ?

.CODE
    ASSUME DS:DATA, CS:CODE

BEGIN:
    MOV AX, @DATA
    MOV DS, AX

    CALL GRAPHMODE
    CALL BRESENHAM
    CALL LINEA
    CALL GETKEY

    MOV AX, 4C00h
    INT 21h

GRAPHMODE PROC NEAR
    MOV AX, 0
    MOV AL, 13h
    INT 10h
    RET

GETKEY PROC NEAR
    MOV AH, 10h
    INT 16h
    RET

BRESENHAM PROC NEAR
    ; Calcula las diferencias en las coordenadas x e y
    MOV AX, x2
    SUB AX, x1
    MOV DX, AX
    MOV dxs, DX
    MOV AX, y2
    SUB AX, y1
    MOV DX, AX
    MOV dy, DX

    ; Calcula E, Dn y Dp
    MOV AX, 2
    MUL dy
    SUB AX, dxs
    MOV E, AX
    MOV AX, 2
    MUL dy
    MOV DX, AX
    SUB DX, dxs
    MOV Dp, DX
    MOV AX, 2
    MUL dy
    MOV Dn, AX

    ; Inicializa las coordenadas x, y
    MOV AX, x1
    MOV x, AX
    MOV AX, y1
    MOV y, AX

    RET

LINEA PROC NEAR
    MOV CX, dxs

    ; Calcula el desplazamiento horizontal para centrar la línea
    MOV AX, 320
    SUB AX, dxs
    SHR AX, 1
    MOV DX, AX
    ADD x, DX

    ; Calcula el desplazamiento vertical para centrar la línea
    MOV AX, 200
    SUB AX, dy
    SHR AX, 1
    MOV DX, AX
    ADD y, DX

    DRAW_LINE:
        MOV AH, 0Ch
        INT 10h

        MOV AX, E
        CMP AX, 0
        JL ELSE_CONDITION

        ADD AX, Dp
        ADD x, 1
        MOV E, AX
        JMP CONTINUE_LOOP

    ELSE_CONDITION:
        ADD AX, Dn
        MOV E, AX

    CONTINUE_LOOP:
        LOOP DRAW_LINE

    RET

END BEGIN