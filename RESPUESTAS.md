# Respuestas

## Parte A

### 1. `setState` y el botón atrás

Al pulsar el atrás del sistema, Control se cierra sin devolver un resultado. El caso de uso sí guardó el valor nuevo en disco, pero el campo local `_contador` del `State` de Visor conserva el valor anterior. No es un dato incorrecto en almacenamiento: es una pantalla que mantiene una copia desactualizada. Para sincronizarlo con `setState` deben coordinarse el estado de Visor, los argumentos de navegación, el estado de Control y el valor que Control devuelve y Visor aplica al volver.

### 2. Estado con Riverpod

El contador vive en el `ContadorNotifier`, administrado por el `ProviderContainer` que crea `ProviderScope`, no dentro de una pantalla. Visor y Control observan el mismo provider. Al volver con el botón del sistema no se pierde el estado y no hace falta devolver un resultado por la navegación.

### 3. `BlocObserver`

El observador registra cada transición del Cubit, permite reconstruir la secuencia de cambios y ubicar cuándo apareció un valor inesperado. Es útil al depurar una regresión o investigar un reporte que depende del orden de las acciones.

### 4. Comparación de ramas

Las dos primeras salidas están vacías: las ramas reutilizan exactamente el mismo `domain/` y `data/`. La tercera salida muestra diferencias en `presentation/`, donde vive el mecanismo de estado. Para reemplazar Riverpod, se reescribiría la presentación y su cableado, no los casos de uso ni el repositorio.

Los comandos se ejecutaron desde la raíz del repositorio, por eso incluyen el prefijo `parte_a_contador/`:

```text
$ git diff version/setstate version/riverpod -- parte_a_contador/lib/domain parte_a_contador/lib/data
(sin salida)

$ git diff version/setstate version/bloc -- parte_a_contador/lib/domain parte_a_contador/lib/data
(sin salida)

$ git diff --stat version/setstate version/bloc -- parte_a_contador/lib/presentation
.../lib/presentation/estado/contador_cubit.dart    | 23 ++++++++
.../presentation/pantallas/pantalla_control.dart   | 52 +++++++-------------
.../lib/presentation/pantallas/pantalla_visor.dart | 63 +++++-----------------
3 files changed, 50 insertions(+), 88 deletions(-)
```

### 5. Cuándo elegir cada opción

| | setState | Riverpod | Cubit |
|---|---|---|---|
| ¿Dónde vive el contador? | En el `State` de Visor. | En `ContadorNotifier`, bajo `ProviderScope`. | En el estado del `ContadorCubit`. |
| ¿Las pantallas se pasan datos? | Sí, Control recibe el valor y devuelve el resultado. | No; ambas observan el provider. | No; ambas leen el Cubit compartido. |
| Archivos de `presentation/` tocados | `pantalla_visor.dart`, `pantalla_control.dart` | `contador_provider.dart`, `pantalla_visor.dart`, `pantalla_control.dart` | `contador_cubit.dart`, `pantalla_visor.dart`, `pantalla_control.dart` |
| ¿Qué pasa con el botón atrás? | No devuelve el valor al Visor; su copia queda vieja. | El valor compartido sigue actualizado. | El valor compartido sigue actualizado. |
| ¿Se tocó `domain/`? | No. | No. | No. |

Para una pantalla elegiría `setState`: mantiene el estado local y evita añadir estructura que no aporta mucho. Para ocho pantallas y cinco datos compartidos elegiría Riverpod o Cubit; en esta comparación elegiría Cubit si el registro de transiciones facilita depurar al equipo.

`setState` sí es correcto para estado local y efímero de una pantalla, como un campo expandido, una selección temporal o un indicador de carga. También encaja cuando el estado no necesita persistir ni coordinarse con otras pantallas.

## Parte B

### 6. La consulta Future

La pantalla muestra la conexión que obtuvo al pulsar «Consultar ahora» y la hora de esa consulta. Si después se apaga el Wi‑Fi, esa lectura sigue siendo correcta para el momento en que se hizo, pero ya no describe el estado actual, no cambia hasta volver a consultar. No es un dato falso al recibirlo, sino una foto de un momento anterior.

### 7. Cancelar la suscripción

Sin cancelar en `close()`, la suscripción puede seguir reteniendo al Cubit y recibiendo eventos después de salir de la pantalla. Al entrar y salir muchas veces se acumularían listeners, trabajo duplicado y actualizaciones sobre Cubits cerrados, además de desperdiciar recursos.

### 8. Foto y película

La consulta Future pide una lectura puntual: por ejemplo, al pulsar el botón, devuelve si en ese instante hay Wi‑Fi, datos móviles o ninguna conexión. El Stream mantiene la pantalla al tanto de los cambios que ocurren después, sin que el usuario vuelva a pulsar.

Pediría con Future el perfil de usuario al abrir su cuenta y el detalle de una compra ya realizada. Observaría con Stream los cambios de conectividad y los mensajes nuevos de un chat.

## Nota de verificación manual

El análisis estático y las pruebas automatizadas pasaron, incluidas emisiones simuladas del Stream. No se probó el cambio real de Wi‑Fi en un teléfono; por eso las respuestas 6 y 8 describen el comportamiento implementado y esperado, y deben contrastarse con la observación del dispositivo antes de entregar. El video `demo.mp4` queda pendiente de grabación manual.
