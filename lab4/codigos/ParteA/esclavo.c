#include <avr/io.h>
#include <util/delay.h>

#define SS 1  
#define MOSI 3 
#define MISO 4 
#define SCLK 5 

void SPI_SlaveInit()
{
	DDRB |= (1 << MISO);  
	SPCR = (1 << SPE);    
}

uint8_t SPI_SlaveReceive()
{
	while (!(SPSR & (1 << SPIF))); 
	return SPDR;  
}

int main()
{
	SPI_SlaveInit();  
	_delay_ms(10);  

	while (1) {
		unsigned char received = SPI_SlaveReceive(); 

		if (received == 'R') {
		
			PORTD |= (1 << PD3);  
			} else if (received == 'W') {
		
			PORTD |= (1 << PD4);  
			} else {
		
			PORTD &= ~(1 << PD3); 
			PORTD &= ~(1 << PD4); 
		}
	}

	return 0;
}
