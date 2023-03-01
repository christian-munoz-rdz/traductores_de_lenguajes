org 100h 
jmp inicio
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
msg db "Sumador/restador de 4 digitos$"
prompt1 db "Suma o resta: $"
prompt2 db "Ingrese su numero: $"
sumares db "El resultado de la suma es: $"
restares db "El resultado de la resta es: $"
choice db ?

inicio:
mov dx, offset msg
mov ah, 09h
int 21h
call newline

mov dx, offset prompt1
mov ah, 09h
int 21h 

mov ah, 01h
int 21h
cmp al, 's'
jz suma
jmp resta
          
ret

suma:
call newline
call obt1
call newline
call obt2  


mov al, u1
add al, u2
aaa
mov u3, al

mov al, d1
adc al, d2
aaa
mov d3, al

mov al, c1
adc al, c2
aaa
mov c3, al

mov al, m1
adc al, m2
aaa
mov m3, al

mov al, 0
adc al, 0
aaa
mov ms3, al

call newline
mov dx, offset sumares
mov ah, 09h
int 21h      
call displayN3

ret

resta:
call newline
call obt1
call newline
call obt2 

mov al, u1
sbb al, u2
mov u3, al

mov al, d1
sbb al, d2
mov d3, al

mov al, c1
sbb al, c2
mov c3, al  

mov al, m1
sbb al, m2
mov m3, al

mov al, 0
sbb al, 0
mov ms3, al

call newline
mov dx, offset restares
mov ah, 09h
int 21h      
call displayN3

ret

obt1:
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

ret

obt2:
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

mov bl, u2  ; n1 = c1 * 100 + d1 * 10 + u1
add n2, bx  ; guardamos el numero completo en n1                

ret


newline:
mov al, 10
mov ah,0eh  
int 10h

mov al, 13
mov ah,0eh  
int 10h
ret   

displayN3:
add u3, 30h
add d3, 30h
add c3, 30h
add m3, 30h
add ms3, 30h

mov ah, 02h
            
mov dl, ms3
int 21h           
mov dl, m3
int 21h 
mov dl, c3
int 21h
mov dl, d3
int 21h
mov dl, u3
int 21h
 
ret



exit:
ret        
