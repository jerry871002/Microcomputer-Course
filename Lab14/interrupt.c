#include<REG51.h>
#include<intrins.h> 

void delay_us(unsigned int);
void delay_ms(unsigned int);
void main(void)
{
	IE = 0x81;       //EX0 = 1    EA = 1
	TCON = 0x01;     //IT0 = 1  falling edge	
	P1 = 0xFF;
	while(1);
}

void int0(void) interrupt 0
{
	P1 = 0x00;
	delay_ms(100);
	P1 = 0xFF;
	IE0 = 0;
}

void delay_us(unsigned int n)
{
	while(n--)
	{
	  _nop_();
	}
}

void delay_ms(unsigned int time)
{
	while(time--)
	{
		delay_us(1000);
	}
}
