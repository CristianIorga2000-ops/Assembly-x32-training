bits 32
;iorga cristian grupa 914
;               /\_[]_/\
;              |] _||_ [|
;       ___     \/ || \/
;      /___\       ||
;     (|0 0|)      ||
;   __/{\u/}\_ ___/vvv
;  / \  {~}   / _|_p|
;  | /\  ~   /_/   []
;  |_| (____)        
;  \_]/______\       
;     _\_||_/_           
;    (_,_||_,_)

global start

extern exit, printf, gets
extern print_arr, convert                 
import exit msvcrt.dll    
import printf msvcrt.dll
import gets msvcrt.dll  

segment data use32 class=data     
        s db 'OPQRSTUVWXYZABCDEFGHIJKLMN' ; the new alphabet
        s1 db 'ebcd' ; the string that must be translated in the new alphabet
                     ; The end value should be SPQR - Senatus Populusque Romanus
        len equ $-s1 ; the len of the string
        s2 times len db 0 
        
        ;message_len  db "Read your string length sire    ", 0  ; 
        ;message  db "Read your string sire (must be at least of aforementioned length)  ", 0
    
segment code use32 class=code
    start:
        
        ;I tried to read using gets, but if I do so the program doesnt work correctly anymore
        ;Therefore i use predeclared values for everything
        ;;;
        ;push dword message_len
        ;call    [printf]
        ;add esp, 4*1  ;prints out "read your string length"
        
        ;push 5
        ;push dword len
        ;call    [gets]      
        ;add esp, 4 * 2;read string length
        
        ;push dword message
        ;call    [printf]
        ;add esp, 4*1  ;prints out "read your string"
        
        ;push len
        ;push dword s1      
        ;call    [gets]
        ;add esp, 4*2
        ;;;
        
        
        mov ecx, len ;we put the length l in ecx in order to make the loop
        
        push dword s
        push dword s1
        push dword s2
        call convert
        
        
        mov ecx, len
        push dword s2
        call print_arr
        

       
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program

        
        
        push    dword 0 
        call    [exit]   
