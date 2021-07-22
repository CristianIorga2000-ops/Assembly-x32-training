bits 32
; _,-,
;|_IC|
;||`-'
;||
;||
;914 
global convert 
convert:

        mov esi, [esp+8]
        mov edi, [esp+4]
        
        cmp ecx,0
        jz endit
        loop_by_element:
            mov edx, [esp + 12] ; index of the current element in s(the new alphabet)
            mov eax,0
            mov al, byte[esi] ; letter to be translated
            sub al,'a' ; letter position in new alphabet
            
            
            add edx,eax ; edx will have the index of the translated letter 
            mov al, [edx]; contains ascii code of the translated letter 
            
            stosb ; the letter will be the destination string
             
            
            inc esi ; we increase the index of the source string
    
        loop loop_by_element
    endit:
        ret 12