#include "lpc17xx.h"
#include "led.h"


/*----------------------------------------------------------------------------
  Used defined functions
 *----------------------------------------------------------------------------*/

void led4Off(void)
{
	LPC_GPIO2->FIOCLR	=	0x00000080;
}

void led4On(void)
{
	LPC_GPIO2->FIOSET	=	0x00000080;
}
