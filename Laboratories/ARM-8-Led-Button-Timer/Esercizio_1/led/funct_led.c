#include "lpc17xx.h"
#include "led.h"


/*----------------------------------------------------------------------------
  Used defined functions
 *----------------------------------------------------------------------------*/

void ledOn(int x)
{
	switch(x-4){
		case 0:
			LPC_GPIO2->FIOSET = 0x00000080;		//accendo il led4
			break;
		case 1:
			LPC_GPIO2->FIOSET = 0x00000040;		//accendo il led5
			break;
		case 2:
			LPC_GPIO2->FIOSET = 0x00000020;		//accendo il led6
		break;
	}
}

void allOff()
{
		LPC_GPIO2->FIOCLR |= 0x000000FF;		//spengo tutti i led
}

//leggo vettore di sequenza scritta in handler timer per conoscere la sequenza dei pulsanti che devono essere accesi
