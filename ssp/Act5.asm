org 100h 
jmp inicio

;variables para el primer numero
unid1 db 0
de1 db 0
cen1 db 0
mill1 db 0
num1 dw 0

;variables para el segundo numero
unid2 db 0
de2 db 0
cen2 db 0
mill2 db 0
num2 dw 0

;variables para el resultado
unid3 db 0
de3 db 0
cen3 db 0
mill3 db 0
dcm db 0
num3 dw 0

;Mensajes de pantalla
msg db "Sumador y restador $"
msg2 db "Elija una opcion (s = suma / cualquier otro = resta): $"
msg3 db "Ingrese un numero: $"
msg4 db "El resultado es: $"

; Programa principal
inicio:
    LEA DX, msg 
    MOV ah, 09h
    INT 21h
    MOV al, 10
    MOV ah,0eh  
    INT 10h

    MOV al, 13
    MOV ah,0eh  
    INT 10h

    LEA DX, msg2
    MOV ah, 09h
    INT 21h 

    MOV ah, 01h
    INT 21h
    CMP al, 's'
    jz suma
    jmp resta
            
    ret


suma:
    MOV al, 10
    MOV ah,0eh  
    INT 10h

    MOV al, 13
    MOV ah,0eh  
    INT 10h
    LEA DX, msg3
    MOV ah, 09h
    INT 21h

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV mill1, al ;Obtengo el digito de los millares del primer numero
    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV cen1, al ;Obtengo el digito de las centenas del primer numero

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV de1, al ;Obtengo el digito de las decenas del primer numero   

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV unid1, al ;Obtengo el digito de las unidades del primer numero    

    XOR ax, ax 

    MOV bx, 1000 ;Multiplico el digito de los millares por 1000
    MOV al, mill1  
    MUL bx      
    MOV num1, ax ;Guardo el resultado en num1 

    XOR bx, bx ;Limpio el registro bx  

    MOV bl, 100 ;Multiplico el digito de las centenas por 100 
    MOV al, cen1 
    MUL bl      
    ADD num1, ax  ;Sumo el resultado a num1

    MOV bl, 10 ;Multiplico el digito de las decenas por 10
    MOV al, de1
    MUL bl
    ADD num1, ax  ;Sumo el resultado a num1

    MOV bl, unid1 ;Sumo el digito de las unidades a num1  
    ADD num1, bx   ;Sumo el resultado a num1
    MOV al, 10 
    MOV ah,0eh  
    INT 10h 

    MOV al, 13 
    MOV ah,0eh  
    INT 10h
    LEA DX, msg3
    MOV ah, 09h
    INT 21h

    MOV ah, 01h ;Obtengo el digito de los millares del segundo numero
    INT 21h 
    SUB al, 30h ;Convierto el caracter a numero
    MOV mill2, al  ;Guardo el digito en mill2

    MOV ah, 01h ;Obtengo el digito de las centenas del segundo numero
    INT 21h 
    SUB al, 30h ;Convierto el caracter a numero
    MOV cen2, al  ;Guardo el digito en cen2

    MOV ah, 01h ;Obtengo el digito de las decenas del segundo numero
    INT 21h
    SUB al, 30h ;Convierto el caracter a numero
    MOV de2, al  ;Guardo el digito en de2

    MOV ah, 01h ;Obtengo el digito de las unidades del segundo numero
    INT 21h
    SUB al, 30h 
    MOV unid2, al ;Guardo el digito en unid2   

    XOR ax, ax 

    MOV bx, 1000 ;Multiplico el digito de los millares por 1000
    MOV al, mill2  ;Obtengo el digito de los millares del segundo numero
    MUL bx      
    MOV num2, ax ;Guardo el resultado en num2

    XOR bx, bx ;Limpio el registro bx  

    MOV bl, 100 ;Multiplico el digito de las centenas por 100
    MOV al, cen2 ;Obtengo el digito de las centenas del segundo numero
    MUL bl      ;Multiplico el digito de las centenas por 100
    ADD num2, ax ;Sumo el resultado a num2

    MOV bl, 10 ;Multiplico el digito de las decenas por 10
    MOV al, de2 ;Obtengo el digito de las decenas del segundo numero
    MUL bl ;Multiplico el digito de las decenas por 10
    ADD num2, ax  ;Sumo el resultado a num2

    MOV bl, unid2  ;Obtengo el digito de las unidades del segundo numero
    ADD num2, bx  ;Sumo el resultado a num2


    MOV al, unid1 ;Sumo el digito de las unidades del primer numero
    ADD al, unid2 ;Sumo el digito de las unidades del segundo numero
    aaa 
    MOV unid3, al ;Guardo el resultado en unid3

    MOV al, de1 ;Sumo el digito de las decenas del primer numero
    ADC al, de2 ;Sumo el digito de las decenas del segundo numero
    aaa 
    MOV de3, al ;Guardo el resultado en de3

    MOV al, cen1 ;Sumo el digito de las centenas del primer numero
    ADC al, cen2 ;Sumo el digito de las centenas del segundo numero
    aaa
    MOV cen3, al ;Guardo el resultado en cen3

    MOV al, mill1 ;Sumo el digito de los millares del primer numero
    ADC al, mill2 ;Sumo el digito de los millares del segundo numero
    aaa
    MOV mill3, al ;Guardo el resultado en mill3

    MOV al, 0 
    ADC al, 0
    aaa
    MOV dcm, al ;Guardo el resultado en dcm

    MOV al, 10 
    MOV ah,0eh  
    INT 10h

    ;imprimo el resultado
    MOV al, 13 
    MOV ah,0eh  
    INT 10h 
    LEA DX, msg4
    MOV ah, 09h
    INT 21h      
    ADD unid3, 30h ;Convierto el numero a caracter 
    ADD de3, 30h ;Convierto el numero a caracter
    ADD cen3, 30h ;Convierto el numero a caracter
    ADD mill3, 30h ;Convierto el numero a caracter
    ADD dcm, 30h ;Convierto el numero a caracter

    MOV ah, 02h 
                
    MOV dl, dcm ;Imprimo el digito de las decenas de millar
    INT 21h           
    MOV dl, mill3 ;Imprimo el digito de los millares
    INT 21h 
    MOV dl, cen3 ;Imprimo el digito de las centenas
    INT 21h
    MOV dl, de3 ;Imprimo el digito de las decenas
    INT 21h
    MOV dl, unid3 ;Imprimo el digito de las unidades
    INT 21h

    ret

resta:
    MOV al, 10
    MOV ah,0eh  
    INT 10h

    MOV al, 13
    MOV ah,0eh  
    INT 10h
    LEA DX, msg3
    MOV ah, 09h
    INT 21h

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV mill1, al ;Obtengo el digito de los millares del primer numero  

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV cen1, al ;Obtengo el digito de las centenas del primer numero  

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV de1, al ;Obtengo el digito de las decenas del primer numero  

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV unid1, al ;Obtengo el digito de las unidades del primer numero ;Obtengo el digito de las unidades del primer numero   

    XOR ax, ax 

    MOV bx, 1000 ;Multiplico el digito de los millares por 1000
    MOV al, mill1  
    MUL bx      
    MOV num1, ax ;Guardo el resultado en num1

    XOR bx, bx ;Limpio el registro bx  

    MOV bl, 100 ;Multiplico el digito de las centenas por 100
    MOV al, cen1 
    MUL bl      
    ADD num1, ax ;Sumo el resultado a num1

    MOV bl, 10 ;Multiplico el digito de las decenas por 10
    MOV al, de1 
    MUL bl
    ADD num1, ax  ;Sumo el resultado a num1 

    MOV bl, unid1 ;Sumo el digito de las unidades a num1  
    ADD num1, bx ;Sumo el digito de las unidades a num1 
    MOV al, 10 
    MOV ah,0eh  
    INT 10h

    MOV al, 13
    MOV ah,0eh  
    INT 10h
    LEA DX, msg3
    MOV ah, 09h
    INT 21h

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV mill2, al ;Obtengo el digito de los millares del segundo numero  

    MOV ah, 01h 
    INT 21h
    SUB al, 30h
    MOV cen2, al ;Obtengo el digito de las centenas del segundo numero  

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV de2, al  ;Obtengo el digito de las decenas del segundo numero

    MOV ah, 01h
    INT 21h
    SUB al, 30h
    MOV unid2, al  ;Obtengo el digito de las unidades del segundo numero

    XOR ax, ax 

    MOV bx, 1000 ;Multiplico el digito de los millares por 1000
    MOV al, mill2 
    MUL bx      
    MOV num2, ax ;Guardo el resultado en num2

    XOR bx, bx ;Limpio el registro bx  

    MOV bl, 100 ;Multiplico el digito de las centenas por 100
    MOV al, cen2
    MUL bl      
    ADD num2, ax ;Sumo el resultado a num2

    MOV bl, 10 ;Multiplico el digito de las decenas por 10
    MOV al, de2
    MUL bl 
    ADD num2, ax ;Sumo el resultado a num2  

    MOV bl, unid2  ;Sumo el digito de las unidades a num2
    ADD num2, bx  

    MOV al, unid1 ;Resto el digito de las unidades del primer numero
    SBB al, unid2 
    MOV unid3, al

    MOV al, de1 ;Resto el digito de las decenas del primer numero
    SBB al, de2
    MOV de3, al

    MOV al, cen1 ;Resto el digito de las centenas del primer numero
    SBB al, cen2
    MOV cen3, al  

    MOV al, mill1 ;Resto el digito de los millares del primer numero
    SBB al, mill2
    MOV mill3, al

    MOV al, 0  ;Resto el digito de las decenas de millar del primer numero
    SBB al, 0
    MOV dcm, al ;Guardo el resultado en dcm

    ;Imprimo el resultado
    MOV al, 10 
    MOV ah,0eh  
    INT 10h

    MOV al, 13
    MOV ah,0eh  
    INT 10h
    LEA DX, msg4
    MOV ah, 09h
    INT 21h
    ;Convierto los numeros a caracter      
    ADD unid3, 30h
    ADD de3, 30h
    ADD cen3, 30h
    ADD mill3, 30h
    ADD dcm, 30h

    MOV ah, 02h
                
    ;Imprimo el resultado
    MOV dl, dcm
    INT 21h           
    MOV dl, mill3
    INT 21h 
    MOV dl, cen3
    INT 21h
    MOV dl, de3
    INT 21h
    MOV dl, unid3
    INT 21h

    ret


exit:
ret        
