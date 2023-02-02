org 100h 

jmp inicio

var1 db 45h ; 45h = 01000101 
var2 db 57h ; 57h = 01010111
 

inicio:
  mov al,var1 ; carga el valor de var1 en el registro AX
  mov bl,var2 ; carga el valor de var2 en el registro BX
  AND al,bl  ; realiza una operacion logica AND entre los valores de AX y BX
             ; y guarda el resultado en AX
             ;  45h AND 57h = 01000101 
             ;                  AND 
             ;                01010111
             ;                   =
             ;                01000101 = 45h 
   
  
  OR al,bl ; realiza una operacion logica OR entre los valores de AX y BX
           ; y guarda el resultado en AX
           ; 45h OR 57h = 01000101
           ;                 OR
           ;              01010111
           ;                 =
           ;              01010111 = 57h
  
  mov al,var1
  XOR al,bl ; realiza una operacion logica XOR entre los valores de AX y BX
           ; y guarda el resultado en AX
           ; 45h XOR 57h = 01000101
           ;                 XOR
           ;               01010111
           ;                  =
           ;               00010010 = 12h
  
  NOT al ; realiza una operacion logica NOT en el valor de AX y guarda el resultado en AX
         ; NOT 12h = 00010010 -> 11101101 = EDh
  
  NEG al ; realiza una operacion logica NOT en el valor de AX y guarda el resultado en AX
         ; NEG EDh = 11101101 -> 00010011 = 13h
  
  ; NAND
  mov al, var1
  AND al,bl ; realiza la operación AND entre ambos registros
  NOT al; invierte el resultado obtenido con la operacion AND
        ; el resultado final es la negacion del resultado, la compuerta NAND
  
  ;NOR
  mov al, var1
  OR al,bl; realiza la operacion OR entre ambos inputs
  NOT al; invierte el resultado obtenido con la operacion OR
        ; el resultado final es la negacion del resultado, la compuerta NOR
  
  ;XNOR
  mov al, var1
  XOR al, bl; realizar operacion XOR entre AL y BL
  NOT al ; negar el resultado de la operacion XOR
