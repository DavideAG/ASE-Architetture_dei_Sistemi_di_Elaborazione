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

N				EQU 8

				AREA MySquare, DATA, READONLY
Matrix			DCD	64, 2, 3, 61, 60, 6, 7, 57
				DCD	9, 55, 54, 12, 13, 51, 50, 16
				DCD 17, 47, 46, 20, 21, 43, 42, 24
				DCD 40, 26, 27, 37, 36, 30, 31, 33
				DCD 32, 34, 35, 29, 28, 38, 39, 25
				DCD 41, 23, 22, 44, 45, 19, 18, 48
				DCD 49, 15, 14, 52, 53, 11, 10, 56
				DCD 8, 58, 59, 5, 4, 62, 63, 1
				
                AREA    |.text|, CODE, READONLY

; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]

				LDR r0, =Matrix
				LDR r1, =N
				EOR r2, r2, r2
				PUSH{r0, r1, r2}
				BL magicSquare
				POP{r0, r1, r2}
				
stop			B	stop
                ENDP

magicSquare		PROC
				PUSH{r0-r12, LR}
				LDR	r0, [SP, #14*4]	;r0 <- &Matrix
				LDR r1, [SP, #15*4]	;r1 <- N
				
				
				;---first step: elements must be all differents
				EOR r2, r2, r2		;r2 <- 0	MyFlag
				EOR r3, r3, r3		;r3 <- 0 	Cycle_1 counter
				EOR r4, r4, r4		;r4 <- 0	Cycle_2	counter
				MUL r8, r1, r1		;r8 <- N*N
				SUB r9, r8, #1		;r9 <- N*N-1

Cycle_1			LSL r7, r3, #2		;Cycle_1 counter * 4. Because i have to get byte a byte 
				LDR r5, [r0, r7]
				ADD r4, r3, #1		;j = i + 1
Cycle_2			 LSL r7, r4, #2
				 LDR r6, [r0, r7]	;r6 <- *Matrix[cycle_2 counter]
				 CMP r5, r6
				 BEQ error2			;are they equal? - error: A1762E: Branch offset 0x00000102 out of range of 16-bit Thumb branch, but offset encodable in 32-bit Thumb branch
				 ADD r4, #1
				 CMP r4, r8			;Cycle_2 counter == N*N?
				 BNE Cycle_2
				ADD r3, #1			;Cycle_1 counter ++ (i++)
				CMP	r3, r9			;Cycle_1 counter == N*N-1?
				BNE Cycle_1
				B second
error2			B error
second

				;---second step: 1<=element<=N^2
				EOR r3, r3, r3		;Cycle_3 counter

Cycle_3			LSL	r4, r3, #2		;because they are byte
				LDR r5, [r0, r4]	;r5 <- *Matrix[Cycle_3 counter]
				CMP r5, #1
				BLT	error
				CMP r5, r8			;r5 > N*N?
				BGT	error
				ADD r3, #1
				CMP r3, r8			;Cycle_3 counter == N*N?
				BNE Cycle_3			;from 0 to N*N-1
				
				
				;---third step
				EOR r3, r3, r3		;Cycle_4 counter
				EOR r4, r4, r4		;accumul
				EOR r5, r5, r5		;Cycle_5 counter
				MUL r6, r1, r1		;r6 <- N^2
				ADD r6, #1
				MUL r6, r6, r1
				LSR	r6, #1			;M = 0.5 * N * (N^2 + 1)

Cycle_4
Cycle_5			 
				 LDR r8, [r0], #4	;r8 <- *Matrix[Cycle_5 counter]
				 ADD r4, r4, r8		;accumul += *Matrix[Cycle_5 counter]
				 ADD r5, r5, #1		;j++
				 CMP r5, r1			;Cycle_5 counter == N?
				 BNE Cycle_5
				CMP r4, r6			;accumul == M?
				BNE error
				EOR r5, r5, r5
				EOR r4, r4, r4		;accumul <- 0
				ADD r3, r3, #1
				CMP r3, r1			;from 0 to N-1	loop
				BNE Cycle_4
				LDR r0, [SP, #14*4]	;r0 <- &Matrix
		
				;---Sum col
				;r6 = M
				EOR r3, r3, r3		;Cycle_6 counter
				EOR r4, r4, r4		;Accumul
				EOR r5, r5, r5		;Cycle_7 counter

Cycle_6			LSL r8, r3, #2
				LDR r0, [SP, #14*4]	;reset of &Matrix
				ADD r0, r8			;shifting to the other column
Cycle_7			 LSL r9, r1, #2		;r9 <- N*4
				 LDR r7, [r0]		;r6 <- value
				 ADD r0, r0, r9		;r0 ready for the next value
				 ADD r4, r4, r7		;accumul += *Matrix[j]
				 ADD r5, #1			;Cucle_7 counter ++
				 CMP r5, r1			;from 0 to N-1
				 BNE Cycle_7
				CMP r4, r6
				BNE error
				EOR r4, r4, r4
				EOR r5, r5, r5		
				ADD r3, #1			;Cycle_6 counter ++
				CMP r3, r1			;Cycle_6 counter == N?
				BNE Cycle_6
				LDR r0, [SP, #14*4]
				
				;Sum diag
				;r6 = M
				EOR r4, r4, r4		;Accumul
				EOR r5, r5, r5		;Cycle_8 counter
				ADD r8, r1, #1
				LSL r8, r8, #2		;r8 <- (N+1)*4    offeset for the next element
				
Cycle_8			 
				 LDR r7, [r0]		;getting next value of the diag
				 ADD r0, r0, r8		;r0 ready for the next value
				 ADD r4, r4, r7		;Accumul += value
				 ADD r5, #1
				 CMP r5, r1			;counter == N?
				 BNE Cycle_8
				CMP r4, r6
				BNE error
				EOR r4, r4, r4
				LDR r0, [SP, #14*4]

				;Sum antiDiag
				;r6 = M
				EOR r4, r4, r4		;Accumul
				LSL r5, r1, #2
				SUB r5, #4
				ADD r0, r5			;starting from N*4
				EOR r5, r5, r5		;Cycle_9 counter
Cycle_9			
				 LDR r7, [r0]		;r7 <- value
				 SUB r8, r1, #1
				 LSL r8, r8, #2
				 ADD r0, r8			;r0 += (N-1)*4	ready for the second value
				 ADD r4, r4, r7		;accumul += value
				 ADD r5, #1			;Cycle_9 counter ++
				 CMP r5, r1			;counter == N?
				 BNE Cycle_9
				CMP r4, r6			;accumul == Magic?
				BNE error				

				MOV r2, #1
				STR	r2, [SP, #16*4]	;store of my flag	
				POP{r0-r12, PC}
error			EOR r2, r2, r2
				STR r2, [SP, #16*4]
				POP{r0-r12, PC}
				ENDP

;magicSquare		PROC
				;PUSH{r0, r1, r2, r3, r4, r5, r6, r7, LR}
				
				;LDR	r0, [SP, #40]	;r0 <- &matrice
				;LDR r1, [SP, #44]	;r1 <- N
				;MUL	r1, r1, r1		;r1 <- N*N		assumo che non faccia overflow
				;EOR	r2, r2, r2		;azzero r2, indice di ciclo1
				;EOR r5, r5, r5		;azzero r5, indice di ciclo2
				
;loop_1			LDR	r3, [r0], #4	;r3 <- elemento i-esimo	////////////////
				;CMP r3, #0
				;BHI controllo_magg_N_quadro
				;B error
				
;controllo_magg_N_quadro
				;CMP r3, r1
				;BLS valido
				;B	error

;valido								;se sono qui allora il mio valore è in [1,N*N]
				;CMP r2, #0			;Se è il primo devo saltarlo
				;BEQ	continua		;salto il primo elemento, non faccio controllo se già nella matrice ci sono valori uguali
				
				;LDR r4, [SP, #40]	;r4 <- &matrice
;loop_2			LDR r6, [r4], #4	;r6 <- elemento j-esimo	////////////////
				;CMP r6, r3			;confronto fra elemento j-esimo e i-esimo
				;BEQ	error			;se sono uguali errore
				;ADD r5, r5, #1		;incremento indice loop2
				;CMP r5, r2			;j=i? se si allora esco fuori dal ciclo
				;BNE loop_2
				
;continua				
				;EOR r5, r5, r5		;azzero indice ciclo2
				;ADD r2, r2, #1		;incremento indice di ciclo1
				;CMP r2, r1			;se sono arrivato con r2=N*N allora esco dal ciclo
				;BNE	loop_1
				
				;;se sono qui allora devo controllare magicnumber, i primi due conntrolli li ho superati
				;;posso riutilizzare i registri che erano impegnati 
				
				;;-------------------------------------------------
				;;INIZIALIZZAZIONE DELLE VARIABILI UTILI AL CONTROLLO DI M
				;;-------------------------------------------------
				;LDR	r0, [SP, #40]	;r0 <- &matrice
				;LDR r1, [SP, #44]	;r1 <- N
				;MOV r2, #0			;indice ciclo_1
				;MOV r3, #0			;indice ciclo_2
				;MOV r4, #0			;accumulatore
				;MOV r5, #0			;M - Magic Number
				;MOV r6, #0			;r6 valore da sommare
				;;----------------------------
				;;calcolo di M - Magic Number
				;;----------------------------
				;MUL r5, r1, r1		;r5 <- N^2
				;ADD r5, #1
				;MUL r5, r5, r1		;moltiplico (N^2+1) per N.
				;LSR r5, #1			;divido per due N*(N^2+1). Ottengo così Magic_Number
				;;-------------------------------------------------
				;;SOMMA DEI VALORI NELLA RIGA
				;;CONTROLLO VOLTA PER VOLTA SE RES=M
				;;-------------------------------------------------
;ciclo_1			
;ciclo_2			LDR r6, [r0], #4	;prendo il primo valore, lo metto in r6 e incremento &r0 per il prossimo giro
				;ADD r4, r4, r6		;sommo nel mio accumulatore
				;ADD	r3, r3, #1		;j++
				;CMP r3, r1			;j=N?
				;BNE ciclo_2			;se NO continuo a ciclare
				;;SE SONO QUI ALLORA HO IN r4 LA SOMMA DI TUTTI GLI ELEMENTI DELLA RIGA i-esima
				;CMP r4, r5			;se no Magic Number allora sono in error
				;BNE error
				;;SE SONO QUI ALLORA LA RIGA i-esima HA COME SOMMA Magic Number
				;MOV r4, #0			;azzero accumulatore r4 preparandolo per il prossimo giro
				;MOV	r3, #0			;azzero indice ciclo_2				
				;ADD r2, r2, #1		;i++
				;CMP r2, r1			;controllo se ho esaminato tutte le righe
				;BNE	ciclo_1			;se NO passo alla riga successiva
				
				;;-------------------------------------------------
				;;INIZIALIZZAZIONE DELLE VARIABILI UTILI AL CONTROLLO DI M
				;;-------------------------------------------------
				;;r5 <- Magic Number
				;;r1 <- N
				;MOV r2, #0			;indice ciclo_1_col
				;MOV r3, #0			;indice ciclo_2_col
				;MOV r4, #0			;accumulatore
				;MOV r6, #0			;valore da sommare in accumulatore
				;LDR r0, [SP, #40]	;r0 <- &matrice
				;;-------------------------------------------------
				;;SOMMA DEI VALORI NELLA COLONNA
				;;CONTROLLO VOLTA PER VOLTA SE RES=M
				;;-------------------------------------------------
;ciclo_1_col
;ciclo_2_col		LDR r6, [r0], #N*4	;carico il valore
				;ADD r4, r4, r6		;sommo nel mio accumulatore
				;ADD	r3, r3, #1		;j++
				;CMP r3, r1			;j=N?
				;BNE ciclo_2_col		;se NO continuo a ciclare
				;;SE SONO QUI ALLORA HO IN r4 LA SOMMA DI TUTTI GLI ELEMENTI DELLA COLONNA i-esima
				;CMP r4, r5			;se no Magic Number allora sono in error
				;BNE error
				;;SE SONO QUI ALLORA LA COLONNA i-esima HA COME SOMMA Magic Number
				;MOV r4, #0			;azzero accumulatore r4 preparandolo per il prossimo giro
				;MOV	r3, #0			;azzero indice ciclo_2_col				
				;ADD r2, r2, #1		;i++
				;MOV r7, #4			;riselettore di colonna. Imposto la colonna corretta per il prossimo giro
				;MUL r7, r7, r2		;r7 <- 4*i
				;LDR r0, [SP, #40]	;r0 <- &matrice
				;ADD r0, r0, r7		;r0 <- r0+offset	sommo l'offset giusto per selezionare la colonna corretta
				;CMP r2, r1			;controllo se ho esaminato tutte le colonne
				;BNE	ciclo_1_col		;se NO passo alla colonna successiva
				
				;;-------------------------------------------------
				;;INIZIALIZZAZIONE DELLE VARIABILI UTILI AL CONTROLLO DI M
				;;-------------------------------------------------
				;;r1 <- N
				;;r5 <- Magic_Number
				;LDR r0, [SP, #40]	;r0 <- &matrice
				;MOV r4, #0			;accumulatore
				;MOV r6, #0			;valore da sommare in accumulatore
				;MOV r2, #0			;indice di ciclo
				;MOV r3, #0			;offset di selezione valore
				;;-------------------------------------------------
				;;SOMMA DEI VALORI NELLA DIAGONALE PRINCIPALE
				;;CONTROLLO VOLTA PER VOLTA SE RES=M
				;;-------------------------------------------------
;ciclo_diag		LDR r6, [r0], #(N+1)*4	;carico il valore
				;ADD r4, r4, r6		;sommo nel mio accumulatore
				;ADD r2, r2, #1		;incremento indice di ciclo
				;CMP r2, r1			;j=N?
				;BNE	ciclo_diag		;se NO allora continuo a ciclare
				;;SE SONO QUI ALLORA IN r4 HO LA SOMMA DI TUTTI GLI ELEMENTI DELLA DIAGONALE PRINCIPALE
				;CMP r4, r5			;accumulatore = Magic_Number?
				;BNE	error			;se NO allora no Magic_Square
				
				;;-------------------------------------------------
				;;INIZIALIZZAZIONE DELLE VARIABILI UTILI AL CONTROLLO DI M
				;;-------------------------------------------------
				;;r1 <- N
				;;r5 <- Magic_Number
				;LDR r0, [SP, #40]	;r0 <- &matrice
				;MOV r4, #0			;accumulatore
				;MOV r6, #0			;valore da sommare in accumulatore
				;MOV r2, #0			;indice di ciclo
				;MOV r3, #N-1		;offset di selezione valore
				;;-------------------------------------------------
				;;SOMMA DEI VALORI NELL'ANTIDIAGONALE
				;;CONTROLLO VOLTA PER VOLTA SE RES=M
				;;-------------------------------------------------
;ciclo_antidiag	LDR	r6, [r0, r3, LSL #2]	;carico il valore
				;ADD r0, r0, r3, LSL #2
				;;SUB r3, r3, #1		;aggiusto offset per considerare l'elemento successivo
				;ADD r4, r4, r6		;sommo nel mio accumulatore
				;ADD r2, r2, #1		;incremento indice di ciclo
				;CMP r2, r1			;j=N?
				;BNE	ciclo_antidiag	;se NO allora continuo a ciclare
				;;SE SONO QUI ALLORA IN r4 HO LA SOMMA DI TUTTI GLI ELEMENTI DELL'ANTIDIAGONALE PRINCIPALE
				;CMP r4, r5			;accumulatore = Magic_Number?
				;BNE	error			;se NO allora no Magic_Square
				
				;LDR r0, =1			;se sono qui allora SI quadrato magico
				;STR	r0, [SP, #36]	;scrivo 1 in result
				;POP{r0, r1, r2, r3, r4, r5, r6, r7, PC}
				
;error			LDR r0, =0			;se sono qui allora NO quadrato magico
				;STR	r0, [SP, #36]	;scrivo 0 in result, NO quadrato magico
				;POP{r0, r1, r2, r3, r4, r5, r6, r7, PC}

				;ENDP
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
