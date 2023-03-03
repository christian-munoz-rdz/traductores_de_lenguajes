org 100h
jmp inicio
result DD ?
u1 db 0
d1 db 0
c1 db 0
m1 db 0
n1 dw 0 
u2 db 0
d2 db 0
c2 db 0
m2 db 0
n2 dw 0
msg1 db "Ingrese un numero: $"
msg2 db "El resultado de la multipliacion es: $"

inicio:
  MOV dx, offset msg1
  MOV ah, 09h
  INT 21h
    
  MOV ah, 01h
  INT 21h
  SUB al, 30h
  MOV m1, al  ;capta las milesimas de n1
    
  MOV ah, 01h
  INT 21h
  SUB al, 30h
  MOV c1, al  ;capta las centenas de n1
    
  MOV ah, 01h
  INT 21h
  SUB al, 30h
  MOV d1, al  ;capta las decenas del n1
    
  MOV ah, 01h
  INT 21h
  SUB al, 30h
  MOV u1, al  ;capta las unidades del n1 
    
  XOR ax, ax 
    
  MOV bx, 1000
  MOV al, m1  ; m1 * 10000
  MUL bx      ; bx porque es 16 bits y cubre a 1000
  MOV n1, ax 
    
  XOR bx, bx  ; limpiamos todo bx, para no dejar nada en bx
    
  MOV bl, 100
  MOV al, c1
  MUL bl      ; c1 * 100
  ADD n1, ax
    
  MOV bl, 10
  MOV al, d1
  MUL bl
  ADD n1, ax  ;c1 * 100 + dl * 10
    
  MOV bl, u1  ; n1 = c1 * 100 + d1 * 10 + u1
  ADD n1, bx  ; guardamos el numero completo en n1                
    
  call newline
  MOV dx, offset msg1
  MOV ah, 09h
  INT 21h
    
  MOV ah, 01h
  INT 21h
  SUB al, 30h
  MOV m2, al  ;capta las milesimas de n1
    
  MOV ah, 01h
  INT 21h
  SUB al, 30h
  MOV c2, al  ;capta las centenas de n1
    
  MOV ah, 01h
  INT 21h
  SUB al, 30h
  MOV d2, al  ;capta las decenas del n1
    
  MOV ah, 01h
  INT 21h
  SUB al, 30h
  MOV u2, al  ;capta las unidades del n1 
    
  XOR ax, ax 
    
  MOV bx, 1000
  MOV al, m2  ; m1 * 10000
  MUL bx      ; bx porque es 16 bits y cubre a 1000
  MOV n2, ax 
    
  XOR bx, bx  ; limpiamos todo bx, para no dejar nada en bx
    
  MOV bl, 100
  MOV al, c2
  MUL bl      ; c1 * 100
  ADD n2, ax
    
  MOV bl, 10
  MOV al, d2
  MUL bl
  ADD n2, ax  ;c1 * 100 + dl * 10
  call newline
    
  MOV bl, u2  ; n1 = c1 * 100 + d1 * 10 + u1
  ADD n2, bx  ; guardamos el numero completo en n1 

  MOV dx, offset msg2
  MOV ah, 09h
  INT 21h

  MOV AX, n1 ; multiplicando n�mero 1
  MOV BX, n2 ; multiplicando n�mero 2
  MOV CX, 0000H ; contador inicializado a 0
  MOV DX, 0000H ; inicializar el registro de la suma a 0

  LOOP_START:
    TEST BX, 0001H ; comprobar si el �ltimo bit de multiplicando n�mero 2 est� establecido
    JZ SKIP_ADDITION ; saltar si el �ltimo bit est� en 0
    ADD DX, AX ; sumar multiplicando n�mero 1 al registro de la suma
  SKIP_ADDITION:
    SHL AX, 1 ; multiplicando n�mero 1 se desplaza un bit a la izquierda
    SHR BX, 1 ; multiplicando n�mero 2 se desplaza un bit a la derecha
    INC CX ; incrementar el contador
    CMP CX, 16 ; comprobar si se han realizado 16 iteraciones
    JL LOOP_START ; saltar al inicio del bucle si no se han realizado todas las iteraciones

  MOV result, DX ; almacenar el resultado en la variable result
  
  ; Imprimir el primer d�gito
  MOV BX, 10000
  MOV AX, result
  XOR DX, DX
  DIV BX
  MUL BX
  SUB result,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h
    
  ; Imprimir el segundo d�gito
  MOV BX, 1000
  MOV AX, result
  XOR DX, DX
  DIV BX
  MUL BX
  SUB result,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h
    
  ; Imprimir el tercer d�gito
  MOV BX, 100
  MOV AX, result
  XOR DX, DX
  DIV BX
  MUL BX
  SUB result,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h
    
  ; Imprimir el cuarto d�gito
  MOV BX, 10
  MOV AX, result
  XOR DX, DX
  DIV BX
  MUL BX
  SUB result,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h
    
  ; Imprimir el quinto d�gito
  MOV BX, 1
  MOV AX, result
  XOR DX, DX
  DIV BX
  MUL BX
  SUB result,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h

newline:
    MOV al, 10
    MOV ah,0eh  
    INT 10h
    
    MOV al, 13
    MOV ah,0eh  
    INT 10h
    ret

END
