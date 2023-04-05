org 100h
    JMP inicio

    variableX dw ? 
    variableY dw ? 
    clic dw 1

    seno: db  0, 12, 23, 32, 38, 40, 38, 32, 23, 12, 5, -12, -23, -32, -38, -40, -38, -32, -23, -12, -9, 12, 23, 32, 38, 40, 38, 32, 23, 12, 1, -12, -23, -32, -38, -40, -38, -32, -23, -12, -2, 12, 23, 32, 38, 40, 38, 32, 23
    coseno: db 40, 38, 32, 23, 12, 2, -12, -23, -32, -38, -40, -38, -32, -23, -12, -7, 12, 23, 32, 38, 40, 38, 32, 23, 12, 1, -12, -23, -32, -38, -40, -38, -32, -23, -12, -2, 12, 23, 32, 38, 40, 38, 32, 23, 12, 2, -12, -23, -32 

inicio: 
    MOV CL, 0Fh
    MOV BX, 0h
    
    MOV AL, 13h 
    MOV AH, 0h
    int 10h
    
  next: MOV AX, 0
        int 33h
  mouse:MOV AX,3
        int 33h 
        cmp BX,clic
        jnz mouse

        shr CX, 1
        MOV variableX, CX 
        MOV variableY, DX
        
        MOV AL, 0Fh 
        MOV AH, 0Ch 
        int 10h
        
        MOV BX, 0h

circulo:xor CX, CX
        xor DX, DX
        xor AX, AX
        
        MOV CL, seno[BX]
        MOV DL, coseno[BX]
        
        add CX, variableX
        add DX, variableY
        
        cmp CL, 0
        jl regCX
        
        sig:cmp variableX, 255
            jle clearCH
            cmp variableY, 255
            jle clearDH
        
        centro:
            xor AX, AX
            
            MOV Al, 0Fh
            MOV AH, 0Ch
            int 10h
            
            inc BX
            cmp BX, 40
            jnz circulo
        
        fin:
            JMP next
            MOV AH, 0h
            int 16h
            ret
        
        regCX:
            MOV CH, 00h
            JMP sig
        
        clearCH:
            MOV CH, 00h
            cmp variableY, 255
            jle clearDH
            JMP centro
            
        clearDH:
            MOV DH, 00h
            JMP centro