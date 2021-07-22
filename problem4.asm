bits 32 ;Iorga Cristian 914 set 4 subpunct 2
   ;a,b,c - byte, d - word compute: d*(d+2*a)/(b*c)
global start        

extern exit               
import exit msvcrt.dll    
                          

segment data use32 class=data
    a db 10
    b db 10
    c db 10
    d dw 1000
    
    bc dw 1  ;bc takes the value of b*c
    e db 2
    
segment code use32 class=code
    start:
        mov AL, [b]
        mul byte [c]
        mov [bc], AX ; bc now has the value of (b*c)
    
        mov AL, [a]
        mov byte [a], 2
        mul byte [a]
        add AX, [d] ; (d+2*a) in AX
        
        mul word [d]; d*(d+2*a) in DX:AX
        
        div word [bc]; d*(d+2*a)/(b*c) in AX 
        
        
        

        push    dword 0    
        call    [exit]
