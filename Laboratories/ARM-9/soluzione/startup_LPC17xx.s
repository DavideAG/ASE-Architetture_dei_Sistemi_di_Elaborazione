;/**************************************************************************//**
; * @file     startup_LPC17xx.s
; * @brief    CMSIS Cortex-M3 Core Device Startup File for
; *           NXP LPC17xx Device Series
; * @version  V1.10
; * @date     06. April 2011
; *
; * @note
; * Copyright (C) 2009-2011 ARM Limited. All rights reserved.
; *
; * @par
; * ARM Limited (ARM) is supplying this software for use with Cortex-M
; * processor based microcontrollers.  This file can be freely distributed
; * within development tools that are supporting such ARM based processors.
; *
; * @par
; * THIS SOFTWARE IS PROVIDED "AS IS".  NO WARRANTIES, WHETHER EXPRESS, IMPLIED
; * OR STATUTORY, INCLUDING, BUT NOT LIMITED TO, IMPLIED WARRANTIES OF
; * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE APPLY TO THIS SOFTWARE.
; * ARM SHALL NOT, IN ANY CIRCUMSTANCES, BE LIABLE FOR SPECIAL, INCIDENTAL, OR
; * CONSEQUENTIAL DAMAGES, FOR ANY REASON WHATSOEVER.
; *
; ******************************************************************************/

; *------- <<< Use Configuration Wizard in Context Menu >>> ------------------

; <h> Stack Configuration
;   <o> Stack Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Stack_Size      EQU     0x00000200

                AREA    STACK, NOINIT, READWRITE, ALIGN=3
Stack_Mem       SPACE   Stack_Size
__initial_sp


; <h> Heap Configuration
;   <o>  Heap Size (in Bytes) <0x0-0xFFFFFFFF:8>
; </h>

Heap_Size       EQU     0x00000000

                AREA    HEAP, NOINIT, READWRITE, ALIGN=3
__heap_base
Heap_Mem        SPACE   Heap_Size
__heap_limit


                PRESERVE8
                THUMB


; Vector Table Mapped to Address 0 at Reset

                AREA    RESET, DATA, READONLY
                EXPORT  __Vectors

__Vectors       DCD     __initial_sp              ; Top of Stack
                DCD     Reset_Handler             ; Reset Handler
                DCD     NMI_Handler               ; NMI Handler
                DCD     HardFault_Handler         ; Hard Fault Handler
                DCD     MemManage_Handler         ; MPU Fault Handler
                DCD     BusFault_Handler          ; Bus Fault Handler
                DCD     UsageFault_Handler        ; Usage Fault Handler
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     0                         ; Reserved
                DCD     SVC_Handler               ; SVCall Handler
                DCD     DebugMon_Handler          ; Debug Monitor Handler
                DCD     0                         ; Reserved
                DCD     PendSV_Handler            ; PendSV Handler
                DCD     SysTick_Handler           ; SysTick Handler

                ; External Interrupts
                DCD     WDT_IRQHandler            ; 16: Watchdog Timer
                DCD     TIMER0_IRQHandler         ; 17: Timer0
                DCD     TIMER1_IRQHandler         ; 18: Timer1
                DCD     TIMER2_IRQHandler         ; 19: Timer2
                DCD     TIMER3_IRQHandler         ; 20: Timer3
                DCD     UART0_IRQHandler          ; 21: UART0
                DCD     UART1_IRQHandler          ; 22: UART1
                DCD     UART2_IRQHandler          ; 23: UART2
                DCD     UART3_IRQHandler          ; 24: UART3
                DCD     PWM1_IRQHandler           ; 25: PWM1
                DCD     I2C0_IRQHandler           ; 26: I2C0
                DCD     I2C1_IRQHandler           ; 27: I2C1
                DCD     I2C2_IRQHandler           ; 28: I2C2
                DCD     SPI_IRQHandler            ; 29: SPI
                DCD     SSP0_IRQHandler           ; 30: SSP0
                DCD     SSP1_IRQHandler           ; 31: SSP1
                DCD     PLL0_IRQHandler           ; 32: PLL0 Lock (Main PLL)
                DCD     RTC_IRQHandler            ; 33: Real Time Clock
                DCD     EINT0_IRQHandler          ; 34: External Interrupt 0
                DCD     EINT1_IRQHandler          ; 35: External Interrupt 1
                DCD     EINT2_IRQHandler          ; 36: External Interrupt 2
                DCD     EINT3_IRQHandler          ; 37: External Interrupt 3
                DCD     ADC_IRQHandler            ; 38: A/D Converter
                DCD     BOD_IRQHandler            ; 39: Brown-Out Detect
                DCD     USB_IRQHandler            ; 40: USB
                DCD     CAN_IRQHandler            ; 41: CAN
                DCD     DMA_IRQHandler            ; 42: General Purpose DMA
                DCD     I2S_IRQHandler            ; 43: I2S
                DCD     ENET_IRQHandler           ; 44: Ethernet
                DCD     RIT_IRQHandler            ; 45: Repetitive Interrupt Timer
                DCD     MCPWM_IRQHandler          ; 46: Motor Control PWM
                DCD     QEI_IRQHandler            ; 47: Quadrature Encoder Interface
                DCD     PLL1_IRQHandler           ; 48: PLL1 Lock (USB PLL)
                DCD     USBActivity_IRQHandler    ; 49: USB Activity interrupt to wakeup
                DCD     CANActivity_IRQHandler    ; 50: CAN Activity interrupt to wakeup


                IF      :LNOT::DEF:NO_CRP
                AREA    |.ARM.__at_0x02FC|, CODE, READONLY
CRP_Key         DCD     0xFFFFFFFF
                ENDIF


                AREA    |.text|, CODE, READONLY

N EQU 40	
M EQU 6	

Price_list	DCD 0x2, 29, 0x3, 5, 0x4, 29, 0x7, 11, 0xB, 2 
			DCD 0xC, 12,  0xE, 24, 0x10, 30, 0x11, 28, 0x13, 2 
			DCD 0x17, 17, 0x19, 30, 0x1D, 13, 0x1E, 10, 0x20, 22
			DCD 0x23, 23, 0x24, 5, 0x26, 23, 0x27, 21, 0x2C, 18
			DCD 0x2D, 14, 0x32, 16, 0x35, 2, 0x36, 4, 0x38, 8
			DCD 0x39, 3, 0x3C, 27, 0x3E, 9, 0x41, 6, 0x42, 29
			DCD 0x43, 10, 0x4A, 21, 0x4E, 3, 0x4F, 11, 0x50, 3
			DCD 0x51, 19, 0x52, 28, 0x5F, 22, 0x60, 8, 0x64, 9

Item_list1	DCD 0x27, 1, 0x4E, 5, 0x10, 3, 0x41, 8, 0x3C, 4, 0x23, 2	
	
Item_list2	DCD 0x27, 1, 0x4E, 5, 0x12, 3, 0x41, 8, 0x3C, 4, 0x23, 2 

; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]

				LDR r0, =Price_list
				LDR r1, =Item_list1
				MOV r2, #0
				PUSH {r0, r1, r2}
				BL sequentialSearch
				POP {r0, r1, r2}

				LDR r0, =Price_list
				LDR r1, =Item_list1
				MOV r2, #0
				PUSH {r0, r1, r2}
				BL binarySearch
				POP {r0, r1, r2}
				
				LDR r0, =Price_list
				LDR r1, =Item_list1
				MOV r2, #0
				PUSH {r0, r1, r2}
				BL robustSequentialSearch
				POP {r0, r1, r2}

				LDR r0, =Price_list
				LDR r1, =Item_list2
				MOV r2, #0
				PUSH {r0, r1, r2}
				BL robustSequentialSearch
				POP {r0, r1, r2}

				LDR r0, =Price_list
				LDR r1, =Item_list1
				MOV r2, #0
				PUSH {r0, r1, r2}
				BL robustBinarySearch
				POP {r0, r1, r2}


				LDR r0, =Price_list
				LDR r1, =Item_list2
				MOV r2, #0
				PUSH {r0, r1, r2}
				BL robustBinarySearch
				POP {r0, r1, r2}

stop 			B stop

                ENDP


sequentialSearch	PROC
	PUSH{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, LR}
								;prendo SP, sommo 40 e carico il valore in r0. STACK FULL DESCENDING - INDIRIZZI + GRANDI REGISTRI + GRANDI
	LDR	r0, [SP, #44]			;r0 <- &Price_List		
	LDR r1, [SP, #48]			;r1 <- &Item_List
	;LDR r2, [SP, #52]			;r2 <- valore dove devo scrivere il risultato. Non lo carico, è inutile
	
	;utilizzo r2 come accumulatore
	;devo fare un match sui codici e in caso di hit faccio fra i codici faccio quantità Item_list *  prezzo Price_list
	;---------------------------------
	;r6 codice da Price_list
	;r7 codice da Item_list
	;faccio confronto
	;se hit (if)
	;faccio calcolo in accumulatore
	;next
	;---------------------------------
	LDR r4, =N					;r4 <- N ciclo esterno gestisce Price_list
	MOV r2, #0
ciclo1	
	LDR	r6, [r0], #4				;r6 <- codice Price_List | prendo codide, incremento r0 per prepararlo al suo prezzo
	LDR r5, =M					;r5 <- M ciclo interno che gestisce Item_list
	LDR r1, [SP, #48]
	
ciclo2
		LDR r7, [r1], #4			;r7 <- codice Item_list
		CMP r7, r6
		BNE	continua				;salto alla gestione dell' hit
		;---SE SONO QUI METTO GESTIONE HIT
		;devo fare quantità Item_list *  prezzo Price_list
		LDR	r8, [r0]				;carico prezzo da item_list
		LDR r9, [r1]				;carico prezzo da Price_list
		MUL	r8, r8, r9				;moltiplico quantità e prezzo
		ADD r2, r2, r8				;sommo ad accumulatore
		;---FINE GESTIONE HIT
continua	;SE SONO QUI ALLORA NON HO FATTO HIT
		ADD	r1, r1, #4			;se non ho fatto hit preparo r1 per prendere il prossimo operando
		
		SUB r5, r5, #1			;r5--  |  aggiorno contatore interno
		CMP r5, #0				;faccio loop se ho altri valori da considerare
		BNE	ciclo2
		
	ADD r0, r0, #4				;aggiorno r0 per prendere codice successivo
	SUB	r4, r4, #1				;r4--  |  aggiorno contatore esterno
	CMP r4, #0
	BNE	ciclo1
	
	STR	r2, [SP, #52]			;scrivo nella posizione corretta il risultato r2
	POP{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, PC}
	ENDP


binarySearch	PROC
	PUSH{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, LR}
	LDR r0, [SP, #44]		;r0 <- &Price_list
	LDR	r1, [SP, #48]		;r1 <- &Item_list
	;LDR r2, [SP, #52]		;qui scriverò il risultato della ricerca
		
	;--------------------------
	;calcolo della spesa sostenuta
	;uso però ricerca binaria
	;--------------------------
	;prendo da Item_List e cerco in Price_List
	;table è Price_List
	;middle è cosa devo sommare (*2) a Price_List per ottenere il codice opportuno dell'oggetto di vendita
	;devo fare il ciclo per ogni elemento in Item_List, quindi tutto sta dentro un ciclo

	;--------------------------
	;DEFINIZIONE DELLE VARIABILI
	;first = r3
	;last  = r4
	;index = r5
	;middle = r7
	;key	= r8
	;table	= r9
	;table[middle] = r10
	;r11 prezzo
	;r12 quantità pezzi
	;--------------------------
	LDR r6, =M		;dimensione Price_List counter ciclo esterno

cicloExt
	LDR r8, [r1], #4	;r8 <- codice item KEY

	LDR r3, =0		;first
	LDR r4, =N
	;LSL r4, #1		;ho N*2 elementi dentro il mio vettore
	SUB r4, r4, #1	;last
	LDR r5, =0

cicloInt
		
		ADD R7, R3, R4
		LSR R7, #1			;R7 <- (first+last)/2
		LSL R7,	#1			;così ho eliminato l'eventuale resto
		LSL R7, #2			;*4 perché word
		ADD R9, R7, R0
		LDR R10, [R9]		;r10 <- table[middle]
		
		CMP r8, r10
		BNE altrimenti
		;elemento trovato, faccio calcoli accumulatore ed esco dal ciclo
		;devo fare numero prodotti * prezzo
		;r8 num prod
		;r10 prezzo
		LDR r10, [R9, #4]	;PRENDO PREZZO table[middle+1]
		LDR r8, [r1]		;PRENDO num(prodotti)
		MUL r10, r10, r8
		ADD r2, r2, r10		;sommo in accumulatore
		B continua2			;esco
altrimenti
		BGT els
		;SE SONO QUI SONO NELL'IF
		LSR	r7, #2
		LSR r7, #1		;lo riporto ragionando da 0 a 29
		SUB r4, r7, #1
		B cicloInt
els
		LSR r7, #2
		LSR r7, #1		;lo riporto ragionando da 0 a 29
		ADD r3, r7, #1
		B cicloInt
	
	ADD r1, r1, #4		;passo ad Item_list successivo
	SUB r6, r6, #1
	CMP r6, #0
	BNE	cicloExt
	
continua2
	ADD r1, #4
	SUB r6, #1
	CMP r6, #0
	BNE cicloExt

	STR	r2, [SP, #52]		;scrivo il risultato della ricerca
	POP{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, PC}
	ENDP


robustSequentialSearch	PROC
	PUSH{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, R10, LR}
	;R10 FLAG 
								;prendo SP, sommo 40 e carico il valore in r0. STACK FULL DESCENDING - INDIRIZZI + GRANDI REGISTRI + GRANDI
	LDR	r0, [SP, #48]			;r0 <- &Price_List		
	LDR r1, [SP, #52]			;r1 <- &Item_List
	;LDR r2, [SP, #56]			;r2 <- valore dove devo scrivere il risultato. Non lo carico, è inutile
	
	;utilizzo r2 come accumulatore
	;devo fare un match sui codici e in caso di hit faccio fra i codici faccio quantità Item_list *  prezzo Price_list
	;---------------------------------
	;r6 codice da Price_list
	;r7 codice da Item_list
	;faccio confronto
	;se hit (if)
	;faccio calcolo in accumulatore
	;next
	;---------------------------------
	LDR r4, =M						;r4 <- N ciclo interno gestisce Price_list
	MOV r2, #0
ciclo3	
	LDR	r6, [r1], #4				;r6 <- codice Price_List | prendo codice, incremento r0 per prepararlo al suo prezzo
	
	LDR r5, =N						;r5 <- M ciclo esterno che gestisce Item_list
	LDR r0, [SP, #48]
	MOV r10, #(-1)					;setto flag
	
ciclo4
		LDR r7, [r0], #4			;r7 <- codice Item_list
		CMP r7, r6
		BNE	continua3				;salto alla gestione dell' hit
		;---SE SONO QUI METTO GESTIONE HIT
		LDR R10, =0					;se ho un hit allora setto flag
		;devo fare quantità Item_list *  prezzo Price_list
		LDR	r8, [r1]				;carico prezzo da item_list
		LDR r9, [r0]				;carico prezzo da Price_list
		MUL	r8, r8, r9				;moltiplico quantità e prezzo
		ADD r2, r2, r8				;sommo ad accumulatore
		;---FINE GESTIONE HIT
continua3	;SE SONO QUI ALLORA NON HO FATTO HIT
		ADD	r0, r0, #4			;se non ho fatto hit preparo r1 per prendere il prossimo operando
		
		SUB r5, r5, #1			;r5--  |  aggiorno contatore interno
		CMP r5, #0				;faccio loop se ho altri valori da considerare
		BNE	ciclo4
	
	CMP r10, #-1				;se sono qui e flag non è settato allora ho errore
	BEQ error
	
	ADD r1, r1, #4				;aggiorno r0 per prendere codice successivo
	SUB	r4, r4, #1				;r4--  |  aggiorno contatore esterno
	CMP r4, #0
	BNE	ciclo3
	
	
	CMP r10, #0
	BEQ scrivi
	MOV r2, r10
scrivi
	STR	r2, [SP, #56]			;scrivo nella posizione corretta il risultato r2
	POP{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, PC}
	
error
	MOV r2, r10
	B	scrivi
	ENDP
		
robustBinarySearch	PROC
	PUSH{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, LR}
	LDR r0, [SP, #44]		;r0 <- &Price_list
	LDR	r1, [SP, #48]		;r1 <- &Item_list
	;LDR r2, [SP, #52]		;qui scriverò il risultato della ricerca
		
	;--------------------------
	;calcolo della spesa sostenuta
	;uso però ricerca binaria
	;--------------------------
	;prendo da Item_List e cerco in Price_List
	;table è Price_List
	;middle è cosa devo sommare (*2) a Price_List per ottenere il codice opportuno dell'oggetto di vendita
	;devo fare il ciclo per ogni elemento in Item_List, quindi tutto sta dentro un ciclo

	;--------------------------
	;DEFINIZIONE DELLE VARIABILI
	;first = r3
	;last  = r4
	;index = r5
	;middle = r7
	;key	= r8
	;table	= r9
	;table[middle] = r10
	;r11 prezzo
	;r12 quantità pezzi
	;--------------------------
	LDR r6, =M		;dimensione Price_List counter ciclo esterno

cicloExt2

	LDR r8, [r1], #4	;r8 <- codice item KEY

	LDR r3, =0		;first
	LDR r4, =N
	;LSL r4, #1		;ho N*2 elementi dentro il mio vettore
	SUB r4, r4, #1	;last
	LDR r5, =0

cicloInt2
		
		ADD R7, R3, R4
		LSR R7, #1			;R7 <- (first+last)/2
		LSL R7,	#1			;così ho eliminato l'eventuale resto
		LSL R7, #2			;*4 perché word
		ADD R9, R7, R0
		LDR R10, [R9]		;r10 <- table[middle]
		
		CMP r8, r10
		BNE altrimenti2
		;elemento trovato, faccio calcoli accumulatore ed esco dal ciclo
		;devo fare numero prodotti * prezzo
		;r8 num prod
		;r10 prezzo
		LDR r10, [R9, #4]	;PRENDO PREZZO table[middle+1]
		LDR r8, [r1]		;PRENDO num(prodotti)
		MUL r10, r10, r8
		ADD r2, r2, r10		;sommo in accumulatore
		B continua4			;esco
altrimenti2
		BGT els2
		;SE SONO QUI SONO NELL'IF
		LSR	r7, #2
		LSR r7, #1		;lo riporto ragionando da 0 a 29
		SUB r4, r7, #1

		;if(f3>f4) salta errore
		CMP r3, r4
		BGT err

		B cicloInt2
els2
		LSR r7, #2
		LSR r7, #1		;lo riporto ragionando da 0 a 29
		ADD r3, r7, #1
		
		;if(f3<=f4) salta errore
		CMP r3, r4
		BGT err
		B cicloInt2
	
	ADD r1, r1, #4		;passo ad Item_list successivo
	SUB r6, r6, #1
	CMP r6, #0
	BNE	cicloExt2
	
continua4
	ADD r1, #4
	SUB r6, #1
	CMP r6, #0
	BNE cicloExt2

	STR	r2, [SP, #52]		;scrivo il risultato della ricerca
	POP{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, PC}
	
err
	MOV r2, #-1
	STR	r2, [SP, #52]		;scrivo il risultato della ricerca
	POP{r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, PC}

	ENDP
		
; Dummy Exception Handlers (infinite loops which can be modified)

NMI_Handler     PROC
                EXPORT  NMI_Handler               [WEAK]
                B       .
                ENDP
HardFault_Handler\
                PROC
                EXPORT  HardFault_Handler         [WEAK]
                B       .
                ENDP
MemManage_Handler\
                PROC
                EXPORT  MemManage_Handler         [WEAK]
                B       .
                ENDP
BusFault_Handler\
                PROC
                EXPORT  BusFault_Handler          [WEAK]
                B       .
                ENDP
UsageFault_Handler\
                PROC
                EXPORT  UsageFault_Handler        [WEAK]
                B       .
                ENDP
SVC_Handler     PROC
                EXPORT  SVC_Handler               [WEAK]
                B       .
                ENDP
DebugMon_Handler\
                PROC
                EXPORT  DebugMon_Handler          [WEAK]
                B       .
                ENDP
PendSV_Handler  PROC
                EXPORT  PendSV_Handler            [WEAK]
                B       .
                ENDP
SysTick_Handler PROC
                EXPORT  SysTick_Handler           [WEAK]
                B       .
                ENDP

Default_Handler PROC

                EXPORT  WDT_IRQHandler            [WEAK]
                EXPORT  TIMER0_IRQHandler         [WEAK]
                EXPORT  TIMER1_IRQHandler         [WEAK]
                EXPORT  TIMER2_IRQHandler         [WEAK]
                EXPORT  TIMER3_IRQHandler         [WEAK]
                EXPORT  UART0_IRQHandler          [WEAK]
                EXPORT  UART1_IRQHandler          [WEAK]
                EXPORT  UART2_IRQHandler          [WEAK]
                EXPORT  UART3_IRQHandler          [WEAK]
                EXPORT  PWM1_IRQHandler           [WEAK]
                EXPORT  I2C0_IRQHandler           [WEAK]
                EXPORT  I2C1_IRQHandler           [WEAK]
                EXPORT  I2C2_IRQHandler           [WEAK]
                EXPORT  SPI_IRQHandler            [WEAK]
                EXPORT  SSP0_IRQHandler           [WEAK]
                EXPORT  SSP1_IRQHandler           [WEAK]
                EXPORT  PLL0_IRQHandler           [WEAK]
                EXPORT  RTC_IRQHandler            [WEAK]
                EXPORT  EINT0_IRQHandler          [WEAK]
                EXPORT  EINT1_IRQHandler          [WEAK]
                EXPORT  EINT2_IRQHandler          [WEAK]
                EXPORT  EINT3_IRQHandler          [WEAK]
                EXPORT  ADC_IRQHandler            [WEAK]
                EXPORT  BOD_IRQHandler            [WEAK]
                EXPORT  USB_IRQHandler            [WEAK]
                EXPORT  CAN_IRQHandler            [WEAK]
                EXPORT  DMA_IRQHandler            [WEAK]
                EXPORT  I2S_IRQHandler            [WEAK]
                EXPORT  ENET_IRQHandler           [WEAK]
                EXPORT  RIT_IRQHandler            [WEAK]
                EXPORT  MCPWM_IRQHandler          [WEAK]
                EXPORT  QEI_IRQHandler            [WEAK]
                EXPORT  PLL1_IRQHandler           [WEAK]
                EXPORT  USBActivity_IRQHandler    [WEAK]
                EXPORT  CANActivity_IRQHandler    [WEAK]

WDT_IRQHandler
TIMER0_IRQHandler
TIMER1_IRQHandler
TIMER2_IRQHandler
TIMER3_IRQHandler
UART0_IRQHandler
UART1_IRQHandler
UART2_IRQHandler
UART3_IRQHandler
PWM1_IRQHandler
I2C0_IRQHandler
I2C1_IRQHandler
I2C2_IRQHandler
SPI_IRQHandler
SSP0_IRQHandler
SSP1_IRQHandler
PLL0_IRQHandler
RTC_IRQHandler
EINT0_IRQHandler
EINT1_IRQHandler
EINT2_IRQHandler
EINT3_IRQHandler
ADC_IRQHandler
BOD_IRQHandler
USB_IRQHandler
CAN_IRQHandler
DMA_IRQHandler
I2S_IRQHandler
ENET_IRQHandler
RIT_IRQHandler
MCPWM_IRQHandler
QEI_IRQHandler
PLL1_IRQHandler
USBActivity_IRQHandler
CANActivity_IRQHandler

                B       .

                ENDP


                ALIGN


; User Initial Stack & Heap

                IF      :DEF:__MICROLIB

                EXPORT  __initial_sp
                EXPORT  __heap_base
                EXPORT  __heap_limit

                ELSE

                ;IMPORT  __use_two_region_memory
                EXPORT  __user_initial_stackheap
__user_initial_stackheap

                LDR     R0, =  Heap_Mem
                LDR     R1, =(Stack_Mem + Stack_Size)
                LDR     R2, = (Heap_Mem +  Heap_Size)
                LDR     R3, = Stack_Mem
                BX      LR

                ALIGN

                ENDIF


                END
