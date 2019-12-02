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
#include "../button_EXINT/button.h"
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

extern int mostro_sequenza;			//Importo la variabile acceso dal sample.c
extern int vett[];
extern int n;			//livello del gioco
extern int j;			//led acceso
extern int premuti;
extern int pendolo;

void TIMER0_IRQHandler (void)
{
	LPC_TIM0->IR = 1;			/* clear interrupt flag */
	
	if(j == 257){				//gestione ultima accensione
		j++;
		allOff();
		return;
	}
		
	if(mostro_sequenza){		//qui devo mostrare la sequenza del gioco
		//MOSTRA SEQUENZA			//scrivo vettore di sequenza led di lunghezza 2^8
		premuti = 0;
		
		if(pendolo){
			if(j<n)			//se devo ancora completare l'accensione dei led della mia sequenza
				switch(LPC_TIM1->TC % 3){
					case 0:
						ledOn(4);
						vett[j++] = 4;			//salvo che ho acceso il led4 alla posizione j
						break;
					case 1:
					ledOn(5);
						vett[j++] = 5;
						break;
					case 2:
						ledOn(6);
						vett[j++] = 6;
						break;
				}
				pendolo = 0;		//imposto pendolo in modo da stare 1,5sec led acceso e 1,5sec led spento
		}else{
			pendolo = 1;
			allOff();
		}
		
		if(j == n){
			//devo fare stare acceso l'ultimo led per 1,5sec e poi devo spegerlo iniziando il gioco
			j=257;
			mostro_sequenza = 0;	//setto il flag mostro_sequenza = 0 se ho finito di mostrare tutta la sequenza, ora tocca giocare
		}
	}
		
	//ignoro gli interrupt di timer, ora è il momento di ricevere interrupt dai pulsanti

	
	//qui scrivo cosa farà  il timer, le funzioni le definisco in func_led.c e i prototipi in led.h
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
