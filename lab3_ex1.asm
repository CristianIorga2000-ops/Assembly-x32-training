bits 32 ; assembling for the 32 bits architecture

;Iorga Cristian, sbbpoint 6
;sbb 1 ex 1 (1st exercise)
;a - byte, b - word, c - double word, d - qword - Unsigned representation
;(a+b)-(a+d)+(c-a) = 15 with chosen values

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    a db 20
    b dw 20
    c dd 25
    d dq 10

; our code starts here
segment code use32 class=code
    start:
        ; ...
        mov ax, 0
        mov al, [a]  ; unsigned conversion of a->al to ax
        adc [b], ax  ; b now has value a+b
        
        mov eax, [d] 
        mov ebx, 0
        mov bl, [a]
        adc eax, ebx
        mov [d], eax  ; d now has value d+a
        
        mov eax,[c]
        mov ebx, 0
        mov bl, [a]
        sbb eax, ebx ; EAX: XXXX XXXX XXXX XXXX = c-a
        
        mov ebx, 0
        mov bx, [b] ; EBX: 0000 0000 (XXXX XXXX = a + b)
        
        mov ecx, [d]
        
        sbb ebx, ecx ; (a+b) - (a+d)
        adc ebx, eax
        mov ecx, [d+4] ; ECX:EBX = (a+b)-(a+d)+(c-a) 
        
        
        
        
        
        
        
        
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
