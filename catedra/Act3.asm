.model small
.stack 100
.data

    unid db 0
    decc db 0
    
    n1 dw 0
    n2 dw 0
    
    res dw 0
    
    num1 db 0
    num2 db 0
    num3 db 0
    num4 db 0 
    
    msg db 10, 13, 'Ingresa un numero de dos digitos:','$'
    msg2 db 10, 13, 'Ingresa otro numero de dos digitos:','$'
    msg3 db 10, 13, 'El resultado es:','$' 
    
    .code
        MOV AX, data
        MOV ds, AX
        
        lea DX, msg
        MOV AH, 09H
        INT 21H
        
        MOV AH, 1
        INT 21H
        MOV decc, AL
        SUB decc, 30H
        
        MOV AH, 1
        INT 21H
        MOV unid, AL
        SUB unid, 30H
        
        MOV BL, 10
        MOV AL, decc
        MUL BL
        MOV decc, AL
        
        MOV AX, 0
        MOV AL, unid
        ADD AL, decc
        MOV n1, AX
        
        lea DX, msg2
        MOV AH, 09H
        INT 21H
        
        MOV AH, 1
        INT 21h
        MOV decc, AL
        SUB decc, 30H
        
        MOV AH, 1
        INT 21H
        MOV unid, AL
        SUB unid, 30H
        
        MOV BL, 10
        MOV AL, decc
        MUL BL
        MOV decc, AL
        
        MOV AX, 0
        MOV AL, unid
        ADD AL, decc
        MOV n2, AX
        
        MOV AX, n1
        ADD AX, n2
        MOV res, AX
        
        lea DX, msg3
        MOV AH, 09H
        INT 21H
        
        MOV AX, res
        aam
        
        MOV AL, AH
        aam
        MOV AL, AH
        ADD AX, 30H
        MOV DL, AL
        MOV AH, 2
        INT 21H
        
        MOV AX, res
        aam
        MOV AL,AH
        aam
        
        ADD AX, 30H
        MOV DL, AL
        MOV AH, 2
        INT 21H
        MOV AX, res
        aam
        
        ADD AX, 30h
        MOV dl, AL
        MOV AH, 2
        
      int 21h
end
    
    
    