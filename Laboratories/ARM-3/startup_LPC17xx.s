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

N				EQU		4
M				EQU		7
P				EQU		5

;N				EQU		3
;M				EQU		4
;P				EQU		2
;MyArea - DCD
;MyArea_Size		EQU		(N*M*4)+(M*P*4)
				AREA    Matrici_Input, DATA, READONLY				
;Mat_1			DCD		4, -3, 5, 1, 3, -5, 0, 11, -5, 12, 4, -5	
;Mat_2			DCD		-2, 3, 5, -1, 4, 3, 9, -7
Mat_1			DCD		0x00000BB8, 0x000036B0, 0xFFFFC568, 0x00002328, 0x00006590, 0xFFFF30F8, 0x00001388
				DCD		0x00015BA8, 0x00013498, 0x00000BB8, 0x000059D8, 0x00014820, 0xFFFFE890, 0xFFFF8AD0
				DCD		0x0000A7F8, 0xFFFFF448, 0x00014438, 0x00006978, 0xFFFFDCD8, 0x0000C350, 0x00006D60
				DCD		0xFFFEA840, 0x0000A028, 0x00017AE8, 0xFFFE6DA8, 0x00010D88, 0x00009858, 0xFFFFDCD8

Mat_2			DCD		0x00009088, 0xFFFE7578, 0x0,		0x0000E290, 0xFFFFB1E0
				DCD		0x00002328, 0x00012110, 0x00016F30, 0xFFFFF060, 0x0000E678
				DCD		0xFFFFA628, 0x00015F90, 0xFFFECF50, 0x00003E80, 0xFFFFF060
				DCD		0x0,		0xFFFF0DD0, 0x00014FF0, 0x00004E20, 0x00015BA8
				DCD		0x00002328, 0x00014FF0, 0x00006D60, 0x0,		0xFFFF7B30
				DCD		0x00014050, 0x00001388, 0x000084D0, 0xFFFFADF8, 0x000003E8
				DCD		0x00011170, 0xFFFEFA48, 0x00002328, 0x00014050, 0x000036B0

				AREA	Matrice_out, DATA, READWRITE
Mat_res			SPACE	M*P*4

				AREA    |.text|, CODE, READONLY


; Reset Handler

Reset_Handler   PROC
                EXPORT  Reset_Handler             [WEAK]
				LDR r0, =Mat_1
				LDR r1, =Mat_2
				LDR r8, =Mat_res
				MOV r6, #M	;indice ciclo1
				MOV r7, #P	;indice ciclo2
				MOV r5, #N	;indice ciclo3
				MOV r9, #0	;E' l'indice di colonna di Mat_2. Contiene l'offset per reimpostare la colonna corretta
				MOV r12, #0	;E' l'indice di riga di Mat_1. Contiene l'offset per reimpostare la riga corretta
				;accumulatore r10:r11

ciclo3			;gestisce cambio di riga Mat_1
ciclo2			;gestisce cambio colonna Mat_2				
ciclo1			;gestisce somma
				LDR		r3, [r0], #4			;prendo il primo valore e lo metto in r3, incremento r0 di 4
				LDR		r4, [r1], #P*4			;prendo il secondo valore e lo metto in r4, incremento r1 di P*4 e scalo di riga
				SMLAL	r11, r10, r3, r4		;bassa, alta - moltiplico r0 e r1 e metto il risultato in rr10:r11 che è il mio accomulatore
				SUBS	r6,	r6, #1
				BNE		ciclo1
			;COONTROLLO DELL'OVERFLOW, DEVO SCRIVERE IL DATO
			;------------------
			CMP		r10, #0xFFFFFFFF	;se il registro alto è tutti 1 allora controllo se MSB del registro basso è 1, altrimenti overflow
			BEQ		controlloF_MSB
			CMP		r10, #0x00000000	;se il registro alto è tutti 0 allora controllo se MSB del registro basso è 0, altrimenti overflow
			BEQ		controllo0_MSB
			B overf						;altrimenti è sicuro overflow
			
controlloF_MSB
			TST	r11, #0xFFFFFFFF		;controllo se il registro basso ha MSB = 1, altrimenti overf
			BPL	overf					;se il flag di segno è 0 allora gestisco overflow
			STR		r11, [r8], #4		;altrimenti scrivo il dato nella matrice ris, incrementando successivamente r8 di 4 byte in modo da impostarlo per il prossimo inserimento
			B	continua
			
controllo0_MSB
			TST r11, #0xFFFFFFFF		;controllo se il registro basso ha MSB = 0 altrimenti overf
			BMI	overf					;se il flag di segno (MSB) = 1 allora gestisco overf
			STR		r11, [r8], #4		;scrivo il dato nella matrice ris, incremento r8 (indirizzo matrice) di 4 byte in modo da impostarlo per il prossimo inserimento
			B	continua

overf		TST r10, #0xFFFFFFFF		;eseguo un test sul registro che rappresenta la parte alta. Se ha MSB negativo devo scrivere il massimo numero negativo rappresentabile (0x80000001) altrimenti devo rappresentare il massimo numero positivo rappresentabile (0x8FFFFFFF)
			BPL		scrivi0				;se flag segno = 0 allora scrivo come risultato il massimo numero positivo rappresentabile su 32 bit
			;altrimenti devo scrivere il numero negativo più grande rappresentabile
			;MOV	r11, #0x1
			;MOVT	r11, #0x8000		;Versione SENZA literal pool
			LDR		r11, =0x80000001	;Versione con literal pool, la variabile starà in PC+<offset>
			STR		r11, [r8], #4		;scrivo il dato nella matrice ris
			B	continua
			
scrivi0		MOV		r11, #0xFFFFFFFF
			LSR		r11, #1				;metto uno 0 nel MSB con uno shift logico. Ora è il massimo numero positivo rappresentabile
			STR		r11, [r8], #4		;scrivo il dato nella matrice ris
			B 	continua
			;------------------
continua			
			
			MOV 	r10, #0
			MOV		r11, #0			;Azzero il mio accumulatore
			ADD		r9, r9, #4		;incremento il mio offset che mi permetterà di considerare la prossima colonna di Mat_2
			LDR		r0, =Mat_1	
			ADD 	r0, r12			;risposiziono indice riga Mat_1 corretto
			LDR		r1, =Mat_2				
			ADD		r1, r9			;cambio colonna per Mat_2	
			MOV		r6, #M			;ricarico contatore ciclo più interno
			SUBS	r7, r7, #1
			BNE		ciclo2
		ADD		r12, #M*4			;incremento offset cambio riga
		LDR		r0, =Mat_1			;cambio riga per Mat_1
		ADD		r0, r12
		LDR		r1, =Mat_2			;azzero colonna per Mat_2
		MOV 	r9, #0				;azzero l'indice di colonna per mat_2
		MOV 	r7, #P				;ricarico indice ciclo2
		SUBS	r5, r5, #1
		BNE		ciclo3
		
stop			B stop
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
