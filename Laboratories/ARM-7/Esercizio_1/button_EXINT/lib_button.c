#include "button.h"
#include "lpc17xx.h"

/**
 * @brief  Function that initializes Button INT0
 */
void BUTTON_init(void) {

  LPC_PINCON->PINSEL4    |= (1 << 20);		 /* External interrupt 0 pin selection */	//configuro funzione EINT0
  LPC_GPIO2->FIODIR      &= ~(1 << 10);    /* PORT2.10 defined as input          */	//forzo a 0 il bit numero 10 della porta 2. Configuro EINT0 come pin input

  LPC_PINCON->PINSEL4    |= (1 << 22);     /* External interrupt 0 pin selection */	//funzione EINT1
  LPC_GPIO2->FIODIR      &= ~(1 << 11);    /* PORT2.11 defined as input          */	//forzo a 0 il bit numero 11 della porta 2. Configuro EINT1 come pin input
  
  LPC_PINCON->PINSEL4    |= (1 << 24);     /* External interrupt 0 pin selection */	//funzione EINT2
  LPC_GPIO2->FIODIR      &= ~(1 << 12);    /* PORT2.12 defined as input          */	//forzo a 0 il bit numero 12 della porta 2. Configuro EINT2 come pin input

  LPC_SC->EXTMODE = 0x7;

  NVIC_EnableIRQ(EINT2_IRQn);              /* enable irq in nvic                 */
  NVIC_EnableIRQ(EINT1_IRQn);              /* enable irq in nvic                 */
  NVIC_EnableIRQ(EINT0_IRQn);              /* enable irq in nvic                 */
	
	NVIC_SetPriority(EINT2_IRQn, 2);              /* priority, più alto valore meno priorità*/
																								//in questo caso eint2 avrà una priorità più bassa rispetto a EINT0 e EINT1
}
