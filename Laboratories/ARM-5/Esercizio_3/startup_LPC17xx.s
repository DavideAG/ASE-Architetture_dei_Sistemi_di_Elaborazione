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

Stack_Size      EQU     0x0000F0000

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

;MyArea
				AREA Paletti, DATA, READWRITE
Padding_1		SPACE	4
Primo			SPACE	200
Padding_2		SPACE	4
Secondo			SPACE	200
Padding_3		SPACE	4
Terzo			SPACE	200

				AREA Dischi, DATA, READONLY
dischetti		DCD 9, 6, 3, 0


                AREA    |.text|, CODE, READONLY


; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
                
				LDR r0, =dischetti		;in r0 metto l'indirizzo dei dischi
				LDR r1, =Primo			;in r1 metto l'indirizzo del paletto
				PUSH{r0, r1}
				BL fillStack
				POP{r0, r1}
				
				LDR r2, =Secondo
				;PUSH{r0, r2}
				;BL fillStack
				;POP{r0, r2}
				
				LDR r3, =Terzo
				;PUSH{r0, r3}
				;BL fillStack
				;POP{r0, r3}
				
				;ESERCIZIO 2
				;r1 <- StackPointer paletto_1
				;r2 <- StackPointer paletto_2
				;r3 <- StackPointer paletto_3

				;PUSH{r1}		;paletto sorgente
				;PUSH{r2}		;paletto destinazione
				;PUSH{r0}		;spazio variabile risultato
				;BL move1
				;POP{r0}			;sarà 0 se non posso spostare, 1 altrimenti
				;POP{r2}
				;POP{r1}
				
				;ESERCIZIO 3
				;r1 <- StackPointer paletto_1
				;r2 <- StackPointer paletto_2
				;r3 <- StackPointer paletto_3
				MOV r4, #3	;numero di dischi da spostare
				PUSH{r1}	;sorgente
				PUSH{r2}	;destinazione
				PUSH{r3}	;ausiliario
				PUSH{r4}	;numero di dischi da spostare
				BL moveN
				POP{r4}
				POP{r3}
				POP{r2}
				POP{r1}
				
stop			B stop
                ENDP


fillStack	PROC
			PUSH{r0, r1, r2, r3, r4, LR}
			
			LDR r0, [SP, #24]		;r0 <- &dischetti
			LDR r1, [SP, #28]		;r1 <- &paletto
			
			
			LDR r3, [r0], #4		;r3 <-	prendo un disco
			CMP r3, #0				;se zero exit
			BEQ exit
			STMEA	r1!, {r3}		;prendo il disco e lo metto nel paletto. Poi incremento r1
			;----------------------------------------
			;inserisco elementi nello stack
			;lo gestisco EMPTY ASCENDING
			;userò STMEA e LDMEA
			;r2 STACK POINTER del mio paletto
			;----------------------------------------
ciclo1		LDR r4, [r0], #4		;r4 <-	prendo un disco
			CMP r4, #0				;se zero exit
			BEQ exit
			CMP	r3, r4				;vecchio-nuovo
			BMI exit_1				;se nuovo valore che voglio inserire > di vecchio allora exit
			;altrimenti inserisco nel mio stack
			MOV r3, r4				;r3 <- nuovo elemento x confronto ciclo dopo
			STMEA	r1!, {r4}		;metto nel paletto il disco
			B ciclo1
			
exit_1		SUB r0, #4
exit		
			;FAI AGGIORNAMENTO VARIABILI DI OUTPUT
			STR r0, [SP, #24]		;r0 <- &dischetti
			STR r1, [SP, #28]		;r1 <- &paletto

			POP{r0, r1, r2, r3, r4, PC}
			ENDP


move1		PROC
			PUSH{r0, r1, r2, r3, r4, LR}
			
			;----------------------------------------
			;carico valori
			;----------------------------------------
			LDR r1, [SP, #32]		;paletto sorgente
			LDR r2, [SP, #28]		;paletto destinazione
			
			;----------------------------------------
			;prelevo valore dal paletto sorgente
			;non modifico il pointer
			;----------------------------------------
			;Stack implementati Empty Ascending
			;devo quindi prelevare l'elemento che sta
			;4 byte soto la cella vuota che sto puntando
			;----------------------------------------
			
			LDR r3, [r1, #-4]		;r3 <- val_sorgente
			CMP r3, #0				;non posso considerare uno zero
			BEQ	fail
			LDR r4, [r2, #-4]		;r4	<- val_dest
			CMP r4, #0				;se secondo paletto vuoto, sposta sempre
			BEQ	sposta
			CMP r4, r3
			BMI	fail				;se disco destinazione è più piccolo di disco sorgente -> failure
			
sposta
			STMEA	r2!, {r3}		;sposto disco da sorgente a destinazione
			SUB r1, #4
			STR	r1, [SP, #32]		;aggiorno Pointers degli stack
			STR	r2, [SP, #28]
			
			MOV r0, #1				;scrivo valore di return
			STR r0, [SP, #24]
			POP{r0, r1, r2, r3, r4, PC}
			
			
fail		MOV r1, #0
			STR r1, [SP, #24]
			POP{r0, r1, r2, r3, r4, PC}
			
			ENDP


moveN		PROC
			PUSH{r0, r1, r2, r3, r4, r5, r6, r7, LR}
			
			LDR r1, [SP, #48]	;r1 <- &sorgente
			LDR r2, [SP, #44]	;r2 <- &destinazione
			LDR r3, [SP, #40]	;r3 <- &ausiliario
			LDR r4, [SP, #36]	;r4 <- N numero dischi da spostare
			MOV r0, #0			;r0 = M
								;r5 = a
								;r6 = b
								;r7 = c
			
			CMP r4, #1
			BNE caso_generico
			
			PUSH{r1}	;sorg
			PUSH{r2}	;dest
			PUSH{r5}	;a
			BL move1
			POP{r5}
			POP{r2}
			POP{r1}			
			ADD r0, r0, r5
			;DEVO AGGIORNARE
			;ED USCIRE
			B fine
			
caso_generico
				SUB r6, r4, #1	;decremento numero dischi da spostare
				PUSH{r1}	;sorgente		X
				PUSH{r3}	;destinazione	Z
				PUSH{r2}	;ausiliario		Y
				PUSH{r6}	;numero di dischi da spostare
				BL moveN
				POP{r6}
				POP{r2}
				POP{r3}
				POP{r1}
				
				ADD r0, r0, r6	;M = M + b
				
				PUSH{r1}	;sorg
				PUSH{r2}	;dest
				PUSH{r5}	;a
				BL move1
				POP{r5}
				POP{r2}
				POP{r1}			
				
				;if(a==0) return;
				CMP r5, #0
				BEQ fine
				ADD r0, r0, #1	;M=M+1
				
				SUB r7, r4, #1
				
				PUSH{r3}	;sorgente		Z
				PUSH{r2}	;destinazione	Y
				PUSH{r1}	;ausiliario		X
				PUSH{r7}	;numero di dischi da spostare
				BL moveN
				POP{r7}
				POP{r1}
				POP{r2}
				POP{r3}
				ADD r0, r0, r7
				B fine
			
fine			
			STR	r1, [SP, #48]	;sorgente
			STR	r2, [SP, #44]	;destinazione
			STR	r3, [SP, #40]	;ausiliario
			STR r0, [SP, #36]	;M
			
			POP{r0, r1, r2, r3, r4, r5, r6, r7, PC}
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
