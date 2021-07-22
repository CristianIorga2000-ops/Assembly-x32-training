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

extern exit, printf, gets
extern fopen, fread, fclose
import fopen msvcrt.dll
import fread msvcrt.dll
import fclose msvcrt.dll
import exit msvcrt.dll    
import printf msvcrt.dll
import gets msvcrt.dll

segment data use32 class=data
    ; ...    
    text_file times 10 db 0
    nr_c dd 0
    
    access_mode db 'r', 0
    file_descriptor dd -1
    
    len equ 100 ; max read characters
    string times (len+1) db 0
    
    word_count dw 0
    
    prompt1 db 'Input filename: ', 0    
    prompt2 db 'Input number of consonants: ', 0
    
    format db "The result is: %d words have %d consonants", 0
    ;Program reads input properly, reads from file properly and has a 'proper' pseudocode algorithm :["
segment code use32 class=code
    start:
        ; ...
        push prompt1
        call    [printf]
        add esp, 4

        push dword 10
        push dword text_file
        call    [gets]      
        add esp, 4 * 2 ; read text file name
        
        ;push text_file
        ;call    [printf] ; advanced debugging
        ;add esp, 4
        
        push prompt2
        call    [printf]
        add esp, 4
        
        push 10
        push dword nr_c
        call    [gets]
        add esp, 4*2
        
        ;push nr_c
        ;call    [printf] ; advanced debugging
        ;add esp, 4        
        
        ;start reading from file
        push dword access_mode     
        push dword text_file
        call [fopen]
        add esp, 4*2     

        mov [file_descriptor], eax        
        
        cmp eax, 0  ; verify text file was open properly
        je iserror
        
        
        push dword [file_descriptor]  ; actual part where reading magic happens
        push dword len
        push dword 1
        push dword string      
        call [fread]
        add esp, 4*4
            
        ;xchg ecx, eax
        ;mov esi, 0
        ;mov ebx, 0 ; tinem minte consoane
        ;jecxz toend:
        ;Consoane:
            ;daca [string + esi] este consoana:
                ;inc ebx
            ;daca [string + esi] == "/":
                ;daca ebx == nr_c:
                    ;word_count ++
                ;mov ebx, 0
                
                 
            ;inc esi
            ;dec ecx   
            
        ;loop Consoane
     
       ;toend: 
        push dword word_count
        push dword nr_c
        push format
        call [printf]
        add esp, 4*3
        
        
       iserror:
        push    dword 0 
        call    [exit]   
        
    
        
