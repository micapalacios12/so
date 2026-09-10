#include "edoslib.h" 

int main(void)
{
    printf("EDOS init process: pid=%d!\n", getpid());

    int tiempo_inicio = time();
    printf("Tiempo inicial del sistema: %d ticks.\n", tiempo_inicio);

    console_puts("Init going to sleep for 4 ticks...\n");
    sleep(4);

    int tiempo_final = time();
    printf("Tiempo final del sistema: %d ticks.\n", tiempo_final);
    printf("Ticks transcurridos totales: %d\n", (tiempo_final - tiempo_inicio));

    console_puts("init awake! Finishing...\n");
    return 0;
}
