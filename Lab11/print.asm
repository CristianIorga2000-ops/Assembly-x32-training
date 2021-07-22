bits 32
; _,-,
;|_IC|
;||`-'
;||
;||
;914 
global print_arr
extern printf
import printf msvcrt.dll

segment data use32 class=data      
        output db "%c",10,13,0
        
        print_arr:
              mov edi, [esp+4]
              jecxz endit
              loop_by_letter:                    
                  mov eax,0
                  mov al,byte[edi]
                  
                  inc edi
                  
                  pushad
                  push dword eax
                  push dword output
                  call[printf]
                  add esp, 4*2
                  popad  
              loop loop_by_letter
        endit:
            ret 4