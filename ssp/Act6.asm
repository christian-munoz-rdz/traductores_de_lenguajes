org 100h
jmp inicio
NUM1 DW 1234H
NUM2 DW 5678H
RESULT DD ?
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
u3 db 0
d3 db 0
c3 db 0
m3 db 0
ms3 db 0
n3 dw 0
prompt2 db "Ingrese un numero: $"
sumares db "El resultado de la multipliacion es: $"
choice db ?

inicio:
  mov dx, offset prompt2
  mov ah, 09h
  int 21h
    
  mov ah, 01h
  int 21h
  sub al, 30h
  mov m1, al  ;capta las milesimas de n1
    
  mov ah, 01h
  int 21h
  sub al, 30h
  mov c1, al  ;capta las centenas de n1
    
  mov ah, 01h
  int 21h
  sub al, 30h
  mov d1, al  ;capta las decenas del n1
    
  mov ah, 01h
  int 21h
  sub al, 30h
  mov u1, al  ;capta las unidades del n1 
    
  xor ax, ax 
    
  mov bx, 1000
  mov al, m1  ; m1 * 10000
  mul bx      ; bx porque es 16 bits y cubre a 1000
  mov n1, ax 
    
  xor bx, bx  ; limpiamos todo bx, para no dejar nada en bx
    
  mov bl, 100
  mov al, c1
  mul bl      ; c1 * 100
  add n1, ax
    
  mov bl, 10
  mov al, d1
  mul bl
  add n1, ax  ;c1 * 100 + dl * 10
    
  mov bl, u1  ; n1 = c1 * 100 + d1 * 10 + u1
  add n1, bx  ; guardamos el numero completo en n1                
    
  call newline
  mov dx, offset prompt2
  mov ah, 09h
  int 21h
    
  mov ah, 01h
  int 21h
  sub al, 30h
  mov m2, al  ;capta las milesimas de n1
    
  mov ah, 01h
  int 21h
  sub al, 30h
  mov c2, al  ;capta las centenas de n1
    
  mov ah, 01h
  int 21h
  sub al, 30h
  mov d2, al  ;capta las decenas del n1
    
  mov ah, 01h
  int 21h
  sub al, 30h
  mov u2, al  ;capta las unidades del n1 
    
  xor ax, ax 
    
  mov bx, 1000
  mov al, m2  ; m1 * 10000
  mul bx      ; bx porque es 16 bits y cubre a 1000
  mov n2, ax 
    
  xor bx, bx  ; limpiamos todo bx, para no dejar nada en bx
    
  mov bl, 100
  mov al, c2
  mul bl      ; c1 * 100
  add n2, ax
    
  mov bl, 10
  mov al, d2
  mul bl
  add n2, ax  ;c1 * 100 + dl * 10
  call newline
    
  mov bl, u2  ; n1 = c1 * 100 + d1 * 10 + u1
  add n2, bx  ; guardamos el numero completo en n1 

  mov dx, offset sumares
  mov ah, 09h
  int 21h
  MOV AX, @DATA
  MOV DS, AX

  MOV AX, n1 ; multiplicando número 1
  MOV BX, n2 ; multiplicando número 2
  MOV CX, 0000H ; contador inicializado a 0
  MOV DX, 0000H ; inicializar el registro de la suma a 0

  LOOP_START:
    TEST BX, 0001H ; comprobar si el último bit de multiplicando número 2 está establecido
    JZ SKIP_ADDITION ; saltar si el último bit está en 0
    ADD DX, AX ; sumar multiplicando número 1 al registro de la suma
  SKIP_ADDITION:
    SHL AX, 1 ; multiplicando número 1 se desplaza un bit a la izquierda
    SHR BX, 1 ; multiplicando número 2 se desplaza un bit a la derecha
    INC CX ; incrementar el contador
    CMP CX, 16 ; comprobar si se han realizado 16 iteraciones
    JL LOOP_START ; saltar al inicio del bucle si no se han realizado todas las iteraciones

  MOV RESULT, DX ; almacenar el resultado en la variable RESULT
      ; Imprimir el primer dígito
  MOV BX, 10000
  MOV AX, RESULT
  XOR DX, DX
  DIV BX
  MUL BX
  SUB RESULT,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h
    
  ; Imprimir el segundo dígito
  MOV BX, 1000
  MOV AX, RESULT
  XOR DX, DX
  DIV BX
  MUL BX
  SUB RESULT,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h
    
  ; Imprimir el tercer dígito
  MOV BX, 100
  MOV AX, RESULT
  XOR DX, DX
  DIV BX
  MUL BX
  SUB RESULT,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h
    
  ; Imprimir el cuarto dígito
  MOV BX, 10
  MOV AX, RESULT
  XOR DX, DX
  DIV BX
  MUL BX
  SUB RESULT,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h
    
  ; Imprimir el quinto dígito
  MOV BX, 1
  MOV AX, RESULT
  XOR DX, DX
  DIV BX
  MUL BX
  SUB RESULT,AX
  DIV BX
  ADD AL, 30H
  MOV AH, 2
  MOV DL, AL
  INT 21h

newline:
    mov al, 10
    mov ah,0eh  
    int 10h
    
    mov al, 13
    mov ah,0eh  
    int 10h
    ret

END
