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
#define BUTTON_LED PB0   // Botón para el LED conectado a PB0
#define BUTTON_MOTOR PB1 // Botón para el motor conectado a PB1
#define BUTTON_BUZZER PD2 // Botón para el buzzer conectado a PD2

uint8_t led_state = 0;   // Estado del LED
uint8_t motor_state = 0; // Estado del motor
uint8_t buzzer_state = 0; // Estado del buzzer

void SPI_MasterInit();
void SPI_MasterTransmit(char data, char slave);
uint8_t SPI_MasterReceive();

int main() {
	twi_init();
	twi_lcd_init();
	twi_lcd_cmd(0x80);
	twi_lcd_clear();
	SPI_MasterInit();
	_delay_ms(10);

	// Configurar botones
	DDRB &= ~((1 << BUTTON_LED) | (1 << BUTTON_MOTOR)); // Configura PB0 y PB1 como entradas
	PORTB |= (1 << BUTTON_LED) | (1 << BUTTON_MOTOR);  // Habilita pull-up en PB0 y PB1

	DDRD &= ~(1 << BUTTON_BUZZER); // Configura PD2 como entrada
	PORTD |= (1 << BUTTON_BUZZER); // Habilita pull-up en PD2

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
				twi_lcd_msg(led_state ? "Prendio LED Roja " : "Apago LED Roja");
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
				twi_lcd_msg(motor_state ? "Motor prendido" : "Motor apagado!");
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
				twi_lcd_msg(buzzer_state ? "Prendio Buzzer " : "Apago Buzzer");
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
