#include <avr/io.h>
#include "twi.h"  // Asumo que esta librería maneja la I2C para LCD.

void twi_init()
{
    DDRC = 0x03;      // Configura PC4 y PC5 como salida para SDA y SCL
    PORTC = 0x03;     // Habilita las resistencias pull-up internas en SDA y SCL
    TWCR &= ~(1<<TWEN); // Deshabilita TWI
    TWBR = BITRATE(TWSR = 0x00); // Configura la velocidad de la comunicación
    TWCR = (1<<TWEN); // Habilita TWI
    _delay_us(10);    // Pausa para la estabilización
}

void twi_start()
{
    TWCR= (1<<TWINT)|(1<<TWSTA)|(1<<TWEN); // Inicia la transmisión
    while(!(TWCR & (1<<TWINT))); // Espera a que la transmisión se complete
    while(TW_STATUS != TW_START); // Asegura que es un inicio válido
}

void twi_write_cmd(unsigned char address)
{
    TWDR = address;
    TWCR = (1<<TWINT)|(1<<TWEN); // Enviar comando
    while (!(TWCR & (1<<TWINT))); // Espera hasta que se complete
    while(TW_STATUS != TW_MT_SLA_ACK); // Espera el ACK del dispositivo
}

void twi_write_dwr(unsigned char data)
{
    TWDR = data;
    TWCR = (1<<TWINT)|(1<<TWEN); // Enviar datos
    while (!(TWCR & (1<<TWINT))); // Espera la transmisión
    while(TW_STATUS != TW_MT_DATA_ACK); // Espera el ACK de datos
}

void twi_stop()
{
    TWCR = (1<<TWINT)|(1<<TWEN)|(1<<TWSTO); // Detiene la comunicación
}

void twi_repeated_start()
{
    TWCR = (1<<TWINT)|(1<<TWSTA)|(1<<TWEN); // Repite la señal de inicio
    while(!(TWCR & (1<<TWINT))); // Espera que se complete
    while(TW_STATUS != TW_REP_START); // Asegura que es un inicio repetido
}

char twi_read_ack()
{
    TWCR = (1<<TWEN)|(1<<TWINT)|(1<<TWEA); // Lee datos con ACK
    while (!(TWCR & (1<<TWINT))); // Espera la transmisión
    while(TW_STATUS != TW_MR_DATA_ACK); // Espera el ACK
    return TWDR; // Devuelve el dato leído
}

char twi_read_nack()
{
    TWCR = (1<<TWEN)|(1<<TWINT); // Lee datos sin ACK
    while (!(TWCR & (1<<TWINT))); // Espera la transmisión
    while(TW_STATUS != TW_MR_DATA_NACK); // Espera el NACK
    return TWDR; // Devuelve el dato leído
}
