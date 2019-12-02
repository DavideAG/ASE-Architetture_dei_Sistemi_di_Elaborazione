dim EQU 50
.MODEL small
.STACK
.DATA

prima_riga           DB dim DUP(?)
seconda_riga         DB dim DUP(?)
terza_riga           DB dim DUP(?)
quarta_riga          DB dim DUP(?)

lunghezza_riga1      DB 0
lunghezza_riga2      DB 0
lunghezza_riga3      DB 0
lunghezza_riga4      DB 0

vett_occorrenze_min_1  DB 26  DUP(?)      ;da 0 a 25
vett_occorrenze_max_1  DB 26  DUP(?)
vett_occorrenze_min_2  DB 26  DUP(?)      ;da 0 a 25
vett_occorrenze_max_2  DB 26  DUP(?)
vett_occorrenze_min_3  DB 26  DUP(?)      ;da 0 a 25
vett_occorrenze_max_3  DB 26  DUP(?)
vett_occorrenze_min_4  DB 26  DUP(?)      ;da 0 a 25
vett_occorrenze_max_4  DB 26  DUP(?)                

lettera_occorr_max_1        DB 0          ;memorizza la lettera maiuscola piu' ricorrente della prima riga  (num occorrenze)
lettera_occorr_max_2        DB 0          ;memorizza la lettera maiuscola piu' ricorrente della seconda riga
lettera_occorr_max_3        DB 0          ;memorizza la lettera maiuscola piu' ricorrente della terza riga
lettera_occorr_max_4        DB 0          ;memorizza la lettera maiuscola piu' ricorrente della quarta riga
lettera_occorr_min_1        DB 0          ;memorizza la lettera minuscola piu' ricorrente della prima riga
lettera_occorr_min_2        DB 0          ;memorizza la lettera minuscola piu' ricorrente della seconda riga
lettera_occorr_min_3        DB 0          ;memorizza la lettera minuscola piu' ricorrente della terza riga
lettera_occorr_min_4        DB 0          ;memorizza la lettera minuscola piu' ricorrente della quarta riga

indice_max_1         DW 0                 ;indice maiuscola piu' ricorrente prima riga
indice_max_2         DW 0                 ;indice maiuscola piu' ricorrente seconda riga
indice_max_3         DW 0                 ;indice maiuscola piu' ricorrente terza riga
indice_max_4         DW 0                 ;indice maiuscola piu' ricorrente quarta riga
indice_min_1         DW 0                 ;indice minuscola piu' ricorrente prima riga
indice_min_2         DW 0                 ;indice minuscola piu' ricorrente seconda riga
indice_min_3         DW 0                 ;indice minuscola piu' ricorrente terza riga
indice_min_4         DW 0                 ;indice minuscola piu' ricorrente quarta riga


.CODE
.STARTUP

;INIZIALIZZAZIONE DEI VETTORI
MOV CX, DIM
XOR BX, BX
inizializza_righe:
    MOV prima_riga[BX],   0
    MOV seconda_riga[BX], 0
    MOV terza_riga[BX],   0
    MOV quarta_riga[BX],  0
    INC BX
    INC BX
    LOOP inizializza_righe

MOV CX, 26
XOR BX, BX
inizializza_vett_occorrenze:
    MOV vett_occorrenze_min_1[BX], 0
    MOV vett_occorrenze_max_1[BX], 0
    MOV vett_occorrenze_min_2[BX], 0
    MOV vett_occorrenze_max_2[BX], 0
    MOV vett_occorrenze_min_3[BX], 0
    MOV vett_occorrenze_max_3[BX], 0
    MOV vett_occorrenze_min_4[BX], 0
    MOV vett_occorrenze_max_4[BX], 0 
    INC BX
    LOOP inizializza_vett_occorrenze

MOV lunghezza_riga1, 0
MOV lunghezza_riga2, 0
MOV lunghezza_riga3, 0
MOV lunghezza_riga4, 0
MOV indice_max_1, 0
MOV indice_max_2, 0
MOV indice_max_3, 0
MOV indice_max_4, 0
MOV indice_min_1, 0
MOV indice_min_2, 0
MOV indice_min_3, 0
MOV indice_min_4, 0
MOV lettera_occorr_max_1, 0
MOV lettera_occorr_max_2, 0
MOV lettera_occorr_max_3, 0
MOV lettera_occorr_max_4, 0
MOV lettera_occorr_min_1, 0
MOV lettera_occorr_min_2, 0
MOV lettera_occorr_min_3, 0
MOV lettera_occorr_min_4, 0


;USARE LUNGHEZZA RIGHE NELLE CERCA, ELIMINA IL CHECK SU 0 ALTRIMENTI MI POSSO PIANTARE

;LEGGO DA TASTEIERA

MOV AH, 1
MOV CX, dim
XOR BX, BX

leggo1:            
    INT 21H
    CMP AL, 13               ;se invio passo alla riga 2
    JZ leggo2_prepar
    MOV prima_riga[BX], AL   ;altrimenti leggo
    INC lunghezza_riga1
    DEC CX
    INC BX
    CMP CX, 0
    JZ leggo2_prepar
    JMP leggo1
             
leggo2_prepar:
    CMP CX, 31               ;CONTROLLO SU RIGA 1 - se ho inserito un numero
    JA short                 ;<=19 di caratteri non rispetto la specifica
    XOR BX, BX
    MOV CX, dim
    MOV AH, 2                ;A CAPO
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    MOV AH, 1                ;PREPARO PER IMPUT
    
leggo2:
    INT 21H
    CMP AL, 13               ;se invio passo alla riga 2
    JZ leggo3_prepar
    MOV seconda_riga[BX], AL ;altrimenti leggo
    INC lunghezza_riga2
    DEC CX
    INC BX
    CMP CX, 0
    JZ leggo3_prepar
    JMP leggo2
    
leggo3_prepar:
    CMP CX, 31               ;CONTROLLO SU RIGA 2 - se ho inserito un numero
    JA short                 ;<=19 di caratteri non rispetto la specifica
    XOR BX, BX
    MOV CX, dim
    MOV AH, 2                ;A CAPO
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    MOV AH, 1                ;PREPARO PER INT21H
    
leggo3:
    INT 21H
    CMP AL, 13               ;se invio passo alla riga 2
    JZ leggo4_prepar
    MOV terza_riga[BX], AL   ;altrimenti leggo
    INC lunghezza_riga3
    DEC CX
    INC BX
    CMP CX, 0
    JZ leggo4_prepar
    JMP leggo3
    
leggo4_prepar:
    CMP CX, 31               ;CONTROLLO SU RIGA 3 - se ho inserito un numero
    JA short                 ;<=19 di caratteri non rispetto la specifica
    XOR BX, BX
    MOV CX, dim
    MOV AH, 2                ;A CAPO
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    MOV AH, 1                ;PREPARO PER IMPUT
    
leggo4:
    INT 21H
    CMP AL, 13               ;se invio passo al punto 2. Controllo lunghezza riga 4 fatto in fine_lettura
    JZ fine_lettura
    MOV quarta_riga[BX], AL  ;altrimenti leggo
    INC lunghezza_riga4
    DEC CX
    INC BX
    CMP CX, 0
    JZ fine_lettura
    JMP leggo4

short:
    MOV AH, 2                ;A CAPO
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    MOV DL, 'e'
    INT 21H
    MOV DL, 'r'
    INT 21H
    MOV DL, 'r'
    INT 21H
    MOV DL, 'o'
    INT 21H
    MOV DL, 'r'
    INT 21H
    JMP fine 


fine_lettura:   ;secondo punto
    CMP CX, 31              ;CONTROLLO SU RIGA 4 - se ho inserito un numero
    JA short                ;<=19 di caratteri non rispetto la specifica                            ;<=19 di caratteri non rispetto la specifica
    XOR SI, SI              ;procedo con il secondo punto dell'esercizio
    XOR BX, BX
    MOV CX, dim
    
conteggio_prima_max:
    CMP CX, 0
    JZ  conteggio_seconda       ;controllo se ho controllato gia' l'intera lunghezza della riga (max 50)
    DEC CX
    
    MOV BL, prima_riga[SI]      ;prendo primo carattere
    CMP BL, 0                   ;e' uno zero?
    JZ  conteggio_seconda       ;se si significa che ho finito la riga -> passo a quella dopo
    INC SI                      
    CMP BL, 'A'
    JB  conteggio_prima_max     ;se non e' nel range passo a quella dopo
    CMP BL, 'Z'                 ;potrebbe essere una minuscola, faccio il controllo
    JA  conteggio_prima_min
    SUB BX, 'A'
    INC vett_occorrenze_max_1[BX] ;segno
    JMP conteggio_prima_max     ;passo al carattere successivo

conteggio_prima_min:
    CMP BL, 'a'
    JB conteggio_prima_max      ;Non e' nel range, passo a quella dopo
    CMP BL, 'z'
    JA conteggio_prima_max
    SUB BX, 'a'
    INC vett_occorrenze_min_1[BX] ;Se e' nel range segno nel vettore opportuno
    JMP conteggio_prima_max
    
conteggio_seconda:
    XOR SI, SI
    XOR BX, BX
    MOV CX, dim

conteggio_seconda_max:
    CMP CX, 0
    JZ  conteggio_terza           ;controllo se ho controllato gia' l'intera lunghezza della riga (max 50)
    DEC CX
    
    MOV BL, seconda_riga[SI]      ;prendo primo carattere
    CMP BL, 0                     ;e' uno zero?
    JZ  conteggio_terza           ;se si significa che ho finito la riga -> passo a quella dopo
    INC SI                      
    CMP BL, 'A'
    JB  conteggio_seconda_max     ;se non e' nel range passo a quella dopo
    CMP BL, 'Z'                   ;potrebbe essere una minuscola, faccio il controllo
    JA  conteggio_seconda_min
    SUB BX, 'A'
    INC vett_occorrenze_max_2[BX]   ;segno
    JMP conteggio_seconda_max     ;passo al carattere successivo

conteggio_seconda_min:
    CMP BL, 'a'
    JB conteggio_seconda_max      ;Non e' nel range, passo a quella dopo
    CMP BL, 'z'
    JA conteggio_seconda_max
    SUB BX, 'a'
    INC vett_occorrenze_min_2[BX]   ;Se e' nel range segno nel vettore opportuno
    JMP conteggio_seconda_max

conteggio_terza:
    XOR SI, SI
    XOR BX, BX
    MOV CX, dim

conteggio_terza_max:
    CMP CX, 0
    JZ  conteggio_quarta          ;controllo se ho controllato gia' l'intera lunghezza della riga (max 50)
    DEC CX
    
    MOV BL, terza_riga[SI]      ;prendo primo carattere
    CMP BL, 0                     ;e' uno zero?
    JZ  conteggio_quarta           ;se si significa che ho finito la riga -> passo a quella dopo
    INC SI                      
    CMP BL, 'A'
    JB  conteggio_terza_max     ;se non e' nel range passo a quella dopo
    CMP BL, 'Z'                   ;potrebbe essere una minuscola, faccio il controllo
    JA  conteggio_terza_min
    SUB BX, 'A'
    INC vett_occorrenze_max_3[BX]   ;segno
    JMP conteggio_terza_max     ;passo al carattere successivo

conteggio_terza_min:
    CMP BL, 'a'
    JB conteggio_terza_max      ;Non e' nel range, passo a quella dopo
    CMP BL, 'z'
    JA conteggio_terza_max
    SUB BX, 'a'
    INC vett_occorrenze_min_3[BX]   ;Se e' nel range segno nel vettore opportuno
    JMP conteggio_terza_max

conteggio_quarta:
    XOR SI, SI
    XOR BX, BX
    MOV CX, dim

conteggio_quarta_max:
    CMP CX, 0
    JZ  stampa_res               ;controllo se ho controllato gia' l'intera lunghezza della riga (max 50)
    DEC CX
    
    MOV BL, quarta_riga[SI]      ;prendo primo carattere
    CMP BL, 0                    ;e' uno zero?
    JZ  stampa_res               ;se si significa che ho finito la riga -> passo a stampa
    INC SI                      
    CMP BL, 'A'
    JB  conteggio_quarta_max     ;se non e' nel range passo a quella dopo
    CMP BL, 'Z'                  ;potrebbe essere una minuscola, faccio il controllo
    JA  conteggio_quarta_min
    SUB BX, 'A'
    INC vett_occorrenze_max_4[BX] ;segno
    JMP conteggio_quarta_max     ;passo al carattere successivo

conteggio_quarta_min:
    CMP BL, 'a'
    JB conteggio_quarta_max      ;Non e' nel range, passo a quella dopo
    CMP BL, 'z'
    JA conteggio_quarta_max
    SUB BX, 'a'
    INC vett_occorrenze_min_4[BX] ;Se e' nel range segno nel vettore opportuno
    JMP conteggio_quarta_max




stampa_res:

;dobbiamo fare una ricerca del massimo per ogni riga
    cerca1_min:
        XOR BX, BX
        XOR DX, DX
        MOV CX, 26
        ciclo1_min:
            MOV DL, vett_occorrenze_min_1[BX]   ;salvo in DL il numero di occorrenze minuscola prima riga
            CMP DL, lettera_occorr_min_1        ;confronto    
            JA nuovo_max_1_minuscola            ;Se nuovo max aggiorno, se uguali no
            INC BX
            LOOP ciclo1_min
            JMP cerca1_max                      ;finito passo a ricerca max fra maiuscole
            nuovo_max_1_minuscola:
                MOV lettera_occorr_min_1, DL
                MOV indice_min_1, BX
                INC BX
                LOOP ciclo1_min
            
    cerca1_max:
        XOR BX, BX
        XOR DX, DX
        MOV CX, 26
        ciclo1_max:
            MOV DL, vett_occorrenze_max_1[BX]   ;salvo in DL il numero di occorrenze minuscola prima riga
            CMP DL, lettera_occorr_max_1        ;confronto    
            JA nuovo_max_1_maiuscola            ;Se nuovo max aggiorno, se uguali no
            INC BX
            LOOP ciclo1_max
            JMP cerca2_min                      ;finito passo a ricerca max fra minuscola riga 2
            nuovo_max_1_maiuscola:
                MOV lettera_occorr_max_1, DL
                MOV indice_max_1, BX
                INC BX
                LOOP ciclo1_min
                
    cerca2_min:
        XOR BX, BX
        XOR DX, DX
        MOV CX, 26
        ciclo2_min:
            MOV DL, vett_occorrenze_min_2[BX]   ;salvo in DL il numero di occorrenze minuscola prima riga
            CMP DL, lettera_occorr_min_2        ;confronto    
            JA nuovo_max_2_minuscola            ;Se nuovo max aggiorno, se uguali no
            INC BX
            LOOP ciclo2_min
            JMP cerca2_max                      ;finito passo a ricerca max fra maiuscole
            nuovo_max_2_minuscola:
                MOV lettera_occorr_min_2, DL
                MOV indice_min_2, BX
                INC BX
                LOOP ciclo2_min
            
    cerca2_max:
        XOR BX, BX
        XOR DX, DX
        MOV CX, 26
        ciclo2_max:
            MOV DL, vett_occorrenze_max_2[BX]   ;salvo in DL il numero di occorrenze minuscola prima riga
            CMP DL, lettera_occorr_max_2        ;confronto    
            JA nuovo_max_2_maiuscola            ;Se nuovo max aggiorno, se uguali no
            INC BX
            LOOP ciclo2_max
            JMP cerca3_min                      ;finito passo a ricerca max fra minuscola riga 2
            nuovo_max_2_maiuscola:
                MOV lettera_occorr_max_2, DL
                MOV indice_max_2, BX
                INC BX
                LOOP ciclo2_min
                
    cerca3_min:
        XOR BX, BX
        XOR DX, DX
        MOV CX, 26
        ciclo3_min:
            MOV DL, vett_occorrenze_min_3[BX]   ;salvo in DL il numero di occorrenze minuscola prima riga
            CMP DL, lettera_occorr_min_3        ;confronto    
            JA nuovo_max_3_minuscola            ;Se nuovo max aggiorno, se uguali no
            INC BX
            LOOP ciclo3_min
            JMP cerca3_max                      ;finito passo a ricerca max fra maiuscole
            nuovo_max_3_minuscola:
                MOV lettera_occorr_min_3, DL
                MOV indice_min_3, BX
                INC BX
                LOOP ciclo3_min
            
    cerca3_max:
        XOR BX, BX
        XOR DX, DX
        MOV CX, 26
        ciclo3_max:
            MOV DL, vett_occorrenze_max_3[BX]   ;salvo in DL il numero di occorrenze minuscola prima riga
            CMP DL, lettera_occorr_max_3        ;confronto    
            JA nuovo_max_3_maiuscola            ;Se nuovo max aggiorno, se uguali no
            INC BX
            LOOP ciclo3_max
            JMP cerca4_min                      ;finito passo a ricerca max fra minuscola riga 2
            nuovo_max_3_maiuscola:
                MOV lettera_occorr_max_3, DL
                MOV indice_max_3, BX
                INC BX
                LOOP ciclo3_min
                
    cerca4_min:
        XOR BX, BX
        XOR DX, DX
        MOV CX, 26
        ciclo4_min:
            MOV DL, vett_occorrenze_min_4[BX]   ;salvo in DL il numero di occorrenze minuscola prima riga
            CMP DL, lettera_occorr_min_4        ;confronto    
            JA nuovo_max_4_minuscola            ;Se nuovo max aggiorno, se uguali no
            INC BX
            LOOP ciclo4_min
            JMP cerca4_max                      ;finito passo a ricerca max fra maiuscole
            nuovo_max_4_minuscola:
                MOV lettera_occorr_min_4, DL
                MOV indice_min_4, BX
                INC BX
                LOOP ciclo4_min
            
    cerca4_max:
        XOR BX, BX
        XOR DX, DX
        MOV CX, 26
        ciclo4_max:
            MOV DL, vett_occorrenze_max_4[BX]   ;salvo in DL il numero di occorrenze minuscola prima riga
            CMP DL, lettera_occorr_max_4        ;confronto    
            JA nuovo_max_4_maiuscola            ;Se nuovo max aggiorno, se uguali no
            INC BX
            LOOP ciclo4_max
            JMP stampa_occorr                      ;finito passo a ricerca max fra minuscola riga 2
            nuovo_max_4_maiuscola:
                MOV lettera_occorr_max_4, DL
                MOV indice_max_4, BX
                INC BX
                LOOP ciclo4_min
                

    stampa_occorr:    
            
    MOV AH, 2   ;A CAPO DUE VOLTE
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    MOV DL, 'O'
    INT 21H
    MOV DL, 'C'
    INT 21H
    MOV DL, 'C'
    INT 21H
    MOV DL, 'O'
    INT 21H
    MOV DL, 'R'
    INT 21H
    MOV DL, 'R'
    INT 21H
    MOV DL, 'E'
    INT 21H
    MOV DL, 'N'
    INT 21H
    MOV DL, 'Z'
    INT 21H
    MOV DL, 'E'
    INT 21H
    MOV DL, 10
    INT 21H
    MOV DL, 13
    INT 21H
    MOV CX, 26

    
;STAMPA DELLE OCCORRENZE RIGA 1 - MINUSCOLE     
    prepara_stampa_1_minuscolo:
        MOV AH, 2
        MOV DL, '1'
        INT 21H
        MOV DL, '-'
        INT 21H
        MOV DL, 'm'
        INT 21H
        MOV DL, 'i'
        INT 21H
        MOV DL, 'n'
        INT 21H    
        MOV DL, 'u'
        INT 21H
        MOV DL, 's'
        INT 21H            
        MOV DL, 'c'
        INT 21H
        MOV DL, ' '
        INT 21H            
        MOV DL, ' '
        INT 21H
        XOR BX, BX
        XOR SI, SI
        MOV CX, 26
    
    stampalo_1_minuscolo:
        MOV AL, lettera_occorr_min_1        ;carico in AL il mio MAX
        
        CMP AL, 0
        JZ  dopo_1_minuscolo                ;si poteva ottimizzare mettendo direttamente CX=0 e passando direttamente alla riga successiva
                                            ;SE NUMERO PARI, PER RISPETTARE >= DEVO DECREMENTARE IL MIO MAX/2
        MOV AH, vett_occorrenze_min_1[SI]   ;carico in AH il numero di occorrenze della lettera alla posizione SI. SI=0 -> a, SI=1 -> b... 
        SHR AL, 1                           ;divido max per2 - shift logico binario puro
        
        JC  dispari_1_minuscolo
        DEC AL
        
        dispari_1_minuscolo:
            CMP AH, AL                          ;confronto per vedere se l'elemento in posizione SI compare almeno MAX\2 volte 
            JA  stmp_1_minuscolo                ;se rispetta la specifica devo stamparlo
        dopo_1_minuscolo:   
            INC SI
            LOOP stampalo_1_minuscolo           ;passo alla lettera successiva
            JMP prepara_stampa_1_maiuscolo
        
    stmp_1_minuscolo:
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV BH, AH                          ;salvo in BH il numero di occorrenze da stampare
              
        MOV DX, SI                          ;metto il numero che identifica la lettera in DX      
        ADD DX, 'a'                          ;aggiungo l'offset della lettera, in questo caso 'a' minuscolo
        MOV AH, 2                           ;stampo carattere lettera
        INT 21H
        MOV DL, '='
        INT 21H
        
        ;ora devo stampare il numero delle occorrenze che e' memorizzato in BH
        ;devo fare delle divisioni successive per 10 e stampare cifra per cifra in ascii
        
        MOV AL, BH  ;preparo il numero da stampare in AL
        XOR CX, CX  ;CX sara' il contatore di push e pop per il ciclo successivo
        XOR AH, AH
        MOV BL, 10  ;ora dovro' effettuare delle divisioni del numero (AL) per 10 (che e' contenuto in BL) 
        
        dividi_1_minuscolo:
            DIV BL                  ;divido il contenuto di AX(num da stampare) per BL(10). Il resto finisce in AH e il risultato in AL
            CMP AL, 0               ;se il risultato e uguale a 0 allora ho finito, devo stamparlo
            JZ  stampapop_1_min     ;altrimenti continuo a dividere 
            
            INC CX                  ;incremento contatore push per capire quante cifre sto inserendo
            MOV DL, AH
            XOR DH, DH              ;ho salvato il DX il 'resto'
            PUSH DX                 ;salvo il numero nello stack
           
            XOR AH, AH              ;preparo il registro AX per la prossima divisione
            JMP dividi_1_minuscolo
            
        
        stampapop_1_min:
            MOV DL, AH
            ADD DL, '0'
            MOV AH, 2
            INT 21H           ;stampo
            CMP CX, 0
            JZ avanti_1_min
            stampapop_1_min_secondo:    ;poi tutti gli altri
                POP DX
                ADD DL, '0'
                INT 21H
                LOOP stampapop_1_min_secondo
            
        avanti_1_min:
            MOV DL, ' '
            MOV AH, 2
            INT 21H
              
        POP DX
        POP CX
        POP BX
        POP AX
        INC SI
        LOOP stampalo_1_minuscolo
    
          

;STAMPA DELLE OCCORRENZE RIGA 1 - MAIUSCOLE       
    prepara_stampa_1_maiuscolo:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        MOV DL, '1'
        INT 21H
        MOV DL, '-'
        INT 21H
        MOV DL, 'm'
        INT 21H
        MOV DL, 'a'
        INT 21H
        MOV DL, 'i'
        INT 21H    
        MOV DL, 'u'
        INT 21H
        MOV DL, 's'
        INT 21H            
        MOV DL, 'c'
        INT 21H
        MOV DL, ' '
        INT 21H            
        MOV DL, ' '
        INT 21H
        XOR BX, BX
        XOR SI, SI
        MOV CX, 26
                  
    stampalo_1_maiuscolo:
        MOV AL, lettera_occorr_max_1        ;carico in AL il mio MAX
        
        CMP AL, 0
        JZ  dopo_1_maiuscolo                ;si poteva ottimizzare mettendo direttamente CX=0 e passando direttamente alla riga successiva
                                            ;SE NUMERO PARI, PER RISPETTARE >= DEVO DECREMENTARE IL MIO MAX/2
        MOV AH, vett_occorrenze_max_1[SI]   ;carico in AH il numero di occorrenze della lettera alla posizione SI. SI=0 -> a, SI=1 -> b... 
        SHR AL, 1                           ;divido max per2 - shift logico binario puro
        
        JC  dispari_1_maiuscolo
        DEC AL
        
        dispari_1_maiuscolo:
            CMP AH, AL                          ;confronto per vedere se l'elemento in posizione SI compare almeno MAX\2 volte 
            JA  stmp_1_maiuscolo                ;se rispetta la specifica devo stamparlo
        dopo_1_maiuscolo:   
            INC SI
            LOOP stampalo_1_maiuscolo           ;passo alla lettera successiva
            JMP prepara_stampa_2_minuscolo
        
    stmp_1_maiuscolo:
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV BH, AH                          ;salvo in BH il numero di occorrenze da stampare
              
        MOV DX, SI                          ;metto il numero che identifica la lettera in DX      
        ADD DX, 'A'                          ;aggiungo l'offset della lettera, in questo caso 'a' minuscolo
        MOV AH, 2                           ;stampo carattere lettera
        INT 21H
        MOV DL, '='
        INT 21H
        
        ;ora devo stampare il numero delle occorrenze che e' memorizzato in BH
        ;devo fare delle divisioni successive per 10 e stampare cifra per cifra in ascii
        
        MOV AL, BH  ;preparo il numero da stampare in AL
        XOR CX, CX  ;CX sara' il contatore di push e pop per il ciclo successivo
        XOR AH, AH
        MOV BL, 10  ;ora dovro' effettuare delle divisioni del numero (AL) per 10 (che e' contenuto in BL) 
        
        dividi_1_maiuscolo:
            DIV BL                  ;divido il contenuto di AX(num da stampare) per BL(10). Il resto finisce in AH e il risultato in AL
            CMP AL, 0               ;se il risultato e uguale a 0 allora ho finito, devo stamparlo
            JZ  stampapop_1_max     ;altrimenti continuo a dividere 
            
            INC CX                  ;incremento contatore push per capire quante cifre sto inserendo
            MOV DL, AH
            XOR DH, DH              ;ho salvato il DX il 'resto'
            PUSH DX                 ;salvo il numero nello stack
           
            XOR AH, AH              ;preparo il registro AX per la prossima divisione
            JMP dividi_1_maiuscolo
            
        
        stampapop_1_max:
            MOV DL, AH
            ADD DL, '0'
            MOV AH, 2
            INT 21H           ;stampo
            CMP CX, 0
            JZ avanti_1_max
            stampapop_1_max_secondo:    ;poi tutti gli altri
                POP DX
                ADD DL, '0'
                INT 21H
                LOOP stampapop_1_max_secondo
            
        avanti_1_max:
            MOV DL, ' '
            MOV AH, 2
            INT 21H
              
        POP DX
        POP CX
        POP BX
        POP AX
        INC SI
        LOOP stampalo_1_maiuscolo                  
                           
                           
                           
;STAMPA DELLE OCCORRENZE RIGA 2 - MINUSCOLE                            
    prepara_stampa_2_minuscolo:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        MOV DL, '2'
        INT 21H
        MOV DL, '-'
        INT 21H
        MOV DL, 'm'
        INT 21H
        MOV DL, 'i'
        INT 21H
        MOV DL, 'n'
        INT 21H    
        MOV DL, 'u'
        INT 21H
        MOV DL, 's'
        INT 21H            
        MOV DL, 'c'
        INT 21H
        MOV DL, ' '
        INT 21H            
        MOV DL, ' '
        INT 21H
        XOR BX, BX
        XOR SI, SI
        MOV CX, 26
                  
    stampalo_2_minuscolo:
        MOV AL, lettera_occorr_min_2        ;carico in AL il mio MAX
        
        CMP AL, 0
        JZ  dopo_2_minuscolo                ;si poteva ottimizzare mettendo direttamente CX=0 e passando direttamente alla riga successiva
                                            ;SE NUMERO PARI, PER RISPETTARE >= DEVO DECREMENTARE IL MIO MAX/2
        MOV AH, vett_occorrenze_min_2[SI]   ;carico in AH il numero di occorrenze della lettera alla posizione SI. SI=0 -> a, SI=1 -> b... 
        SHR AL, 1                           ;divido max per2 - shift logico binario puro
        
        JC  dispari_2_minuscolo
        DEC AL
        
        dispari_2_minuscolo:
            CMP AH, AL                          ;confronto per vedere se l'elemento in posizione SI compare almeno MAX\2 volte 
            JA  stmp_2_minuscolo                ;se rispetta la specifica devo stamparlo
        dopo_2_minuscolo:   
            INC SI
            LOOP stampalo_2_minuscolo           ;passo alla lettera successiva
            JMP prepara_stampa_2_maiuscolo
        
    stmp_2_minuscolo:
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV BH, AH                          ;salvo in BH il numero di occorrenze da stampare
              
        MOV DX, SI                          ;metto il numero che identifica la lettera in DX      
        ADD DX, 'a'                          ;aggiungo l'offset della lettera, in questo caso 'a' minuscolo
        MOV AH, 2                           ;stampo carattere lettera
        INT 21H
        MOV DL, '='
        INT 21H
        
        ;ora devo stampare il numero delle occorrenze che e' memorizzato in BH
        ;devo fare delle divisioni successive per 10 e stampare cifra per cifra in ascii
        
        MOV AL, BH  ;preparo il numero da stampare in AL
        XOR CX, CX  ;CX sara' il contatore di push e pop per il ciclo successivo
        XOR AH, AH
        MOV BL, 10  ;ora dovro' effettuare delle divisioni del numero (AL) per 10 (che e' contenuto in BL) 
        
        dividi_2_minuscolo:
            DIV BL                  ;divido il contenuto di AX(num da stampare) per BL(10). Il resto finisce in AH e il risultato in AL
            CMP AL, 0               ;se il risultato e uguale a 0 allora ho finito, devo stamparlo
            JZ  stampapop_2_min     ;altrimenti continuo a dividere 
            
            INC CX                  ;incremento contatore push per capire quante cifre sto inserendo
            MOV DL, AH
            XOR DH, DH              ;ho salvato il DX il 'resto'
            PUSH DX                 ;salvo il numero nello stack
           
            XOR AH, AH              ;preparo il registro AX per la prossima divisione
            JMP dividi_2_minuscolo
            
        
        stampapop_2_min:
            MOV DL, AH
            ADD DL, '0'
            MOV AH, 2
            INT 21H           ;stampo
            CMP CX, 0
            JZ avanti_2_min
            stampapop_2_min_secondo:    ;poi tutti gli altri
                POP DX
                ADD DL, '0'
                INT 21H
                LOOP stampapop_2_min_secondo
            
        avanti_2_min:
            MOV DL, ' '
            MOV AH, 2
            INT 21H
              
        POP DX
        POP CX
        POP BX
        POP AX
        INC SI
        LOOP stampalo_2_minuscolo 
                     
                     
        
;STAMPA DELLE OCCORRENZE RIGA 2 - MAIUSCOLE         
    prepara_stampa_2_maiuscolo:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        MOV DL, '2'
        INT 21H
        MOV DL, '-'
        INT 21H
        MOV DL, 'm'
        INT 21H
        MOV DL, 'a'
        INT 21H
        MOV DL, 'i'
        INT 21H    
        MOV DL, 'u'
        INT 21H
        MOV DL, 's'
        INT 21H            
        MOV DL, 'c'
        INT 21H
        MOV DL, ' '
        INT 21H            
        MOV DL, ' '
        INT 21H
        XOR BX, BX
        XOR SI, SI
        MOV CX, 26
                  
    stampalo_2_maiuscolo:
        MOV AL, lettera_occorr_max_2        ;carico in AL il mio MAX
        
        CMP AL, 0
        JZ  dopo_2_maiuscolo                ;si poteva ottimizzare mettendo direttamente CX=0 e passando direttamente alla riga successiva
                                            ;SE NUMERO PARI, PER RISPETTARE >= DEVO DECREMENTARE IL MIO MAX/2
        MOV AH, vett_occorrenze_max_2[SI]   ;carico in AH il numero di occorrenze della lettera alla posizione SI. SI=0 -> a, SI=1 -> b... 
        SHR AL, 1                           ;divido max per2 - shift logico binario puro
        
        JC  dispari_2_maiuscolo
        DEC AL
        
        dispari_2_maiuscolo:
            CMP AH, AL                          ;confronto per vedere se l'elemento in posizione SI compare almeno MAX\2 volte 
            JA  stmp_2_maiuscolo                ;se rispetta la specifica devo stamparlo
        dopo_2_maiuscolo:   
            INC SI
            LOOP stampalo_2_maiuscolo           ;passo alla lettera successiva
            JMP prepara_stampa_3_minuscolo
        
    stmp_2_maiuscolo:
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV BH, AH                          ;salvo in BH il numero di occorrenze da stampare
              
        MOV DX, SI                          ;metto il numero che identifica la lettera in DX      
        ADD DX, 'A'                          ;aggiungo l'offset della lettera, in questo caso 'a' minuscolo
        MOV AH, 2                           ;stampo carattere lettera
        INT 21H
        MOV DL, '='
        INT 21H
        
        ;ora devo stampare il numero delle occorrenze che e' memorizzato in BH
        ;devo fare delle divisioni successive per 10 e stampare cifra per cifra in ascii
        
        MOV AL, BH  ;preparo il numero da stampare in AL
        XOR CX, CX  ;CX sara' il contatore di push e pop per il ciclo successivo
        XOR AH, AH
        MOV BL, 10  ;ora dovro' effettuare delle divisioni del numero (AL) per 10 (che e' contenuto in BL) 
        
        dividi_2_maiuscolo:
            DIV BL                  ;divido il contenuto di AX(num da stampare) per BL(10). Il resto finisce in AH e il risultato in AL
            CMP AL, 0               ;se il risultato e uguale a 0 allora ho finito, devo stamparlo
            JZ  stampapop_2_max     ;altrimenti continuo a dividere 
            
            INC CX                  ;incremento contatore push per capire quante cifre sto inserendo
            MOV DL, AH
            XOR DH, DH              ;ho salvato il DX il 'resto'
            PUSH DX                 ;salvo il numero nello stack
           
            XOR AH, AH              ;preparo il registro AX per la prossima divisione
            JMP dividi_2_maiuscolo
            
        
        stampapop_2_max:
            MOV DL, AH
            ADD DL, '0'
            MOV AH, 2
            INT 21H           ;stampo
            CMP CX, 0
            JZ avanti_2_max
            stampapop_2_max_secondo:    ;poi tutti gli altri
                POP DX
                ADD DL, '0'
                INT 21H
                LOOP stampapop_2_max_secondo
            
        avanti_2_max:
            MOV DL, ' '
            MOV AH, 2
            INT 21H
              
        POP DX
        POP CX
        POP BX
        POP AX
        INC SI
        LOOP stampalo_2_maiuscolo
              
              
              
;STAMPA DELLE OCCORRENZE RIGA 3 - MINUSCOLE         
    prepara_stampa_3_minuscolo:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        MOV DL, '3'
        INT 21H
        MOV DL, '-'
        INT 21H
        MOV DL, 'm'
        INT 21H
        MOV DL, 'i'
        INT 21H
        MOV DL, 'n'
        INT 21H    
        MOV DL, 'u'
        INT 21H
        MOV DL, 's'
        INT 21H            
        MOV DL, 'c'
        INT 21H
        MOV DL, ' '
        INT 21H            
        MOV DL, ' '
        INT 21H
        XOR BX, BX
        XOR SI, SI
        MOV CX, 26
                  
    stampalo_3_minuscolo:
        MOV AL, lettera_occorr_min_3        ;carico in AL il mio MAX
        
        CMP AL, 0
        JZ  dopo_3_minuscolo                ;si poteva ottimizzare mettendo direttamente CX=0 e passando direttamente alla riga successiva
                                            ;SE NUMERO PARI, PER RISPETTARE >= DEVO DECREMENTARE IL MIO MAX/2
        MOV AH, vett_occorrenze_min_3[SI]   ;carico in AH il numero di occorrenze della lettera alla posizione SI. SI=0 -> a, SI=1 -> b... 
        SHR AL, 1                           ;divido max per2 - shift logico binario puro
        
        JC  dispari_3_minuscolo
        DEC AL
        
        dispari_3_minuscolo:
            CMP AH, AL                          ;confronto per vedere se l'elemento in posizione SI compare almeno MAX\2 volte 
            JA  stmp_3_minuscolo                ;se rispetta la specifica devo stamparlo
        dopo_3_minuscolo:   
            INC SI
            LOOP stampalo_3_minuscolo           ;passo alla lettera successiva
            JMP prepara_stampa_3_maiuscolo
        
    stmp_3_minuscolo:
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV BH, AH                          ;salvo in BH il numero di occorrenze da stampare
              
        MOV DX, SI                          ;metto il numero che identifica la lettera in DX      
        ADD DX, 'a'                          ;aggiungo l'offset della lettera, in questo caso 'a' minuscolo
        MOV AH, 2                           ;stampo carattere lettera
        INT 21H
        MOV DL, '='
        INT 21H
        
        ;ora devo stampare il numero delle occorrenze che e' memorizzato in BH
        ;devo fare delle divisioni successive per 10 e stampare cifra per cifra in ascii
        
        MOV AL, BH  ;preparo il numero da stampare in AL
        XOR CX, CX  ;CX sara' il contatore di push e pop per il ciclo successivo
        XOR AH, AH
        MOV BL, 10  ;ora dovro' effettuare delle divisioni del numero (AL) per 10 (che e' contenuto in BL) 
        
        dividi_3_minuscolo:
            DIV BL                  ;divido il contenuto di AX(num da stampare) per BL(10). Il resto finisce in AH e il risultato in AL
            CMP AL, 0               ;se il risultato e uguale a 0 allora ho finito, devo stamparlo
            JZ  stampapop_3_min     ;altrimenti continuo a dividere 
            
            INC CX                  ;incremento contatore push per capire quante cifre sto inserendo
            MOV DL, AH
            XOR DH, DH              ;ho salvato il DX il 'resto'
            PUSH DX                 ;salvo il numero nello stack
           
            XOR AH, AH              ;preparo il registro AX per la prossima divisione
            JMP dividi_3_minuscolo
            
        
        stampapop_3_min:
            MOV DL, AH
            ADD DL, '0'
            MOV AH, 2
            INT 21H           ;stampo
            CMP CX, 0
            JZ avanti_3_min
            stampapop_3_min_secondo:    ;poi tutti gli altri
                POP DX
                ADD DL, '0'
                INT 21H
                LOOP stampapop_3_min_secondo
            
        avanti_3_min:
            MOV DL, ' '
            MOV AH, 2
            INT 21H
              
        POP DX
        POP CX
        POP BX
        POP AX
        INC SI
        LOOP stampalo_3_minuscolo
                     
                               
                               
;STAMPA DELLE OCCORRENZE RIGA 3 - MAIUSCOLE                                
    prepara_stampa_3_maiuscolo:                               
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        MOV DL, '3'
        INT 21H
        MOV DL, '-'
        INT 21H
        MOV DL, 'm'
        INT 21H
        MOV DL, 'a'
        INT 21H
        MOV DL, 'i'
        INT 21H    
        MOV DL, 'u'
        INT 21H
        MOV DL, 's'
        INT 21H            
        MOV DL, 'c'
        INT 21H
        MOV DL, ' '
        INT 21H            
        MOV DL, ' '
        INT 21H
        XOR BX, BX
        XOR SI, SI
        MOV CX, 26
                  
    stampalo_3_maiuscolo:
        MOV AL, lettera_occorr_max_3        ;carico in AL il mio MAX
        
        CMP AL, 0
        JZ  dopo_3_maiuscolo                ;si poteva ottimizzare mettendo direttamente CX=0 e passando direttamente alla riga successiva
                                            ;SE NUMERO PARI, PER RISPETTARE >= DEVO DECREMENTARE IL MIO MAX/2
        MOV AH, vett_occorrenze_max_3[SI]   ;carico in AH il numero di occorrenze della lettera alla posizione SI. SI=0 -> a, SI=1 -> b... 
        SHR AL, 1                           ;divido max per2 - shift logico binario puro
        
        JC  dispari_3_maiuscolo
        DEC AL
        
        dispari_3_maiuscolo:
            CMP AH, AL                          ;confronto per vedere se l'elemento in posizione SI compare almeno MAX\2 volte 
            JA  stmp_3_maiuscolo                ;se rispetta la specifica devo stamparlo
        dopo_3_maiuscolo:   
            INC SI
            LOOP stampalo_3_maiuscolo           ;passo alla lettera successiva
            JMP prepara_stampa_4_minuscolo
        
    stmp_3_maiuscolo:
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV BH, AH                          ;salvo in BH il numero di occorrenze da stampare
              
        MOV DX, SI                          ;metto il numero che identifica la lettera in DX      
        ADD DX, 'A'                          ;aggiungo l'offset della lettera, in questo caso 'a' minuscolo
        MOV AH, 2                           ;stampo carattere lettera
        INT 21H
        MOV DL, '='
        INT 21H
        
        ;ora devo stampare il numero delle occorrenze che e' memorizzato in BH
        ;devo fare delle divisioni successive per 10 e stampare cifra per cifra in ascii
        
        MOV AL, BH  ;preparo il numero da stampare in AL
        XOR CX, CX  ;CX sara' il contatore di push e pop per il ciclo successivo
        XOR AH, AH
        MOV BL, 10  ;ora dovro' effettuare delle divisioni del numero (AL) per 10 (che e' contenuto in BL) 
        
        dividi_3_maiuscolo:
            DIV BL                  ;divido il contenuto di AX(num da stampare) per BL(10). Il resto finisce in AH e il risultato in AL
            CMP AL, 0               ;se il risultato e uguale a 0 allora ho finito, devo stamparlo
            JZ  stampapop_3_max     ;altrimenti continuo a dividere 
            
            INC CX                  ;incremento contatore push per capire quante cifre sto inserendo
            MOV DL, AH
            XOR DH, DH              ;ho salvato il DX il 'resto'
            PUSH DX                 ;salvo il numero nello stack
           
            XOR AH, AH              ;preparo il registro AX per la prossima divisione
            JMP dividi_3_maiuscolo
            
        
        stampapop_3_max:
            MOV DL, AH
            ADD DL, '0'
            MOV AH, 2
            INT 21H           ;stampo
            CMP CX, 0
            JZ avanti_3_max
            stampapop_3_max_secondo:    ;poi tutti gli altri
                POP DX
                ADD DL, '0'
                INT 21H
                LOOP stampapop_3_max_secondo
            
        avanti_3_max:
            MOV DL, ' '
            MOV AH, 2
            INT 21H
              
        POP DX
        POP CX
        POP BX
        POP AX
        INC SI
        LOOP stampalo_3_maiuscolo
                                   
                                   
        
;STAMPA DELLE OCCORRENZE RIGA 4 - MINUSCOLE        
    prepara_stampa_4_minuscolo:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        MOV DL, '4'
        INT 21H
        MOV DL, '-'
        INT 21H
        MOV DL, 'm'
        INT 21H
        MOV DL, 'i'
        INT 21H
        MOV DL, 'n'
        INT 21H    
        MOV DL, 'u'
        INT 21H
        MOV DL, 's'
        INT 21H            
        MOV DL, 'c'
        INT 21H
        MOV DL, ' '
        INT 21H            
        MOV DL, ' '
        INT 21H
        XOR BX, BX
        XOR SI, SI
        MOV CX, 26
                  
    stampalo_4_minuscolo:
        MOV AL, lettera_occorr_min_4        ;carico in AL il mio MAX
        
        CMP AL, 0
        JZ  dopo_4_minuscolo                ;si poteva ottimizzare mettendo direttamente CX=0 e passando direttamente alla riga successiva
                                            ;SE NUMERO PARI, PER RISPETTARE >= DEVO DECREMENTARE IL MIO MAX/2
        MOV AH, vett_occorrenze_min_4[SI]   ;carico in AH il numero di occorrenze della lettera alla posizione SI. SI=0 -> a, SI=1 -> b... 
        SHR AL, 1                           ;divido max per2 - shift logico binario puro
        
        JC  dispari_4_minuscolo
        DEC AL
        
        dispari_4_minuscolo:
            CMP AH, AL                          ;confronto per vedere se l'elemento in posizione SI compare almeno MAX\2 volte 
            JA  stmp_4_minuscolo                ;se rispetta la specifica devo stamparlo
        dopo_4_minuscolo:   
            INC SI
            LOOP stampalo_4_minuscolo           ;passo alla lettera successiva
            JMP prepara_stampa_4_maiuscolo
        
    stmp_4_minuscolo:
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV BH, AH                          ;salvo in BH il numero di occorrenze da stampare
              
        MOV DX, SI                          ;metto il numero che identifica la lettera in DX      
        ADD DX, 'a'                          ;aggiungo l'offset della lettera, in questo caso 'a' minuscolo
        MOV AH, 2                           ;stampo carattere lettera
        INT 21H
        MOV DL, '='
        INT 21H
        
        ;ora devo stampare il numero delle occorrenze che e' memorizzato in BH
        ;devo fare delle divisioni successive per 10 e stampare cifra per cifra in ascii
        
        MOV AL, BH  ;preparo il numero da stampare in AL
        XOR CX, CX  ;CX sara' il contatore di push e pop per il ciclo successivo
        XOR AH, AH
        MOV BL, 10  ;ora dovro' effettuare delle divisioni del numero (AL) per 10 (che e' contenuto in BL) 
        
        dividi_4_minuscolo:
            DIV BL                  ;divido il contenuto di AX(num da stampare) per BL(10). Il resto finisce in AH e il risultato in AL
            CMP AL, 0               ;se il risultato e uguale a 0 allora ho finito, devo stamparlo
            JZ  stampapop_4_min     ;altrimenti continuo a dividere 
            
            INC CX                  ;incremento contatore push per capire quante cifre sto inserendo
            MOV DL, AH
            XOR DH, DH              ;ho salvato il DX il 'resto'
            PUSH DX                 ;salvo il numero nello stack
           
            XOR AH, AH              ;preparo il registro AX per la prossima divisione
            JMP dividi_4_minuscolo
            
        
        stampapop_4_min:
            MOV DL, AH
            ADD DL, '0'
            MOV AH, 2
            INT 21H           ;stampo
            CMP CX, 0
            JZ avanti_4_min
            stampapop_4_min_secondo:    ;poi tutti gli altri
                POP DX
                ADD DL, '0'
                INT 21H
                LOOP stampapop_4_min_secondo
            
        avanti_4_min:
            MOV DL, ' '
            MOV AH, 2
            INT 21H
              
        POP DX
        POP CX
        POP BX
        POP AX
        INC SI
        LOOP stampalo_4_minuscolo                                   
                                    
                                    
                                    
;STAMPA DELLE OCCORRENZE RIGA 4 - MAIUSCOLE     
    prepara_stampa_4_maiuscolo:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        MOV DL, '4'
        INT 21H
        MOV DL, '-'
        INT 21H
        MOV DL, 'm'
        INT 21H
        MOV DL, 'a'
        INT 21H
        MOV DL, 'i'
        INT 21H    
        MOV DL, 'u'
        INT 21H
        MOV DL, 's'
        INT 21H            
        MOV DL, 'c'
        INT 21H
        MOV DL, ' '
        INT 21H            
        MOV DL, ' '
        INT 21H
        XOR BX, BX
        XOR SI, SI
        MOV CX, 26
                  
    stampalo_4_maiuscolo:
        MOV AL, lettera_occorr_max_4        ;carico in AL il mio MAX
        
        CMP AL, 0
        JZ  dopo_4_maiuscolo                ;si poteva ottimizzare mettendo direttamente CX=0 e passando direttamente alla riga successiva
                                            ;SE NUMERO PARI, PER RISPETTARE >= DEVO DECREMENTARE IL MIO MAX/2
        MOV AH, vett_occorrenze_max_4[SI]   ;carico in AH il numero di occorrenze della lettera alla posizione SI. SI=0 -> a, SI=1 -> b... 
        SHR AL, 1                           ;divido max per2 - shift logico binario puro
        
        JC  dispari_4_maiuscolo
        DEC AL
        
        dispari_4_maiuscolo:
            CMP AH, AL                          ;confronto per vedere se l'elemento in posizione SI compare almeno MAX\2 volte 
            JA  stmp_4_maiuscolo                ;se rispetta la specifica devo stamparlo
        dopo_4_maiuscolo:   
            INC SI
            LOOP stampalo_4_maiuscolo           ;passo alla lettera successiva
            JMP algoritmo_crittografico           ;passo al punto successivo 
        
    stmp_4_maiuscolo:
        PUSH AX
        PUSH BX
        PUSH CX
        PUSH DX
        
        MOV BH, AH                          ;salvo in BH il numero di occorrenze da stampare
              
        MOV DX, SI                          ;metto il numero che identifica la lettera in DX      
        ADD DX, 'A'                          ;aggiungo l'offset della lettera, in questo caso 'a' minuscolo
        MOV AH, 2                           ;stampo carattere lettera
        INT 21H
        MOV DL, '='
        INT 21H
        
        ;ora devo stampare il numero delle occorrenze che e' memorizzato in BH
        ;devo fare delle divisioni successive per 10 e stampare cifra per cifra in ascii
        
        MOV AL, BH  ;preparo il numero da stampare in AL
        XOR CX, CX  ;CX sara' il contatore di push e pop per il ciclo successivo
        XOR AH, AH
        MOV BL, 10  ;ora dovro' effettuare delle divisioni del numero (AL) per 10 (che e' contenuto in BL) 
        
        dividi_4_maiuscolo:
            DIV BL                  ;divido il contenuto di AX(num da stampare) per BL(10). Il resto finisce in AH e il risultato in AL
            CMP AL, 0               ;se il risultato e uguale a 0 allora ho finito, devo stamparlo
            JZ  stampapop_4_max     ;altrimenti continuo a dividere 
            
            INC CX                  ;incremento contatore push per capire quante cifre sto inserendo
            MOV DL, AH
            XOR DH, DH              ;ho salvato il DX il 'resto'
            PUSH DX                 ;salvo il numero nello stack
           
            XOR AH, AH              ;preparo il registro AX per la prossima divisione
            JMP dividi_4_maiuscolo
            
        
        stampapop_4_max:
            MOV DL, AH
            ADD DL, '0'
            MOV AH, 2
            INT 21H                     ;stampo
            CMP CX, 0
            JZ avanti_4_max
            stampapop_4_max_secondo:    ;poi tutti gli altri
                POP DX
                ADD DL, '0'
                INT 21H
                LOOP stampapop_3_max_secondo
            
        avanti_4_max:
            MOV DL, ' '
            MOV AH, 2
            INT 21H
              
        POP DX
        POP CX
        POP BX
        POP AX
        INC SI
        LOOP stampalo_4_maiuscolo

                      
                      
    ;PUNTO 3, ALGORITMO CRITTOGRAFICO - CIFRARIO DI CESARE                  
    algoritmo_crittografico:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        MOV DL, 'C'
        INT 21H
        MOV DL, 'E'
        INT 21H
        MOV DL, 'S'
        INT 21H
        MOV DL, 'A'
        INT 21H
        MOV DL, 'R'
        INT 21H    
        MOV DL, 'E'
        INT 21H
        MOV DL, '-'
        INT 21H            
        MOV DL, 'C'
        INT 21H
        MOV DL, 'R'
        INT 21H
        MOV DL, 'I'
        INT 21H
        MOV DL, 'P'
        INT 21H
        MOV DL, 'T'
        INT 21H
        MOV DL, 'O'
        INT 21H
        
    cripta_riga1:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        
        XOR CH, CH
        MOV CL, lunghezza_riga1
        XOR SI, SI
        XOR DX, DX
        leggo_carattere_1:
            MOV DL, prima_riga[SI]          ;prendo il carattere dalla riga  
            
            CMP DL, 'Z'
            JA  confronto_se_minuscola1
            CMP DL, 'A'
            JB  stampa_cripto_1             ;se non e' una lettera allora la stampo
            
            ADD DL, 1                       ;sommo k=1 al carattere interessato
            CMP DL, 'Z'+1
            JB stampa_cripto_1              ;se sono ancora nel range giusto -> stampo
                                            ;altrimenti mi sposto nel range delle lettere minuscole
            ADD DL, 'a'-'Z'-1               ;sommando l'offset ascii corretto
            JMP stampa_cripto_1
            
            confronto_se_minuscola1:
                CMP DL, 'a'
                JB stampa_cripto_1          ;se e' nel range fra Z e a allora lo stampo direttamente (no lettera)
                CMP DL, 'z'
                JA stampa_cripto_1          ;se e' > del range minuscole allora lo stampo (no lettera)
                ADD DL, 1                   ;sommo k=1 al carattere interessato - se sono qui e' perche' ho una minuscola
                CMP DL, 'z'+1
                JB stampa_cripto_1          ;se dopo la somma del k sono ancora nel range minuscole -> stampo
                                            ;altrimenti riconduco offset a quello delle Maiuscole
                ADD DL, 'A'-'z'-1
                            
            stampa_cripto_1:
                MOV AH, 2
                INT 21H        
            
            INC SI                          ;passo al carattere successivo
            LOOP leggo_carattere_1   
         
    
    cripta_riga2:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        
        XOR CH, CH
        MOV CL, lunghezza_riga2
        XOR SI, SI
        XOR DX, DX
        leggo_carattere_2:
            MOV DL, seconda_riga[SI]        ;prendo il carattere dalla riga  
            
            CMP DL, 'Z'
            JA  confronto_se_minuscola2
            CMP DL, 'A'
            JB  stampa_cripto_2             ;se non e' una lettera allora la stampo
                                        
            ADD DL, 2                       ;sommo k=2 al carattere interessato
            CMP DL, 'Z'+1                    ;;;;;;;;;;
            JB stampa_cripto_2              ;se sono ancora nel range giusto -> stampo
                                            ;altrimenti mi sposto nel range delle lettere minuscole
            ADD DL, 'a'-'Z'-1               ;sommando l'offset ascii corretto
            JMP stampa_cripto_2
            
            confronto_se_minuscola2:
                CMP DL, 'a'
                JB stampa_cripto_2          ;se e' nel range fra Z e a allora lo stampo direttamente (no lettera)
                CMP DL, 'z'
                JA stampa_cripto_2          ;se e' > del range minuscole allora lo stampo (no lettera)
                ADD DL, 2                   ;sommo k=2 al carattere interessato - se sono qui e' perche' ho una minuscola
                CMP DL, 'z'+1                 ;;;;
                JB stampa_cripto_2          ;se dopo la somma del k sono ancora nel range minuscole -> stampo
                                            ;altrimenti riconduco offset a quello delle Maiuscole
                ADD DL, 'A'-'z'-1
                            
            stampa_cripto_2:
                MOV AH, 2
                INT 21H        
            
            INC SI                          ;passo al carattere successivo
            LOOP leggo_carattere_2


cripta_riga3:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        
        XOR CH, CH
        MOV CL, lunghezza_riga3
        XOR SI, SI
        XOR DX, DX
        leggo_carattere_3:
            MOV DL, terza_riga[SI]          ;prendo il carattere dalla riga  
            
            CMP DL, 'Z'
            JA  confronto_se_minuscola3
            CMP DL, 'A'
            JB  stampa_cripto_3             ;se non e' una lettera allora la stampo
            
            ADD DL, 3                       ;sommo k=3 al carattere interessato
            CMP DL, 'Z'+1
            JB stampa_cripto_3              ;se sono ancora nel range giusto -> stampo
                                            ;altrimenti mi sposto nel range delle lettere minuscole
            ADD DL, 'a'-'Z'-1               ;sommando l'offset ascii corretto
            JMP stampa_cripto_3
            
            confronto_se_minuscola3:
                CMP DL, 'a'
                JB stampa_cripto_3          ;se e' nel range fra Z e a allora lo stampo direttamente (no lettera)
                CMP DL, 'z'
                JA stampa_cripto_3          ;se e' > del range minuscole allora lo stampo (no lettera)
                ADD DL, 3                   ;sommo k=3 al carattere interessato - se sono qui e' perche' ho una minuscola
                CMP DL, 'z'+1
                JB stampa_cripto_3          ;se dopo la somma del k sono ancora nel range minuscole -> stampo
                                            ;altrimenti riconduco offset a quello delle Maiuscole
                ADD DL, 'A'-'z'-1
                            
            stampa_cripto_3:
                MOV AH, 2
                INT 21H        
            
            INC SI                          ;passo al carattere successivo
            LOOP leggo_carattere_3


cripta_riga4:
        MOV AH, 2
        MOV DL, 10
        INT 21H
        MOV DL, 13
        INT 21H
        
        XOR CH, CH
        MOV CL, lunghezza_riga4
        XOR SI, SI
        XOR DX, DX
        leggo_carattere_4:
            MOV DL, quarta_riga[SI]          ;prendo il carattere dalla riga  
            
            CMP DL, 'Z'
            JA  confronto_se_minuscola4
            CMP DL, 'A'
            JB  stampa_cripto_4             ;se non e' una lettera allora la stampo
            
            ADD DL, 4                       ;sommo k=4 al carattere interessato
            CMP DL, 'Z'+1
            JB stampa_cripto_4              ;se sono ancora nel range giusto -> stampo
                                            ;altrimenti mi sposto nel range delle lettere minuscole
            ADD DL, 'a'-'Z'-1               ;sommando l'offset ascii corretto
            JMP stampa_cripto_4
            
            confronto_se_minuscola4:
                CMP DL, 'a'
                JB stampa_cripto_4          ;se e' nel range fra Z e a allora lo stampo direttamente (no lettera)
                CMP DL, 'z'
                JA stampa_cripto_4          ;se e' > del range minuscole allora lo stampo (no lettera)
                ADD DL, 4                   ;sommo k=4 al carattere interessato - se sono qui e' perche' ho una minuscola
                CMP DL, 'z'+1
                JB stampa_cripto_4          ;se dopo la somma del k sono ancora nel range minuscole -> stampo
                                            ;altrimenti riconduco offset a quello delle Maiuscole
                ADD DL, 'A'-'z'-1
                            
            stampa_cripto_4:
                MOV AH, 2
                INT 21H        
            
            INC SI                          ;passo al carattere successivo
            LOOP leggo_carattere_4


fine:

.EXIT
END