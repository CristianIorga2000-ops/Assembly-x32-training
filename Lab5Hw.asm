bits 32
;Iorga Cristian grupa 914
;               /\_[]_/\
;              |] _||_ [|
;       ___     \/ || \/
;      /___\       ||
;     (|0 0|)      ||
;   __/{\U/}\_ ___/vvv
;  / \  {~}   / _|_P|
;  | /\  ~   /_/   []
;  |_| (____)        
;  \_]/______\       
;     _\_||_/_           
;    (_,_||_,_)

global start

extern exit              
import exit msvcrt.dll    

segment data use32 class=data
    ; ...
    s db 1, 2, 3, 2
    l equ $-s-1
    d times 1 dw 0
    
segment code use32 class=code
    start:
        ; ...
        mov ecx, l
        mov esi, 0
        jecxz End
        Repeat:
        	mov al, [s+esi]
            mul byte [s+esi+1]               
            mov [d+esi*2], ax 
            inc esi
        loop Repeat
        End:
        push    dword 0 
        call    [exit]   
        
;Given a byte string S of length l, obtain the string D of length l-1 as D(i) = S(i) * S(i+1) (each element of D is the product of two consecutive elements of S).