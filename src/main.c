#include <unistd.h>
#include "bbb_gpiolib.h" // Inclui a nossa biblioteca com a API simplificada
#include "logger.h"

// Mude aqui para testar qualquer pino da tabela de configuração
#define LED_PIN_NAME "P8_13"

int main() {
    logger_init(LOG_LEVEL_INFO, NULL);
    logger_log(LOG_LEVEL_INFO, "Aplicacao iniciada.");

    // configura o pino
    GpioPin* led_pin = pinMode(LED_PIN_NAME, OUTPUT);

    if (!led_pin) {
        logger_log(LOG_LEVEL_ERROR, "MAIN: Falha ao inicializar o pino '%s'. Encerrando.", LED_PIN_NAME);
        logger_cleanup();
        return 1;
    }
    logger_log(LOG_LEVEL_INFO, "Pino '%s' configurado com sucesso. Iniciando o pisca-pisca.", LED_PIN_NAME);

    while (1) {
        digitalWrite(led_pin, HIGH);
        usleep(500000);
        digitalWrite(led_pin, LOW);
        usleep(500000);
    }
    
    releasePin(led_pin);
    logger_cleanup();
    return 0;
}