bits 32
; _,-,
;|_IC|
;||`-'
;||
;||
;914 
global _assembler_maximum

segment data public data use32
segment code public code use32

_assembler_maximum:

    ; create a stack frame caller program
    push ebp
    mov ebp, esp   
    ;Note that [ebp+4] holds return address
    
    mov esi, [esp+4*2] ; address of array
    mov ecx, [esp+4*3] ; len of array
    mov eax, [esi] ; first element
    dec ecx
    jecxz endit; 
    
    compare:
    
        add esi, 4
        cmp eax, [esi] ; compare current max with current element
        jge next  ; if max is greater/equal thank current element, do nothing (jump the replacement)
        mov eax, [esi] ; replacement
        
        next:
        
    loop compare
    
    endit:
    
    ; restore caller stack frame
    mov esp, ebp
    pop ebp 
    
    ret ; no freeing of space because caller does it