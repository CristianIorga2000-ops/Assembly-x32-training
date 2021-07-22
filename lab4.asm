bits 32 ; assembling for the 32 bits architecture
;Iorga Cristian
; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...

    a dw 1111111000001010b
    b dw 1001110010011110b
    c dd 10011100100111101001110010011110b
;3. Given the words A and B, compute the doubleword C as follows:
    ;the bits 0-2 of C are the same as the bits 12-14 of A
    ;the bits 3-8 of C are the same as the bits 0-5 of B
    ;the bits 9-15 of C are the same as the bits 3-9 of A
    ;the bits 16-31 of C are the same as the bits of A
; c = 1111 1110 0000 1010  1000 0010 1111 0111
                     
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ebx, 0; we compute 0-15 of c in ebx
        
        mov bx, [a];the bits 16-31 of C are the same as the bits of A
        mov cl, 16;
        shl ebx, cl;
        
        mov ax,[a]; we isolate bits 12-14 of A 
        and ax, 0111000000000000b
        mov cl, 12
        ror ax, cl
        or bx, ax; we put the bits into the result
        
        mov ax, [b]; we isolate bits 0-5 of B
        and ax, 0000000000111111b
        mov cl, 2
        rol ax, cl
        or bx, ax; we put the bits into the result
        
        mov ax, [a]; we isolate bits 3-9 of A
        and ax, 00000001111111000b
        mov cl, 7
        rol ax, cl
        or bx, ax
        
        mov dword [c], ebx
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
