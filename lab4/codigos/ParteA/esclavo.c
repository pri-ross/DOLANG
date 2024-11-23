spi_esclavo___spi


#define F_CPU 16000000UL
#include <avr/io.h>
#include <util/delay.h>

#define MISO 4
#define SCLK 5
#define LED PD7     // LED conectado a PD7
#define MOTOR PD3   // MOTOR conectado a PD3
#define BUZZER PD6  // BUZZER conectado a PD6

void SPI_SlaveInit();
uint8_t SPI_SlaveReceive();
void generateTone(uint16_t frequency);
void servoRotate(uint8_t angle);

int main() {
	DDRD |= (1 << LED) | (1 << MOTOR) | (1 << BUZZER); // Configura pines como salidas
	PORTD &= ~((1 << LED) | (1 << MOTOR) | (1 << BUZZER)); // Inicializa apagados

	SPI_SlaveInit();

	while (1) {
		uint8_t received = SPI_SlaveReceive();
		switch (received) {
			case 'F': PORTD |= (1 << LED); break;  // Encender LED
			case 'f': PORTD &= ~(1 << LED); break; // Apagar LED

			case 'M':  PORTD |= (1 << MOTOR); break;  // Encender MOTOR
			case 'm':  PORTD &= ~(1 << MOTOR); break; // Apagar MOTOR 

			case 'R':
			PORTD |= (1 << BUZZER);
			for (int i = 0; i < 10; i++) {
				generateTone(1000 + (i * 200)); // Tono variable
				_delay_ms(200);
			}
			PORTD &= ~(1 << BUZZER);
			break;

			case 'r': PORTD &= ~(1 << BUZZER); break; // Apagar buzzer
			default: break;
		}
	}

	return 0;
}

void SPI_SlaveInit() {
	DDRB |= (1 << MISO); // Configura MISO como salida
	SPCR = (1 << SPE);   // Habilita SPI
}

uint8_t SPI_SlaveReceive() {
	while (!(SPSR & (1 << SPIF))); // Espera a que se complete la recepción
	return SPDR; // Devuelve el dato recibido
}

void generateTone(uint16_t frequency) {
	if (frequency > 0) {
		uint16_t delayPeriod = 1000000 / frequency;
		for (uint16_t i = 0; i < 50; i++) {
			PORTD |= (1 << BUZZER);
			for (uint16_t j = 0; j < delayPeriod / 2; j++) {
				_delay_us(1);
			}
			PORTD &= ~(1 << BUZZER);
			for (uint16_t j = 0; j < delayPeriod / 2; j++) {
				_delay_us(1);
			}
		}
	}
}
