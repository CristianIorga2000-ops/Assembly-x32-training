bits 32 ;Iorga Cristian 914 set 2 subpunct 2
   ; with a,b,c,d byte, compute: (b+b)+(c-a)+d
global start        

extern exit               
import exit msvcrt.dll    
                          

segment data use32 class=data
    a db 1
    b db 1
    c db 1
    d db 1

segment code use32 class=code
    start:
        mov AL, [b]
        add AL, [b] ;(b+b) in AL
        
        mov AH, [c] 
        sub AH, [a] ; (c-a) in AH 
        
        add AL, AH; (b+b) + (c-a) in AL
        
        add AL, [d]; (b+b)+(c-a)+d
        
        push    dword 0    
        call    [exit]
