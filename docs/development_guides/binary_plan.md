# Binario Principal — Plan de Diseño

Proyecto: **T4_Analisis_Deteccion_de_Binarios**

---

# 1. Objetivo del Binario

El objetivo del binario principal es desarrollar un ejecutable educativo que simule técnicas ofensivas comunes en malware, pero de manera completamente **segura y controlada**, con el propósito de facilitar actividades de:

* Análisis estático e Ingeniería inversa (Ghidra)
* Debugging dinámico (x64dbg)
* Análisis de memoria
* Detección mediante YARA
* Identificación de capacidades mediante CAPA

El binario será desarrollado en **C++ utilizando Visual Studio**, compilado para **Windows 10 x64**, e incluirá múltiples comportamientos diseñados específicamente para análisis técnico.

El ejecutable generado será:

**team_payload.exe**

Este binario es completamente **benigno**, diseñado únicamente con fines educativos.

---

# 2. Filosofía de Diseño

El binario debe:

* Simular comportamientos típicos observables en malware
* Mantener un entorno completamente seguro
* Permitir análisis técnico detallado
* Generar artefactos detectables
* Facilitar observación en memoria

Se prioriza:

* Claridad estructural
* Modularidad del código
* Observabilidad en herramientas de análisis
* Compatibilidad con herramientas forenses

---

# 3. Técnicas Ofensivas Simuladas

El binario implementará múltiples técnicas controladas diseñadas para análisis técnico.

---

# 3.1 Impresión de Strings Sospechosas

## Objetivo

Simular comportamiento observable durante análisis estático.

## Comportamiento

El binario mostrará múltiples mensajes sospechosos en consola.

## Ejemplos de Strings

"MAGIC: edu-malware-sim"
"Initializing system components..."
"Loading encrypted payload..."
"System ready."

## Valor técnico

* Detectables mediante YARA
* Visibles en análisis estático
* Útiles en ingeniería inversa

---

# 3.2 Detección de Debugger

## Objetivo

Simular comportamiento anti-análisis básico.

## API utilizada

IsDebuggerPresent()

## Comportamiento

Si se detecta un debugger:

Mostrar mensaje:

"Debugger detected"

Finalizar ejecución.

## Valor técnico

* Permite observar comportamiento condicional
* Detectable mediante análisis dinámico

---

# 3.3 Verificación de Contraseña

## Objetivo

Crear flujo condicional observable y controlado.

## Comportamiento

El programa solicitará una contraseña al usuario.

Ejemplo:

Enter password:

La contraseña interna será almacenada en forma codificada y decodificada en tiempo de ejecución.

Si la contraseña es correcta:

"Access Granted"

Si es incorrecta:

"Access Denied"

El programa finalizará.

## Valor técnico

* Permite observar lógica condicional
* Facilita análisis de memoria
* Útil para ingeniería inversa

---

# 3.4 Decodificación de String en Tiempo de Ejecución

## Objetivo

Simular ocultamiento básico de información.

## Comportamiento

El binario contendrá una cadena codificada que será decodificada en tiempo de ejecución.

Ejemplo conceptual:

Encoded → cadena alterada
Decoded → contraseña válida

## Valor técnico

* Observable en debugging
* Detectable en memoria
* Relevante para análisis dinámico

---

# 3.5 Simulación de Asignación de Memoria Ejecutable (RWX)

## Objetivo

Simular comportamiento común en técnicas de inyección en memoria.

## API utilizada

VirtualAlloc()

## Comportamiento

Después de validar correctamente la contraseña, el binario realizará:

* Asignación de memoria utilizando permisos:

PAGE_EXECUTE_READWRITE

* Mostrar mensaje indicando:

"RWX memory allocated successfully"

* Liberar memoria posteriormente.

## Tamaño de memoria

1024 bytes (tamaño fijo)

## Valor técnico

* Permite observar regiones RWX en memoria
* Detectable por CAPA
* Analizable en debugging
* Simula comportamiento típico en malware

---

# 3.6 Ejecución de Proceso Externo

## Objetivo

Simular ejecución de procesos secundarios.

## API utilizada

WinExec()

## Comportamiento

Ejecutar:

WinExec("calc.exe", SW_SHOW)

## Valor técnico

* Detectable por CAPA
* Observable en análisis dinámico

---

# 3.7 Delay Programado

## Objetivo

Permitir observación durante debugging.

## API utilizada

Sleep()

## Tiempo sugerido

1500 ms

## Comportamiento

Sleep(1500)

## Valor técnico

* Facilita colocación de breakpoints
* Observable en análisis dinámico

---

# 3.8 Creación de Archivo Temporal

## Objetivo

Generar evidencia observable en el sistema.

## APIs utilizadas

CreateFileA()
WriteFile()
CloseHandle()

## Ruta esperada

%TEMP%\dummy.txt

## Contenido esperado

"Execution log created"
"System scan complete"

## Valor técnico

* Genera evidencia física observable
* Detectable en análisis forense

---

# 3.9 Mensaje Final

## Objetivo

Confirmar ejecución completa.

## API utilizada

MessageBoxA()

## Mensaje esperado

"Execution Complete"

## Valor técnico

* Confirma finalización del flujo
* Observable en debugging

---

# 4. Flujo General del Programa

Inicio
↓
printSuspiciousStrings()
↓
addDecoyStrings()
↓
checkDebugger()
↓
requestPassword()
↓
validatePassword()

Si incorrecta → Terminar

↓
simulateMemoryAllocation()
↓
launchCalculator()
↓
performDelay()
↓
createDummyFile()
↓
showFinalMessage()
↓
Fin

---

# 5. Estructura General de Funciones

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

---

# 6. APIs de Windows Utilizadas

Las siguientes APIs serán utilizadas:

WinExec
Sleep
CreateFileA
WriteFile
CloseHandle
MessageBoxA
IsDebuggerPresent
VirtualAlloc
VirtualFree

---

# 7. Elementos Diseñados para Análisis Dinámico

El binario incluirá:

* Comparaciones condicionales
* Delay identificable
* Asignación de memoria ejecutable
* Ejecución de procesos
* Escritura en archivo

Estos comportamientos facilitarán:

* Debugging
* Observación en memoria
* Análisis con herramientas dinámicas

---

# 8. Elementos Diseñados para YARA

Se incluirán:

* Strings únicas
* Strings sospechosas
* Rutas específicas
* Mensajes distintivos

Ejemplos:

"Access Granted"
"Debugger detected"
"Execution Complete"
"RWX memory allocated successfully"

---

# 9. Elementos Diseñados para CAPA

Se esperan detecciones relacionadas con:

* Process execution
* File writing
* Delay execution
* Anti-debugging
* Memory allocation

---

# 10. Complejidad Objetivo

Nivel esperado:

Media – Media Alta

Debe ser:

* Analizable en Ghidra
* Debuggable en x64dbg
* Detectable mediante YARA
* Compatible con CAPA

Sin ser:

* Demasiado trivial
* Excesivamente complejo

---

# 11. Configuración del Binario

Nombre del ejecutable:

team_payload.exe

Configuración:

Platform: Windows x64
Compiler: Visual Studio
Language: C++
Application Type: Console Application

---

# 12. Entorno de Desarrollo

Sistema operativo:

Windows 10 x64 (Virtual Machine)

Compilador:

Visual Studio (C++)

Arquitectura:

Modular

---

# 13. Cumplimiento de Requisitos de T4

El binario cumple explícitamente con los requisitos del reto:

✔ Descifrado de cadenas en tiempo de ejecución
✔ Uso de APIs sensibles
✔ Creación de archivo temporal
✔ Simulación de memoria ejecutable
✔ Delay programado
✔ Comportamiento detectable

El ejecutable final será:

team_payload.exe

Este binario es:

✔ Benigno
✔ Educativo
✔ Diseñado para análisis defensivo
✔ Seguro para ejecución controlada

---

# 14. Notas Finales

Este documento define el comportamiento esperado del binario antes de su implementación final.

El desarrollo seguirá una arquitectura modular diseñada para facilitar:

* mantenimiento del código
* análisis técnico
* documentación del comportamiento

Cualquier modificación funcional deberá registrarse en:

docs/development_guides/versions.md
