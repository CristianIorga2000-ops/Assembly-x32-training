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

extern exit              
import exit msvcrt.dll    

segment data use32 class=data
    ; ...
    s dw 1432h, 8675h, 0ADBCh
    l equ $-s
    d times l dd 0
    el times 4 db 0
    
;               PROGRAM PLANNING:
;                  /        \
;               PART 2      PART 1
;                /             \
;    Sorting all words     Inserting 0`s accordingly


;Repeat uses edx as itinerator for number of repeats insead 
;   of using ecx and loop (idk why, just thought i might try something else)

segment code use32 class=code      
    start:
        mov edx, l
        mov edi, 0
        
        cmp edx, 0
        je End
        
        Repeat:  ; loop for browsing s            
            ; PART ONE: Here we start the actual "nibbling" of 0`s between digits
            mov ax,0 
            mov bx,0
            mov cl, 16  ; used to separate digits of a byte  with div in ax
            
            mov ax, [s+esi]       
            xchg al, bl  ;             /AX: 00d1d2
            xchg ah, al  ; end result:<             (di = digit number i)
                         ;             \BX: 00d2d3  

            div cl
            xchg ah,al
            mov [el+2], ah
            mov [el+3], al

            xchg ax, bx
            div cl
            xchg ah, al
            mov [el+0], ah
            mov [el+1], al
            
            ;el: d1, d2, d3, d4
            
            stosd  ; Here i use a string instruction because it is required for this HW
                   ;    and i have no idea where else to use it
            
            
            add edi, 2  ; go to next word
            sub edx, 2  ; decrement by 2 (because l = 2* number of elements in s)

            
            ;PART TWO Sorting the array of elements of the word(bubble sort stolen from internet)   
            mov bx, 4  ; size of array to be sorted
            lea si, [el]  ; array to be sorted, 
            
            mov ax, si                     ; set ax=si
               mov cx, bx                     ; set cx=bx
               dec cx                         ; set cx=cx-1

               @outer_loop:                   ; loop label
                 mov bx, cx                   ; set bx=cx

                 mov si, ax                   ; set si=ax
                 mov di, ax                   ; set di=ax
                 inc di                       ; set di=di+1

                 @inner_loop:                 ; loop label 
                   mov dl, [si]               ; set dl=[si]

                   cmp dl, [di]               ; compare dl with [di]
                   jng @skip_exchange         ; jump to label @skip_exchange if dl<[di]

                   xchg dl, [di]              ; set dl=[di], [di]=dl
                   mov [si], dl               ; set [si]=dl

                   @skip_exchange:            ; jump label
                   inc si                     ; set si=si+1
                   inc di                     ; set di=di+1

                   dec bx                     ; set bx=bx-1
                 jnz @inner_loop              ; jump to label @inner_loop if bx!=0
               loop @outer_loop               ; jump to label @outer_loop while cx!=0        

               mov ah, [el+0]
               mov al, [el+1]
               push ax
               mov ah, [el+2]
               mov al, [el+3]
               push ax
               pop eax
               
              mov [d+esi*2], eax               
            
            cmp edx, 0
            je End
            jmp Repeat
            
        End:
        push    dword 0 
        call    [exit]   
        
;Homework feedback: 
;Pretty rough exercise, some are very simple some are very complicated (for us at least)
;But overall interesting challenge