# Functions Design — team_payload.exe

Proyecto: **T4_Analisis_Deteccion_de_Binarios**

---

# 1. Objetivo

Definir la estructura lógica completa del binario antes de su implementación final en C++ utilizando Visual Studio.

Este documento describe:

* Funciones principales del programa
* Propósito de cada función
* Entradas y salidas
* Lógica funcional
* Flujo de ejecución

Este diseño servirá como base directa para el desarrollo del binario y su posterior análisis técnico.

---

# 2. Arquitectura General

El programa está diseñado de forma modular para facilitar:

* Análisis estático
* Ingeniería inversa
* Debugging dinámico
* Observación de memoria
* Generación de firmas YARA
* Identificación de capacidades con CAPA

Estructura principal:

```text
main()

├── printSuspiciousStrings()
├── addDecoyStrings()
├── checkDebugger()
├── requestPassword()
├── validatePassword()
├── decodeHiddenString()
├── simulateMemoryAllocation()
├── launchCalculator()
├── performDelay()
├── createDummyFile()
├── showFinalMessage()
```

---

# 3. Diseño de Funciones

---

# 3.1 main()

## Propósito

Controlar el flujo completo de ejecución del programa.

## Entradas

Ninguna

## Salidas

Código de salida del programa.

## Pseudocódigo

Inicio del programa

Llamar printSuspiciousStrings()

Llamar addDecoyStrings()

Si checkDebugger() == TRUE
 Mostrar "Debugger detected"
 Terminar programa

password = requestPassword()

Si validatePassword(password) == FALSE
 Mostrar "Access Denied"
 Terminar programa

Llamar simulateMemoryAllocation()

Llamar launchCalculator()

Llamar performDelay()

Llamar createDummyFile()

Llamar showFinalMessage()

Fin del programa

---

# 3.2 printSuspiciousStrings()

## Propósito

Mostrar cadenas sospechosas visibles en análisis estático.

## Entradas

Ninguna

## Salidas

Salida por consola.

## Strings sugeridas

"MAGIC: edu-malware-sim"
"Initializing system components..."
"Loading encrypted payload..."
"System ready."

## Valor técnico

* Detectables mediante YARA
* Observables en strings del binario

---

# 3.3 addDecoyStrings()

## Propósito

Agregar cadenas falsas diseñadas para aumentar superficie de análisis.

## Entradas

Ninguna

## Salidas

Cadenas adicionales visibles en memoria.

## Strings sugeridas

"malware_payload_loaded"
"stealth_mode_enabled"
"injecting_memory_block"

## Valor técnico

* Mejora detección mediante YARA
* Incrementa complejidad del análisis

---

# 3.4 checkDebugger()

## Propósito

Detectar si el programa se está ejecutando bajo debugging.

## Entradas

Ninguna

## Salidas

TRUE → Debugger detectado
FALSE → No detectado

## API utilizada

IsDebuggerPresent()

## Pseudocódigo

Si IsDebuggerPresent() == TRUE
 Retornar TRUE

Retornar FALSE

---

# 3.5 requestPassword()

## Propósito

Solicitar una contraseña al usuario.

## Entradas

Ninguna

## Salidas

Cadena ingresada por el usuario.

## Pseudocódigo

Mostrar:

"Enter password:"

Leer entrada del usuario

Retornar cadena ingresada

---

# 3.6 validatePassword(password)

## Propósito

Validar la contraseña ingresada utilizando una cadena codificada.

## Entradas

password (string)

## Salidas

TRUE → Contraseña correcta
FALSE → Contraseña incorrecta

## Lógica

La contraseña real se encuentra codificada y es decodificada mediante:

decodeHiddenString()

## Pseudocódigo

decoded_password = decodeHiddenString(encoded_password)

Si password == decoded_password
 Retornar TRUE

Retornar FALSE

---

# 3.7 decodeHiddenString()

## Propósito

Decodificar una cadena almacenada en forma codificada.

## Entradas

Cadena codificada.

## Salidas

Cadena decodificada.

## Método sugerido

Desplazamiento simple de caracteres.

Ejemplo conceptual:

Encoded → QAttx1se234
Decoded → forensic123

## Pseudocódigo

Recorrer cadena codificada

Aplicar operación de decodificación

Retornar cadena decodificada

---

# 3.8 simulateMemoryAllocation()

## Propósito

Simular asignación de memoria ejecutable para observación en debugging.

## Entradas

Ninguna

## Salidas

Mensaje indicando asignación exitosa.

## API utilizada

VirtualAlloc()

## Tamaño de memoria

1024 bytes (tamaño fijo)

## Comportamiento

Asignar memoria con permisos:

PAGE_EXECUTE_READWRITE

Mostrar mensaje:

"RWX memory allocated successfully"

Liberar memoria posteriormente.

## Pseudocódigo

mem = VirtualAlloc(...)

Si mem != NULL
 Mostrar mensaje de asignación

VirtualFree(mem)

---

# 3.9 launchCalculator()

## Propósito

Ejecutar la calculadora de Windows.

## API utilizada

WinExec()

## Comportamiento

WinExec("calc.exe", SW_SHOW)

## Valor técnico

* Detectable por CAPA
* Observable dinámicamente

---

# 3.10 performDelay()

## Propósito

Introducir una pausa observable durante debugging.

## API utilizada

Sleep()

## Tiempo sugerido

1500 milisegundos

## Pseudocódigo

Sleep(1500)

---

# 3.11 createDummyFile()

## Propósito

Crear un archivo temporal para generar evidencia observable.

## APIs utilizadas

CreateFileA()
WriteFile()
CloseHandle()

## Ubicación

%TEMP%\dummy.txt

## Contenido

"Execution log created"
"System scan complete"

## Pseudocódigo

Obtener ruta TEMP

Crear archivo dummy.txt

Escribir contenido

Cerrar archivo

---

# 3.12 showFinalMessage()

## Propósito

Mostrar mensaje final indicando ejecución completa.

## API utilizada

MessageBoxA()

## Mensaje

"Execution Complete"

## Pseudocódigo

Mostrar MessageBox

---

# 4. Funciones Críticas para Análisis

Las siguientes funciones serán puntos clave durante el análisis:

* checkDebugger()
* validatePassword()
* decodeHiddenString()
* simulateMemoryAllocation()
* createDummyFile()

Estas funciones facilitan:

* Ingeniería inversa
* Debugging
* Análisis de memoria

---

# 5. Variables Importantes

Variables internas sugeridas:

```text
encoded_password
decoded_password
temp_file_path
memory_pointer
```

Estas variables pueden ser observadas durante debugging.

---

# 6. Orden Real de Ejecución

1 → printSuspiciousStrings()

2 → addDecoyStrings()

3 → checkDebugger()

Si debugger detectado:

Terminar ejecución

4 → requestPassword()

5 → validatePassword()

Si incorrecta:

Terminar ejecución

6 → simulateMemoryAllocation()

7 → launchCalculator()

8 → performDelay()

9 → createDummyFile()

10 → showFinalMessage()

---

# 7. Nivel de Complejidad

Complejidad objetivo:

Media a Media-Alta

Debe permitir:

* Análisis estático
* Debugging dinámico
* Observación en memoria
* Creación de reglas YARA
* Identificación con CAPA

Sin volverse:

* Demasiado trivial
* Excesivamente complejo

---

# 8. Configuración del Binario

Nombre del ejecutable:

team_payload.exe

Lenguaje:

C++

Compilador:

Visual Studio

Plataforma:

Windows 10 x64

Tipo:

Console Application

---

# 9. Notas de Implementación

Este documento define la lógica funcional del binario antes de su implementación final.

Cualquier modificación funcional deberá registrarse en:

docs/development_guides/versions.md
