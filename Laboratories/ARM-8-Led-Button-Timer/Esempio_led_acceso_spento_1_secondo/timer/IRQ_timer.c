/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_timer.c
** Last modified Date:  2014-09-25
** Last Version:        V1.00
** Descriptions:        functions to manage T0 and T1 interrupts
** Correlated files:    timer.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "timer.h"

#include "../led/led.h"

/******************************************************************************
** Function name:		Timer0_IRQHandler
**
** Descriptions:		Timer/Counter 0 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/

extern int acceso;			//Importo la variabile acceso dal sample.c

void TIMER0_IRQHandler (void)
{
	if(acceso){
		led4Off();
		acceso = 0;	//setto il flag acceso = 0
	}else{
		led4On();
		acceso = 1;	//setto il flag acceso = 1
	}
  LPC_TIM0->IR = 1;			/* clear interrupt flag */
  //qui scrivo cosa far�  il timer, le funzioni le definisco in func_led.c e i prototipi in led.h
	return;
}


/******************************************************************************
** Function name:		Timer1_IRQHandler
**
** Descriptions:		Timer/Counter 1 interrupt handler
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
void TIMER1_IRQHandler (void)
{
  LPC_TIM1->IR = 1;			/* clear interrupt flag */
  return;
}

/******************************************************************************
**                            End Of File
******************************************************************************/
