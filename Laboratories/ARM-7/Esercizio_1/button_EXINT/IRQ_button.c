#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"

int controllo = 0;

void EINT0_IRQHandler (void)	  
{
  unsigned int mask = LPC_GPIO2->FIOPIN;
	unsigned int mask2 = 0xFFFFFF00 & mask;
	LPC_SC->EXTINT |= (1 << 0);     					/* clear pending interrupt         */
	mask2 |= 0x00000008;
	LPC_GPIO2->FIOPIN = mask2;						//accendo il led 4 e spengo gli altri
}


void EINT1_IRQHandler (void)	  
{
	unsigned int mask = LPC_GPIO2->FIOPIN;
	unsigned int mask2 = mask & 0x000000FF;		//mask2 contiene solo i bit bassi
	mask &= 0xFFFFFF00;												//in mask salvo i 24 bit alti e azzero gli ultimi 8
	
  LPC_SC->EXTINT |= (1 << 1);     					/* clear pending interrupt         */

	//GESTIONE RIMBALZO
	if((rimbalzo == controllo) || (rimbalzo == controllo+1))								//in questo caso allora sono in rimbalzo allora non faccio nulla
		return;
	//FINE RIMBALZO - da completare
	
	if(mask2 >= 0x00000080){									//se ho il led 4 acceso
		mask2 = 0x00000001;											//preparo la configurazione per accendere il led 11 e spegnere il resto
	}else
		mask2 = mask2<<1;												//shift normale di mask2
	
	mask |= mask2;														//scrivo in mask la configurazione finale
	LPC_GPIO2->FIOPIN = mask;									//scrivo in FIOPIN
	
	controllo = rimbalzo;											//aggiorno il valore di controllo per evitare rimbalzi

}

void EINT2_IRQHandler (void)	  
{
  unsigned int mask = LPC_GPIO2->FIOPIN;
	unsigned int mask2 = mask & 0x000000FF;		//contiene gli ultimi 8 bit che gestiscono i led
	mask &= 0xFFFFFF00;												//azzero gli ultimi 8 bit
	
	LPC_SC->EXTINT |= (1 << 2);     					/* clear pending interrupt         */  

	if((rimbalzo == controllo) || (rimbalzo == controllo+1))								//in questo caso allora sono in rimbalzo allora non faccio nulla
		return;
	
	if((mask2 % 2) != 0){											//se led 11 acceso quindi valore in fiopin dispari. Avrei potuto fare mask2==0x00000001
		mask2 = 0x00000080;											//accendo solo il led4
	}else
		mask2 = mask2>>1;												//shift a dx

	mask |= mask2;														//creo la configurazione finale
	LPC_GPIO2->FIOPIN = mask;									//scrivo FIOPIN

	controllo = rimbalzo;											//aggiorno il valore di controllo per evitare rimbalzi
}
