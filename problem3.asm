bits 32 ;Iorga Cristian 914 set 3 subpunct 2
   ;a,b,c,d - word compute: (c+b)-a-(d+d)
global start        

extern exit               
import exit msvcrt.dll    
                          

segment data use32 class=data
    a dw 1000
    b dw 1000
    c dw 1000
    d dw 1000

segment code use32 class=code
    start:
        mov AX, [c]
        add AX, [b]
        sub AX, [a]
        sub AX, [d]
        sub AX, [d]
        
        ;Alternatively, if we have to respect the order of paranthesis/ dont break them, we could do so:
       ;mov AX, [c]
       ;add AX, [b] (c+b) in AX
       
       ;mov DX, [d]
       ;add DX, [d] (d+d) in DX
       
       ;sub AX, [a]
       ;sub AX, DX
       
        ;We observe, for (a,b,c,d) = (1000, 1000, 1000, 1000) that AX properly takes the values:
        ;1000
        ;2000
        ;1000
        ;1000
        ;
        push    dword 0    
        call    [exit]
