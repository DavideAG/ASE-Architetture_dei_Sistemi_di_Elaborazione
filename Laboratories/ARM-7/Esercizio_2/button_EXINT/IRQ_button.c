#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"

int controllo = 0;

void EINT0_IRQHandler (void)	  
{
	unsigned int scelta = var%2;
	unsigned int mask = LPC_GPIO2->FIOPIN;
	unsigned int basso;
  
	LPC_SC->EXTINT = (1 << 0);     /* clear pending interrupt         */

	if((rimbalzo == controllo) || (rimbalzo == controllo+1))								//in questo caso allora sono in rimbalzo allora non faccio nulla
		return;

	
	if(scelta == 0)								//accendo il led in modo randomico
		mask |= 0x00000008;					//accendo il led 8
	else
		mask |= 0x00000004;					//accendo il led 9
	
	var++;
	basso = mask & 0x000000FF;		//salvo in basso la parte di fiopin che comanda gli 8 led
	
	if((basso == 0x000000A8) || (basso == 0x00000054))				//guardo la configurazione di basso. Vinco se negli ultimi 8 bit ho 10101000 oppure 01010100
		mask |= 0x00000001;																			//se ho vinto accendo il led 11 forzando il bit opportuno ad 1
	else
		mask |= 0x00000002;																			//se ho perso accendo il led 10 forzando il bit opportuno ad 1

	LPC_GPIO2->FIOPIN = mask;																	//accendo i led scrivendo effettivamente su FIOPIN

	controllo = rimbalzo;
}

void EINT1_IRQHandler (void)	  
{
	unsigned int scelta = var%2;
	unsigned int mask = LPC_GPIO2->FIOPIN & 0xFFFFFF00;	//scrivo fiopin in mask abbattendo gli ultimi 8 bit a 0
	
	LPC_SC->EXTINT = (1 << 1);     /* clear pending interrupt         */
	
	if((rimbalzo == controllo) || (rimbalzo == controllo+1))								//in questo caso allora sono in rimbalzo allora non faccio nulla
		return;

	
	if(scelta == 0)								//accendo il led in modo randomico
		mask |= 0x00000080;					//accendo il led 4
	else
		mask |= 0x00000040;					//accendo il led 5
	
	var++;
	LPC_GPIO2->FIOPIN = mask;			//scrivo FIOPIN

	controllo = rimbalzo;
}

void EINT2_IRQHandler (void)	  
{
	unsigned int scelta = var%2;
	unsigned int mask = LPC_GPIO2->FIOPIN;	//scrivo fiopin in mask
  
	LPC_SC->EXTINT = (1 << 2);     /* clear pending interrupt         */ 
	
	if((rimbalzo == controllo) || (rimbalzo == controllo+1))								//in questo caso allora sono in rimbalzo allora non faccio nulla
		return;

	
	if(scelta == 0)								//accendo il led in modo randomico
		mask |= 0x00000020;					//accendo il led 6
	else
		mask |= 0x00000010;					//accendo il led 7
	
	var++;
	LPC_GPIO2->FIOPIN = mask;			//scrivo FIOPIN

	controllo = rimbalzo;
}
