#define PCF8574 0x27

#include <xc.h>
#include <avr/io.h>
#include <util/twi.h>
#define F_CPU 16000000UL
#include <util/delay.h>
#include "twi_lcd.h"
#include <avr/interrupt.h>

#define SS 2
#define MOSI 3
#define MISO 4
#define SCLK 5
#define BUTTON_LED PB0  
#define BUTTON_MOTOR PB1 
#define BUTTON_BUZZER PD2 


#define DHT_PIN PC0

uint8_t humidity_int = 0;
uint8_t temperature_int = 0;

void UART_init(uint16_t ubrr);
void UART_sendChar(char c);
void UART_sendString(const char *str);
void UART_sendInteger(int num);
void DHT_start(void);
uint8_t DHT_response(void);
uint8_t DHT_read(void);
void int_to_str(int num, char *str);


uint8_t led_state = 0;   // Estado del LED
uint8_t motor_state = 0; // Estado del motor
uint8_t buzzer_state = 0; // Estado del buzzer

void SPI_MasterInit();
void SPI_MasterTransmit(char data, char slave);
uint8_t SPI_MasterReceive();


void int_to_str(int num, char *str) {
	int i = 0;
	int is_negative = 0;

	if (num < 0) {
		is_negative = 1;
		num = -num;
	}

	do {
		str[i++] = (num % 10) + '0';
		num /= 10;
	} while (num > 0);

	if (is_negative) {
		str[i++] = '-';
	}

	str[i] = '\0';

	for (int j = 0; j < i / 2; j++) {
		char temp = str[j];
		str[j] = str[i - j - 1];
		str[i - j - 1] = temp;
	}
}

void DHT_start() {
	DDRC |= (1 << DHT_PIN);
	PORTC &= ~(1 << DHT_PIN);
	_delay_ms(20);
	PORTC |= (1 << DHT_PIN);
	_delay_us(50);
}

uint8_t DHT_response() {
	DDRC &= ~(1 << DHT_PIN);
	_delay_us(40);

	if (!(PINC & (1 << DHT_PIN))) {
		_delay_us(80);
		
		if (PINC & (1 << DHT_PIN)) {
			_delay_us(80);
			return 1;
		}
	}
	
	return 0;
}

uint8_t DHT_read() {
	uint8_t result = 0;
	
	for (int i = 0; i < 8; i++) {
		while (!(PINC & (1 << DHT_PIN))); // Espera pulso alto
		_delay_us(30);
		
		if (PINC & (1 << DHT_PIN))
		result |= (1 << (7 - i));
		
		while (PINC & (1 << DHT_PIN)); // Espera pulso bajo
	}
	
	return result;
}

void read_DHT_data() {
	DHT_start();
	if (DHT_response()) {
		humidity_int = DHT_read();      
		DHT_read();                    
		temperature_int = DHT_read();   
		DHT_read();                     
		DHT_read();                    
	}
}




int main() {
	twi_init();
	twi_lcd_init();
	twi_lcd_cmd(0x80);
	twi_lcd_clear();
	SPI_MasterInit();
	_delay_ms(10);

	DDRB &= ~((1 << BUTTON_LED) | (1 << BUTTON_MOTOR)); // Configura PB0 y PB1 como entradas
	PORTB |= (1 << BUTTON_LED) | (1 << BUTTON_MOTOR);  // Habilita pull-up en PB0 y PB1

	DDRD &= ~(1 << BUTTON_BUZZER); // Configura PD2 como entrada
	PORTD |= (1 << BUTTON_BUZZER); // Habilita pull-up en PD2
	uint16_t ubrr = F_CPU/16/9600 - 1;

	_delay_ms(50);

	twi_init();
	twi_lcd_init();
	twi_lcd_cmd(0x80);
	
	twi_lcd_clear();
	char buffer[16];
	
		read_DHT_data(); // Leer datos de humedad y temperatura del DHT11
		
		// Mostrar humedad en la primera línea
		twi_lcd_cmd(0x80);   
		twi_lcd_msg("Humedad: ");
		int_to_str(humidity_int, buffer); // Convertir humedad a cadena
		twi_lcd_msg(buffer);
		twi_lcd_msg("%");     
	
		twi_lcd_cmd(0xC0);    
		twi_lcd_msg("Temp: ");
		int_to_str(temperature_int, buffer); // Convertir temperatura a cadena
		twi_lcd_msg(buffer);
		twi_lcd_msg("C");    
		
		_delay_ms(2000); 

	while (1) {
		// Control del LED
		if (!(PINB & (1 << BUTTON_LED))) { // Si el botón del LED está presionado
			_delay_ms(50); // Debouncing
			if (!(PINB & (1 << BUTTON_LED))) {
				led_state = !led_state; // Cambia el estado del LED
				SPI_MasterTransmit(led_state ? 'R' : 'r', SS); // 'R' para encender, 'r' para apagar
				_delay_ms(10);

				twi_lcd_cmd(0xC0); // Cambiar a la segunda línea
				twi_lcd_clear();
				twi_lcd_msg(led_state ? "     Prendio BUZZER" : "       Apago BUZZER");
			}
		}

		// Control del motor
		if (!(PINB & (1 << BUTTON_MOTOR))) { // Si el botón del motor está presionado
			_delay_ms(50); // Debouncing
			if (!(PINB & (1 << BUTTON_MOTOR))) {
				motor_state = !motor_state; // Cambia el estado del motor
				SPI_MasterTransmit(motor_state ? 'M' : 'm', SS); // 'M' para encender, 'm' para apagar
				_delay_ms(10);

				twi_lcd_cmd(0xC0); // Cambiar a la segunda línea
				twi_lcd_clear();
				twi_lcd_msg(motor_state ? "     Motor prendido" : "     Motor apagado!");
			}
		}

		// Control del buzzer
		if (!(PIND & (1 << BUTTON_BUZZER))) { // Si el botón del buzzer está presionado
			_delay_ms(50); // Debouncing
			if (!(PIND & (1 << BUTTON_BUZZER))) {
				buzzer_state = !buzzer_state; // Cambia el estado del buzzer
				SPI_MasterTransmit(buzzer_state ? 'F' : 'f', SS); // 'F' para encender, 'f' para apagar
				_delay_ms(10);

				twi_lcd_cmd(0xC0); // Cambiar a la segunda línea
				twi_lcd_clear();
				twi_lcd_msg(buzzer_state ? "     Prendio LED" : "       Apago LED");
			}
		}
	}

	return 0;
}

void SPI_MasterInit() {
	DDRB |= (1 << MOSI) | (1 << SCLK) | (1 << SS); // Configura pines de salida
	SPCR = (1 << SPE) | (1 << MSTR) | (1 << SPR0); // Habilita SPI, modo maestro, velocidad f/16
}

void SPI_MasterTransmit(char data, char slave) {
	PORTB &= ~(1 << slave); // Baja SS para seleccionar el esclavo
	SPDR = data;
	while (!(SPSR & (1 << SPIF))); // Espera a que se complete la transmisión
	PORTB |= (1 << slave); // Sube SS para deseleccionar el esclavo
}

uint8_t SPI_MasterReceive() {
	while (!(SPSR & (1 << SPIF))); // Espera a que se complete la recepción
	return SPDR; // Devuelve el dato recibido
}


lcd_spi_maestro
