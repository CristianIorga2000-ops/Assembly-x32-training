; Codul de mai jos va deschide un fisier numit "input.txt" din directorul curent si va citi intregul text din acel fisier, in etape, cate 100 de caractere intr-o etapa.
; Deoarece un fisier text poate fi foarte lung, nu este intotdeauna posibil sa citim fisierul intr-o singura etapa pentru ca nu putem defini un sir de caractere suficient de lung pentru intregul text din fisier. De aceea, prelucrarea fisierelor text in etape este necesara.
; Programul va folosi functia fopen pentru deschiderea fisierului, functia fread pentru citirea din fisier si functia fclose pentru inchiderea fisierului creat.
; Deoarece in apelul functiei fopen programul foloseste modul de acces "r", daca un fisier numele dat nu exista in directorul curent,  apelul functiei fopen nu va reusi (eroare). Detalii despre modurile de acces sunt prezentate in sectiunea "Suport teoretic".

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

; declare external functions needed by our program
extern exit, fopen, fclose, fread, printf
import exit msvcrt.dll 
import fopen msvcrt.dll 
import fread msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll

; our data is declared here 
segment data use32 class=data
    nume_fisier db "input.txt", 0   ; numele fisierului care va fi deschis
    mod_acces db "r", 0             ; modul de deschidere a fisierului; r - pentru scriere. fisierul trebuie sa existe 
    descriptor_fis dd -1            ; variabila in care vom salva descriptorul fisierului - necesar pentru a putea face referire la fisier
    nr_car_citite dd 0              ; variabila in care vom salva numarul de caractere citit din fisier in etapa curenta
    len equ 100                     ; numarul maxim de elemente citite din fisier intr-o etapa
    buffer resb len                 ; sirul in care se va citi textul din fisier
    s dw 0
    format dw "Fisierul citit are %d consoane, stimate domnisor.",0

; our code starts here
segment code use32 class=code
    start:
        ; apelam fopen pentru a deschide fisierul
        ; functia va returna in EAX descriptorul fisierului sau 0 in caz de eroare
        ; eax = fopen(nume_fisier, mod_acces)
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        ; verificam daca functia fopen a creat cu succes fisierul (daca EAX != 0)
        cmp eax, 0                  
        je final
        
        mov [descriptor_fis], eax   ; salvam valoarea returnata de fopen in variabila descriptor_fis
        
        ; echivalentul in pseudocod al urmatoarei secvente de cod este:
        ;repeta
        ;   nr_car_citite = fread(buffer, 1, len, descriptor_fis)
        ;   daca nr_car_citite > 0
        ;       ; instructiuni pentru procesarea caracterelor citite in aceasta etapa
        ;pana cand nr_car_citite == 0
        mov ebx, 0 
        bucla:            
            ; citim o parte (100 caractere) din textul in fisierul deschis folosind functia fread
            ; eax = fread(buffer, 1, len, descriptor_fis)
            push dword [descriptor_fis]
            push dword len
            push dword 1
            push dword buffer
            call [fread]
            add esp, 4*4
            
            ; eax = numar de caractere / bytes citite
            cmp eax, 0          ; daca numarul de caractere citite este 0, am terminat de parcurs fisierul
            je cleanup

            mov [nr_car_citite], eax        ; salvam numarul de caractere citie
            
            mov ecx, eax
            mov eax, 0
            mov esi, 0
            mov ebx, 0
            
            alta_bucla:
                mov eax, [descriptor_fis + esi]
                inc esi
                ;un sir lung de comparatii pentru ca altfel habar n am cum sa fac
                cmp eax, 98
                je consoana
                cmp eax, 99
                je consoana                
                cmp eax, 100
                je consoana
                cmp eax, 102
                je consoana
                cmp eax, 103
                je consoana
                cmp eax, 104
                je consoana
                cmp eax, 106
                je consoana
                cmp eax, 107
                je consoana
                cmp eax, 108
                je consoana
                cmp eax, 109
                je consoana
                cmp eax, 110
                je consoana
                cmp eax, 113
                je consoana
                cmp eax, 114
                je consoana
                cmp eax, 115
                je consoana
                cmp eax, 116
                je consoana
                cmp eax, 118
                je consoana
                cmp eax, 119
                je consoana
                cmp eax, 120
                je consoana
                cmp eax, 122
                je consoana
                cmp eax, 66
                je consoana
                cmp eax, 67
                je consoana                
                cmp eax, 68
                je consoana
                cmp eax, 70
                je consoana
                cmp eax, 71
                je consoana
                cmp eax, 72
                je consoana
                cmp eax, 74
                je consoana
                cmp eax, 75
                je consoana
                cmp eax, 76
                je consoana
                cmp eax, 77
                je consoana
                cmp eax, 78
                je consoana
                cmp eax, 81
                je consoana
                cmp eax, 82
                je consoana
                cmp eax, 83
                je consoana
                cmp eax, 84
                je consoana
                cmp eax, 86
                je consoana
                cmp eax, 87
                je consoana
                cmp eax, 88
                je consoana
                cmp eax, 90
                je consoana               
                jmp nu_consoana
                
                consoana:
                inc ebx
                
            nu_consoana: 
            dec ecx
            cmp ecx, 0
            je bucla
            jmp alta_bucla

        
      cleanup:
        ; apelam functia fclose pentru a inchide fisierul
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4        
        push dword ebx
        push dword format
        call [printf]
        add esp, 4*2        
        
      final:  
        ; exit(0)
        push    dword 0      
        call    [exit]       