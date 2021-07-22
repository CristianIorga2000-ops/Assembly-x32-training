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
; declare extern functions used by the programme
extern exit, printf, scanf ; add printf and scanf as extern functions            
import exit msvcrt.dll    
import printf msvcrt.dll    ; tell the assembler that function printf is found in msvcrt.dll library
import scanf msvcrt.dll     ; similar for scanf

                          
segment data use32 class=data
	a dd  0       ; in this variable we'll store the value read from the keyboard
	b dd  0       ; in this variable we'll store the value read from the keyboard    
    ; char strings are of type byte
	message_a  db "a=", 0  ; char strings for C functions must terminate with 0(value, not char)
    message_b db "b=", 0  ; char strings for C functions must terminate with 0(value, not char)
    
	format_a  db "%d", 0  ; %d <=> a decimal number (base 10)
    format_b db "%d", 0
    
    prompt db "a/b = %d", 0 
    result dd 0
    
segment code use32 class=code
    start:
       
        ;READ A
        push dword message_a
        call [printf]     
        add esp, 4*1       

        push dword a
        push format_a
        call [scanf]      
        add esp, 4 * 2     
        
        ;READ B
        push dword message_b
        call [printf]     
        add esp, 4*1       

        push dword b  
        push format_b
        call [scanf]      
        add esp, 4 * 2     
        
        mov ebx, a
        mov ecx, b
        ;Call divfunction
        call divf
        mov [result], eax
        
        push dword [result]
        push dword prompt ; ! on the stack is placed the address of the string, not its value
        call [printf]      ; call function printf for printing
        add esp, 4*2       ; free parameters on the stack; 4 = size of dword; 1 = number of parameters
        
        ; exit(0)
        push dword 0      ; place on stack parameter for exit
        call [exit]       ; call exit to terminate the program
        
    divf:
        ;receives:
            ;ebx a
            ;ecx b
        ;computes
            ;eax = a/b
        
        mov eax, [a]
        cdq
        idiv dword [b]

        ret                            ; return control to the calling procedure
        