N EQU 4 ;righe prima matrice - A
M EQU 7 ;colonne prima matrice - righe seconda matrice B
P EQU 5 ;colonne seconda matrice - colonne matrice ris
.MODEL small
.STACK
.DATA

matrice_1   DB  3, 14, -15, 9, 26, -53, 5,       89, 79, 3, 23, 84, -6, 26,       43, -3, 83, 27, -9, 50, 28,       -88, 41, 97, -103, 69, 39, -9

matrice_2   DB  37, -101, 0, 58, -20,       9, 74, 94, -4, 59,       -23, 90, -78, 16, -4,       0, -62, 86, 20, 89,       9, 86, 28, 0, -34,       82, 5, 34, -21, 1,       70, -67, 9, 82, 14         
                                                                                  
matrice_ris DW  N*P DUP(?)

.CODE
.STARTUP

XOR SI, SI      ;COLONNA matrice 1
XOR DI, DI      ;RIGA matrice 2
MOV CX, N       ;carico in CX il numero di righe della matrice A

ciclo_cambia_riga:                    ;questo ciclo mi sposta alla riga successiva della matrice A
    PUSH SI                           ;salvo i dati nello stack
    PUSH CX
    MOV CX, P                         ;faro' il prodotto riga per P colonne della matrice B

    ciclo_cambia_colonna:             ;questo ciclo mi sposta alla colonna successiva della matrice B
        PUSH SI
        PUSH DI
        PUSH CX
        
        MOV CX, M                     ;faro' il prodotto M volte e poi sommo nell'accumulatore DX
        XOR DX, DX                    ;azzero accumulatore
        ciclo_somma:
            XOR AH, AH
            
            MOV AL, matrice_1[SI]     ;metto in AL il numero della matrice 1
            IMUL matrice_2[DI]        ;moltiplico con relativo matrice 2
            
            
            ADD DX, AX                ;sommo nell'accumulatore
            JO  overflow              ;se overflow -> correggo.  solo la somma puo' dare OF
            
            INC SI
            ADD DI, P                 ;passo al prodotto dei due elementi successivi. Se sommo P a DI passo direttamente alla riga dopo. Sfrutto la modalita'di allocazione contigua in memoria
            LOOP ciclo_somma          ;passo al successivo
            JMP scrivi                ;se ho finito di accumulare scrivo in matrice risultato
            
        overflow:
            JS  negativo              ;se il SF e' true allora salto alla gestione del negativo
            MOV DX, -32768            ;se sono qui allora e' perche' il mio numero che ha dato OF e' positivo
            INC SI                    ;sostituisco con massimo valore negativo
            ADD DI, P                 ;incremento indice colonna prima matrice (DI) e riga seconda matrice (SI)
            LOOP ciclo_somma
            JMP scrivi
            negativo:
                MOV DX, 32767         ;se negativo sostituisco con valore massimo positivo scrivibile
                INC SI                ;incremento indici di colonna e riga
                ADD DI, P
                LOOP ciclo_somma      ;passo al successivo
       
    scrivi:
        MOV matrice_ris[BX], DX     ;scrivo
        INC BX                      ;incremento l'indice della matrice ris
        INC BX
        POP CX                      ;prelevo counter ciclo
        POP DI
        POP SI
        
        INC DI
        
        LOOP ciclo_cambia_colonna        
    
    XOR DI, DI                      ;azzero l'indice di colonna della seconda matrice B
    POP CX
    POP SI
    ADD SI, M                       ;passo alla riga successiva sommando l'offset corretto
    LOOP ciclo_cambia_riga 

.EXIT
END