org 100h   

jmp start 

corX0 dw ?           
corY0 dw ?            

corX1 dw ?           
corY1 dw ?              


COLOR EQU 0Fh       
                    
macro DRAW             
    mov ah,0Ch            
    mov al, COLOR   
    int 10h
    endm

start:
    mov ax, @data   
    mov ds, ax      
     
    mov ah, 0       
    mov al, 13h     
    int 10h     
    
    mov ah,0h       
    int 33h            
    
repite:    
    mov ax, 03h     
    int 33h
     
    mov corX0, cx   
    mov corY0, dx
    
    cmp bx, 1           
    mov bx, 0
    jne repite       

repite1: 
    mov ax,03h      
    int 33h
     
    mov corX1, cx   
    mov corY1, dx
    
    cmp bx, 1       
    jne repite1      
    
    mov ah,0Ch            
    mov al, COLOR   
  
    mov cx, corX0   
    mov dx, corY0
    
dibujaX0:
  
    int 10h             
    inc cx           
    cmp cx, corX1    
    jne dibujaX0        

dibujaY1: 
   
    int 10h             
    inc dx           
    cmp dx, corY1    
    jne dibujaY1     
 
dibujaX1:
  
    int 10h             
    dec cx           
    cmp cx, corX0    
    jne dibujaX1       

dibujaY0:  
  
    int 10h             
    dec dx           
    cmp dx, corY0    
    jne dibujaY0     
        
    mov ah, 0h      
    int 16h
    
ret
                 
                 
                 