#include <reg52.h>

#define sound_velocity 34300  	/* sound velocity in cm per second */

#define period_in_us 0.000001
#define Clock_period 1.085*period_in_us		/* period for clock cycle of 8051*/

sbit Trigger_pin = P3^6;        	/* Trigger pin */
sbit Echo_pin = P3^7;		/* Echo pin */

#define LcdDataBus  P2
sbit LCD_RS = P1^0;
sbit LCD_RW = P1^1;
sbit LCD_EN = P1^2;

/* local function to generate delay */
void delay_us(int cnt) {
    for(int i = 0; i < cnt; i++);
}

/* Function to send the command to LCD */
void Lcd_CmdWrite(char cmd) {
    LcdDataBus = cmd;    // Send the command to LCD
    LCD_RS = 0;          // Select the Command Register by pulling RS LOW
    LCD_RW = 0;          // Select the Write Operation  by pulling RW LOW
    LCD_EN = 1;          // Send a High-to-Low Pusle at Enable Pin
    delay_us(10);
    LCD_EN = 0;
    delay_us(1000);
}

/* Function to send the Data to LCD */
void Lcd_DataWrite(char dat) {
    LcdDataBus = dat;	  // Send the data to LCD
    LCD_RS = 1;	      // Select the Data Register by pulling RS HIGH
    LCD_RW = 0;          // Select the Write Operation by pulling RW LOW
    LCD_EN = 1;	      // Send a High-to-Low Pusle at Enable Pin
    delay_us(10);
    LCD_EN = 0;
    delay_us(1000);
}

void delay(int k) {
	for(int i = 0; i < k; i++)
		for(int j = 0; j < 112; j++);
}

void Delay_us() {
	TL0 = 0xF5;
	TH0 = 0xFF;
	TR0 = 1;
	while(TF0 == 0);
		TR0 = 0;
	TF0 = 0;
}

void init_timer() {
	TMOD = 0x01;										/*initialize Timer*/
	TF0 = 0;
	TR0 = 0;
}

void send_trigger_pulse() {
	Trigger_pin = 1;           	/* pull trigger pin HIGH */
	Delay_us();               	/* provide 10uS Delay*/
	Trigger_pin = 0;          	/* pull trigger pin LOW*/
}

void main()
{
	float distance_measurement = 10;
	//unsigned char distance_in_cm[10];
	
	Lcd_CmdWrite(0x38);        // enable 5x7 mode for chars 
    Lcd_CmdWrite(0x0E);        // Display OFF, Cursor ON
    Lcd_CmdWrite(0x01);        // Clear Display
    Lcd_CmdWrite(0x80);        // Move the cursor to beginning of first line

	
	init_timer();    			/* Initialize Timer*/
	while(1) {		
		float distance_measurement = 10, value;
		int	temp, temp1, temp2, temp3, temp4, temp5;
		Lcd_CmdWrite(0xc0);

		send_trigger_pulse();			/* send trigger pulse of 10us */
    
		while(!Echo_pin);           		/* Waiting for Echo */
			TR0 = 1;                    		/* Timer Starts */
	   	while(Echo_pin && !TF0);    		/* Waiting for Echo goes LOW */
		   	TR0 = 0;                    		/* Stop the timer */
	  
		/* calculate distance using timer */
		value = Clock_period * sound_velocity; 
		distance_measurement = (TL0|(TH0<<8));	/* read timer register for time count */
		distance_measurement = (distance_measurement*value)/2.0;  /* find distance(in cm) */
		distance_measurement = distance_measurement * 1000;
		temp = distance_measurement/10;
		temp1 = distance_measurement-temp*10;
		
		distance_measurement =distance_measurement/10;
		temp = distance_measurement/10;
		temp2 = distance_measurement-temp*10;

		distance_measurement =distance_measurement/10;
		temp = distance_measurement/10;
		temp3 = distance_measurement-temp*10;

		distance_measurement =distance_measurement/10;
		temp = distance_measurement/10;
		temp4 = distance_measurement-temp*10;

		distance_measurement =distance_measurement/10;
		temp = distance_measurement/10;
		temp5 = distance_measurement-temp*10;

		Lcd_DataWrite('0'+temp5);
		Lcd_DataWrite('0'+temp4);
		Lcd_DataWrite('.');
		Lcd_DataWrite('0'+temp3);
		Lcd_DataWrite('0'+temp2);
		Lcd_DataWrite('0'+temp1);
		
		Lcd_DataWrite('c');
		Lcd_DataWrite('m');	
					
		delay(100);		   
	}
}