bits 32 ; assembling for the 32 bits architecture

;Iorga Cristian, sbbpoint 6
;sbb 1 ex 2 (2nd exercise)
;a - byte, b - word, c - double word, d - qword - Signed representation
;c-(d+a)+(b+c) = 10 with chosen values

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 10
    b dw 10
    c dd 10
    d dq 10
; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov edi, [c]  ; edi = c
        
        mov al, [a]  
        cbw
        cwde  ; eax = a
        mov esi, [d]
        adc esi, eax  ; esi = d+a

        mov ax, [b]
        cwde  ; eax = b
        mov ebx, [c]
        adc eax, ebx  ; eax = b+c
        
        sbb edi, esi
        adc edi, eax
        mov edx,[d+4]
        sbb esi, edx  ; esi:edi = c-(d+a)+(b+c)  
              
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
