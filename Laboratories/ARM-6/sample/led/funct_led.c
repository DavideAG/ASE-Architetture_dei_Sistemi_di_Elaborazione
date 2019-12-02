#include "led.h"
#include "lpc17xx.h"		//per vedere la costante LPC_GPIO2. In questo file è chiarata tale costante

void led4and11_On(void)
{
		LPC_GPIO2->FIOSET   |= 0x00000081;  //P2.0...P2.7 Output LEDs on PORT2 defined as Output
}


//metto a 1 i bit di tutti i led
//noi vogliamo mettere 1000 0001 che equivale a 0x81 per accendere il led 4 e il led 11
//i led vanno da 4 a 11
//in OR perché cambio lo stato dei bit indicati tranne quelli che metto a 0

void led4_Off(void)
{
	LPC_GPIO2->FIOCLR |= 0x00000080;		//metto ad 1 il bit che mi permetterà di spegnere il led4 
}

void ledEvenOn_OddOf(void)
{
	unsigned int mask = LPC_GPIO2->FIOPIN & 0xFFFFFF00;
	mask |= 0x000000AA;
	LPC_GPIO2->FIOPIN = mask;
	//LPC_GPIO2->FIOPIN &= 0xFFFFFFAA;
	//LPC_GPIO2->FIOPIN |= 0x000000AA;
}

void LED_On(unsigned int num){	//accende il led passato come parametro
	switch(num){
		case 0:
			LPC_GPIO2->FIOSET	|= 0x00000080;
			break;
		case 1:
			LPC_GPIO2->FIOSET	|= 0x00000040;
			break;
		case 2:
			LPC_GPIO2->FIOSET	|= 0x00000020;
			break;
		case 3:
			LPC_GPIO2->FIOSET	|= 0x00000010;
			break;
		case 4:
			LPC_GPIO2->FIOSET	|= 0x00000008;
			break;
		case 5:
			LPC_GPIO2->FIOSET	|= 0x00000004;
			break;
		case 6:
			LPC_GPIO2->FIOSET	|= 0x00000002;
			break;
		case 7:
			LPC_GPIO2->FIOSET	|= 0x00000001;
			break;
		default:
			break;
	}
}

void LED_Off(unsigned int num){	//accende il led passato come parametro
	switch(num){
		case 0:
			LPC_GPIO2->FIOCLR	|= 0x00000080;
			break;
		case 1:
			LPC_GPIO2->FIOCLR	|= 0x00000040;
			break;
		case 2:
			LPC_GPIO2->FIOCLR	|= 0x00000020;
			break;
		case 3:
			LPC_GPIO2->FIOCLR	|= 0x00000010;
			break;
		case 4:
			LPC_GPIO2->FIOCLR	|= 0x00000008;
			break;
		case 5:
			LPC_GPIO2->FIOCLR	|= 0x00000004;
			break;
		case 6:
			LPC_GPIO2->FIOCLR	|= 0x00000002;
			break;
		case 7:
			LPC_GPIO2->FIOCLR	|= 0x00000001;
			break;
		default:
			break;
	}
}
