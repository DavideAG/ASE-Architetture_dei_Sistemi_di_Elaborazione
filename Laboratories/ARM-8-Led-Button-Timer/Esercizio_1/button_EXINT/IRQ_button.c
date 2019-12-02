#include "button.h"
#include "lpc17xx.h"

#include "../led/led.h"

extern int n;
extern int vett[];
extern int mostro_sequenza;
extern int premuti;
extern int pendolo;
extern int j;
extern int bounce;

void EINT0_IRQHandler (void)	//devo controllare se alla posizione premuti di vett avevo acceso il led6  
{
	int i = 0;
	
	if((LPC_TIM1->TC - bounce) < 0x17D7840)		//controllo timbalzo 1 secondo
		return;
	
  LPC_SC->EXTINT = (1 << 0);    						 /* clear pending interrupt         */

	if(premuti == -1){												//in questo caso devo iniziare una nuova partita, perché si è premuto il pulsante
		allOff();																//spengo tutti i led
		for(i=0; i<256; i++)
			vett[i] = 0;													//azzero vett per la prossima giocata
		mostro_sequenza = 1;										//imposto per lanciare una nuova sequenza
		pendolo = 1;
		premuti = 0;														//imposto premuti
		j = 0;
		return;																	//inizio una nuova partita, al prossimo interrupt del timer accenderò un led casuale partendo con n=1
	}
	if(premuti < n)
		if(vett[premuti++] != 6){
			//stampa in binario il numero che sta in premuti-1
			LPC_GPIO2->FIOPIN |= premuti;					//mostro il livello dove si è sbagliato
			premuti = -1;													//reimposto i valori per ricominciare a giocare dal livello 1
			n = 1;
			return;
		}
	//SE SONO QUI ALLORA HO VINTO
	//MOSTRO VALORE DI N IN BINARIO, RICOMINCIO IL GIOCO CON n=n+1
	if(premuti == n){
		LPC_GPIO2->FIOPIN |= premuti;						//accendo i led opportuni
		premuti = - 1;
		n++;
	}
	//n++;

	bounce = LPC_TIM1->TC;
	
	return;
}


void EINT1_IRQHandler (void)								//devo controllare se alla posizione premuti di vett avevo acceso il led4  
{
	int i = 0;
	LPC_SC->EXTINT = (1 << 1);  					   /* clear pending interrupt         */

		if((LPC_TIM1->TC - bounce) < 0x17D7840)
		return;
	
	if(premuti == -1){												//in questo caso devo iniziare una nuova partita, perché si è premuto il pulsante
		allOff();																//spengo tutti i led
		for(i=0; i<256; i++)
			vett[i] = 0;													//azzero vett per la prossima giocata
		mostro_sequenza = 1;										//imposto per lanciare una nuova sequenza
		pendolo = 1;
		premuti = 0;														//imposto premuti
		j = 0;
		return;																	//inizio una nuova partita, al prossimo interrupt del timer accenderò un led casuale partendo con n=1
	}
	if(premuti < n)
		if(vett[premuti++] != 4){
			//stampa in binario il numero che sta in premuti-1
			LPC_GPIO2->FIOPIN |= premuti;					//mostro il livello dove si è sbagliato
			premuti = -1;													//reimposto i valori per ricominciare a giocare dal livello 1
			n = 1;
			return;
		}
	//SE SONO QUI ALLORA HO VINTO
	//MOSTRO VALORE DI N IN BINARIO, RICOMINCIO IL GIOCO CON n=n+1
	if(premuti == n){
		LPC_GPIO2->FIOPIN |= premuti;						//accendo i led opportuni
		premuti = - 1;
		n++;
	}
//	n++;
	bounce = LPC_TIM1->TC;
}

void EINT2_IRQHandler (void)								//devo controllare se alla posizione premuti di vett avevo acceso il led5
{
	int i = 0;
  LPC_SC->EXTINT = (1 << 2);    					 /* clear pending interrupt         */    

		if((LPC_TIM1->TC - bounce) < 0x17D7840)
		return;
	
	if(premuti == -1){												//in questo caso devo iniziare una nuova partita, perché si è premuto il pulsante
		allOff();																//spengo tutti i led
		for(i=0; i<256; i++)
			vett[i] = 0;													//azzero vett per la prossima giocata
		mostro_sequenza = 1;										//imposto per lanciare una nuova sequenza
		pendolo = 1;
		premuti = 0;														//imposto premuti
		j = 0;
		return;																	//inizio una nuova partita, al prossimo interrupt del timer accenderò un led casuale partendo con n=1
	}
	if(premuti < n)
		if(vett[premuti++] != 5){
			//stampa in binario il numero che sta in premuti-1
			LPC_GPIO2->FIOPIN |= premuti;					//mostro il livello dove si è sbagliato
			premuti = -1;													//reimposto i valori per ricominciare a giocare dal livello 1
			n = 1;
			return;
		}
	//SE SONO QUI ALLORA HO VINTO
	//MOSTRO VALORE DI N IN BINARIO, RICOMINCIO IL GIOCO CON n=n+1
	if(premuti == n){
		LPC_GPIO2->FIOPIN |= premuti;						//accendo i led opportuni
		premuti = -1;
		n++;
		
		bounce = LPC_TIM1->TC;
	}
	//n++;
}


