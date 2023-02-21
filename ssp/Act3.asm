org 100h
jmp inicio
var db 3

inicio:
  ; ADD
  mov al,3
  ;Suma 6 a AL
  add al,6
  ; Suma 30h a AL para poder imprimir en decimal
  add al,30h
  ; Asegura que AH este en cero antes de imprimir
  mov ah, 0  
  ; Llama a la funcion de impresion
  call print_result

  ; ADC
  mov al,4
  ; Suma 3 a AL con carry
  adc al,3 
  mov ah,0
  add al,30h
  call print_result

  ; SUB
  mov al,15
  ; Resta 9 de AL
  sub al,9 
  add al,30h
  mov ah,0
  call print_result

  ; SBB
  mov al,15 
  ; Resta 8 de AL con carry
  sbb al,8 
  mov ah,0
  add al,30h
  call print_result

  ; MUL
  mov al,3
  ; Multiplica AL por la variable "var"
  mul var
  add al,30h
  mov ah, 0 
  call print_result

  ; DIV
  mov al,15
  mov ah, 0
  ; Realiza la division de AL entre la variable "var"
  div var 
  add al,30h
  mov ah, 0 
  call print_result 

; Funcion para imprimir el resultado en hexadecimal
print_result:
  ; Carga el valor a imprimir en el registro DX
  mov dx, ax
  ; Indica que se debe imprimir en hexadecimal
  mov ah, 2
  ; Llama a la interrupcion 21h para imprimir en pantalla
  int 21h
  ; Retorna al programa principal
  ret



