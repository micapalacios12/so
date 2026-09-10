# Procesos

En este paso, añadimos la capacidad de cargar y ejecutar programas de usuario en el directorio `user`.

El sistema de compilación compila primero los programas de usuario, extrae y genera el contenido binario de los archivos de usuario (`init` y `README`) en `efs-files.c`.

La utilidad `xxd` es necesaria en esta etapa.

Finalmente, se compila el kernel.

Tras el arranque, en `kernel_main()`, la CPU inicializa el asignador de páginas, la paginación y ejecuta el programa de usuario `init`.

Añadimos un directorio de usuario con un sencillo programa `init` para probar nuestro primer programa (o proceso) en el espacio de usuario.

En el archivo fuente `kalloc.c` se crea un montón de páginas del kernel y se proporcionan funciones para la asignación y liberación de páginas.

En `vm.c` se encuentran funciones, macros y tipos de datos para la gestión de tablas de páginas y otras funciones de utilidad.

En `arch.h`, `arch.c` y `arch.s` se ampliaron para proporcionar funciones y macros para la gestión de memoria de bajo nivel, así como para el manejo de interrupciones y excepciones.


## Creación de Procesos

En `task.c`, añadimos la función `create_process()`. Los procesos tienen identificadores de proceso (pid).

Pasos para la creación de un proceso:

1. Crear una tarea. Es necesario configurar el contexto de la tarea para que comience en la función del kernel `start_process()` y utilice la pila del modo kernel de la tarea. Cuando el planificador selecciona esta tarea, cambia al contexto guardado de la tarea y salta a `start_process()`. Esta función sigue una ruta de ejecución hasta una interrupción mediante `return_to_user_mode()`. Esto configura los registros de estado de la CPU para que vuelvan al modo usuario cuando `u_trap_ret()` ejecuta la instrucción `sret`. 2. Se llama a la función `exec(tarea, ruta, argumentos)`, que carga el código del programa y
las secciones de datos, asigna (y mapea) una página para la pila del modo usuario e inserta
los argumentos de la línea de comandos del programa en ella. Finalmente, `exec()` establece el *contexto del hilo* de la tarea
y un *marco de trampa* para regresar del modo trampa al modo usuario. La rutina de bajo nivel
`u_trap_ret` regresa al punto de entrada del programa de usuario con el
puntero de pila correspondiente.

## Espacio de Direcciones

El kernel configura su propia tabla de páginas para mapear algunos dispositivos mapeados en memoria
(RELOJ, UART, etc.) y la RAM física a partir de 0x80000000 (2 GB). Los mapeos
son 1:1 (una dirección lógica = una dirección física).


Los procesos usarán un rango de espacio de direcciones virtuales de 0 a `PROC_MAX_VA=0x07FFFFFFF`.

La función `exec(tarea, ruta)` asigna memoria, carga desde el sistema de archivos y mapea las secciones de código y datos desde la dirección 0. La pila de usuario ocupa una página de memoria y se mapea en `PROC_MAX_VA - PAGE_SIZE`, lo que resulta en la siguiente estructura:


```
    process logical
    addresses space
    +------------+ 0x00000000
    |    code    |
    |     +      |
    |    data    |
    +------------+
    |            |
    |    free    |
    |   space    |
    |            |
    +------------+
    |    stack   |
    +------------+
                   0x80000000
```

## Manejo de Interrupciones

Las interrupciones pueden ocurrir cuando la CPU está en modo usuario o kernel. Para la arquitectura RISC-V, disponemos de dos manejadores de interrupciones de bajo nivel:


- `s_trap`: Maneja las interrupciones (interrupciones y excepciones) cuando la CPU está en modo supervisor.
Tras guardar los registros de la CPU en la pila actual, llama al manejador de trampas de alto nivel `kernel_trap()` en `trap.c`.

- `u_trap`: Maneja las trampas cuando la CPU está en modo usuario. Cambia a la pila del modo kernel, guarda los registros de la CPU y llama a la función de alto nivel `user_trap()`.

La función `user_trap()` maneja interrupciones/excepciones y despacha llamadas al sistema.

Antes de que finalice una trampa en modo usuario, se llama a la rutina `u_trap_ret()` (desde
`return_to_user_mode()`). Esta rutina restaura los valores guardados de la CPU del proceso desde la pila y vuelve al modo usuario.

## Llamadas al Sistema

Definimos un pequeño conjunto de llamadas al sistema (véase `syscall.c`):


| Syscall                         | Description                                |
| ------------------------------- | ------------------------------------------ |
| `int exit(int exit_code)`       | Process exits.                             |
| `int getpid(void)`              | Get process identifier.                    |
| `int console_puts(char *str)`   | Print string by console.                   |
| `int console_putc(char c)`      | Print the character *c* string by console. |
| `int console_getc(void)`        | Read a character from console.             |
| `int sleep(int ticks)`          | Wait (suspend process) by given ticks      |

### Biblioteca Edos en Modo Usuario


El programa de usuario `init` y un archivo de datos `README` se encuentran en el directorio `user`.

Los programas de usuario se compilan y enlazan con la pequeña biblioteca edos (estática) construida
a partir de `edoslib.c` y `usys.s`.

Las llamadas al sistema se implementan en RISC-V cargando el número de llamada en el registro `a7`, los argumentos de la llamada se encuentran en los registros `a0-a6` (el código generado por el compilador) y ejecutando la instrucción `ecall`.

El archivo `Makefile` compilará y enlazará los programas de usuario con un punto de entrada de 0, que corresponde a la función `start()` definida en `edoslib.c` (debería ser la primera función definida).

## EFS: Un Sistema de Archivos Embebido Simple

EDOS necesita un sistema de archivos para almacenar programas y archivos de datos de usuario. En este proyecto,
construimos un sistema de archivos muy simple. La imagen del sistema de archivos se puede vincular al kernel
como datos binarios y, por lo tanto, QEMU la carga al arrancar. Este es un sistema de archivos en RAM.

El script `mkefs.sh` realiza esta tarea utilizando la utilidad `xxd`.

En `task.c`, la función `load_program(pgtbl, file_name)` (llamada por `exec()`)
carga los datos binarios del programa (en `edos-files.c`) en la memoria recién asignada y
mapea el espacio de direcciones virtuales *[0, tamaño del programa]*.

## Ejercicios


1. Arranca EDOS y observa la ejecución de init.

2. Describe cómo funciona el *asignador de páginas físicas*. Consulta los archivos `kalloc.h/c`.

3. Dibuja un diagrama del espacio de direcciones lógicas del kernel que muestre las asignaciones
definidas en la función `map_kernel_memory()` en `arch.c`. 4. Describe los pasos que realiza la función `create_process()` (en `task.c`).

5. Analiza cómo se compilan y enlazan los programas de usuario.

- Analiza el script del enlazador `user.ld`.

- ¿Cuál es la dirección del punto de entrada del programa? ¿A qué función corresponde?

- Describe cómo el script `mkefs.sh` crea el contenido binario de los archivos en
`efsfiles.c`.

6. Describe los pasos de ejecución desde la primera tarea programada hasta el inicio de la ejecución del código.

7. Modifica `init.c` para generar un fallo de página.

8. Explica cómo se implementa la llamada al sistema `getpid()`. Consulta `edoslib.h` y

`usys.s`.

- Describe los pasos desde la llamada al sistema `getpid()` hasta su retorno.

9. Añade una llamada al sistema `time` que devuelva el valor de los `ticks` transcurridos desde el arranque.
Modifique el programa `init.c` para probarlo.
