MOV AH, 0
MOV AL, 13H
INT 10H

MOV AH, 0CH
MOV AL, 10
MOV CX, 30
MOV DX, 50
INT 10H

MOV BL, 70
firstline:
    INT 10h
    INC CX
    DEC BL
    JNZ firstline
    MOV BL,70

secondline:
    INT 10H
    INC CX
    DEC BL
    JNZ secondline
    MOV BL, 70
    
thirdline:
    INT 10H
    DEC CX
    DEC BL
    JNZ thirdline
    MOV BL, 70

fourthline:
    INT 10h
    DEC DX
    DEC BL
    JNZ fourthline