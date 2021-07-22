bits 32 ;Iorga Cristian 914 set 1 subpunct 2
   ;Compute and analyze the result: 1 + 15
global start        

extern exit               
import exit msvcrt.dll    
                          

segment data use32 class=data
    a db 1
    b db 15

segment code use32 class=code
    start:
        add a, b
        ;debugging we observe that AL stores the value 10 (hexa) = 16 (dec), and therefore correctly adds 1 and 15
        push    dword 0    
        call    [exit]
