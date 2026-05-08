# Team Report — T4 Análisis y Detección de Técnicas Ofensivas

## Información General

**Proyecto:** team_payload.exe  
**Lenguaje:** C++  
**Plataforma objetivo:** Windows x64  
**Compilador:** MSVC (Visual Studio)  
**Modo de compilación final:** Release x64

---

## Objetivo del Proyecto

El objetivo de esta práctica fue desarrollar y analizar un binario educativo capaz de simular comportamientos comúnmente asociados a malware moderno, utilizando herramientas de análisis estático, dinámico y detección.

El proyecto fue diseñado específicamente para estudiar técnicas relacionadas con evasión de análisis, ejecución de procesos, manipulación de memoria y generación de indicadores detectables mediante herramientas defensivas.

Todas las funcionalidades implementadas fueron desarrolladas con fines exclusivamente académicos y controlados.

---

## Desarrollo del Binario

El ejecutable `team_payload.exe` fue desarrollado modularmente en C++, separando cada comportamiento en componentes independientes para facilitar su análisis posterior.

### Funcionalidades Implementadas

- Validación de contraseña mediante string decodificada en tiempo de ejecución
- Detección básica de debugging mediante `IsDebuggerPresent`
- Ejecución de procesos usando `WinExec`
- Delay programado utilizando `Sleep`
- Creación de archivos temporales en disco
- Reserva dinámica de memoria RWX mediante `VirtualAlloc`
- Uso de strings sospechosas para simulación de indicadores de compromiso

El flujo principal del binario requiere validación correcta de contraseña antes de ejecutar las funciones principales del programa.

---

## Análisis Estático

El análisis estático fue realizado principalmente utilizando Ghidra.

Durante el reversing se identificaron correctamente:

- Imports relevantes del sistema
- Flujo principal de ejecución
- Funciones relacionadas con evasión y memoria dinámica
- Strings sospechosas embebidas en el binario
- Uso de APIs críticas como `VirtualAlloc`, `IsDebuggerPresent` y `WinExec`

El análisis permitió mapear el comportamiento general del binario sin necesidad de ejecutar código potencialmente riesgoso.

---

## Análisis Dinámico y de Memoria

El análisis dinámico fue realizado con x64dbg.

Se verificó correctamente:

- Ejecución del Entry Point
- Activación de `IsDebuggerPresent`
- Reserva de memoria dinámica mediante `VirtualAlloc`
- Uso de permisos RWX (`PAGE_EXECUTE_READWRITE`)
- Flujo controlado posterior a validación de contraseña

También se revisó el mapa de memoria del proceso y las DLLs cargadas durante la ejecución.

No se observaron comportamientos destructivos ni persistencia real en el sistema.

---

## Detección y Clasificación

El proyecto incluyó generación de reglas YARA y análisis mediante CAPA.

### YARA

La regla desarrollada detecta múltiples indicadores presentes en el binario:

- Strings sospechosas
- APIs relevantes
- Uso de memoria RWX
- Indicadores relacionados con debugging y ejecución de procesos

### CAPA

CAPA identificó capacidades relacionadas con:

- Anti-debugging
- Reserva dinámica de memoria
- Escritura de archivos
- Creación de procesos
- Indicadores anti-VM

Además, el binario fue asociado a técnicas del framework MITRE ATT&CK y Malware Behavior Catalog (MBC).

---

## Consideraciones de Seguridad

El binario fue desarrollado exclusivamente con fines educativos y de análisis defensivo.

Aunque replica patrones observados frecuentemente en malware real, el ejecutable no contiene payloads maliciosos, persistencia, comunicación de red ni técnicas reales de inyección de código.

Todas las simulaciones fueron implementadas de forma controlada para permitir su análisis seguro dentro de entornos de laboratorio.

---

## Distribución de Trabajo

| Integrante | Responsabilidad |
|---|---|
| Josué Castro | Desarrollo principal del binario y coordinación técnica |
| Marco | Análisis estático con Ghidra |
| Ricardo | Análisis dinámico y de memoria con x64dbg |
| Sergio Pedro Sepúlveda Rodríguez | Reglas YARA y análisis CAPA |

---

## Conclusión

La práctica permitió integrar múltiples áreas del análisis de malware moderno en un entorno controlado, incluyendo reversing, debugging, detección y clasificación de comportamiento sospechoso.

La combinación de análisis estático, dinámico y herramientas defensivas permitió comprender cómo ciertos patrones utilizados por malware pueden ser identificados y documentados mediante técnicas de ciberseguridad defensiva.