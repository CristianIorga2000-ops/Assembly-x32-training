bits 32 ; assembling for the 32 bits architecture

;Iorga Cristian, subpoint 6
;sub 2 ex 1 (3rd exercise)
;a,b,d-byte; c-word; e-doubleword; x-qword - Signed representation
;x+a/b+c*d-b/c+e;

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; 
    a db 10
    b db 10
    d db 10
    c dw 10
    e dd 10
    x dq 10
    
    ;x+a/b+c*d-b/c+e;
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov edi, [x]    ; edi = x
        
        mov al, [a]
        cbw             ; ax = a
        idiv byte [b]        ; al = a/b
        cbw
        cwde            ; eax = a/b
        add edi, eax    ; edi = (latter half of)x + a/b
        adc dword [x+4], 0
        
        mov al, [d]
        cbw             ; ax = d
        imul word [c]        ; eax = c*d-b/c
        
        add edi, eax    ; edi = (latter half of)x + a/b + +c*d
        adc dword[x+4], 0
        
        mov al, [b]
        cbw
        cwd             ; dx:ax = 
        idiv word [c]         ; ax = b/c
        
        cwde            ; eax = b/c
        sbb edi, eax
        adc edi, c
        mov esi, [x+4]  ; esi:edi = final
        
        
      
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
