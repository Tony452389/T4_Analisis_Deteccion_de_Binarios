# T4 – Análisis y Detección de Técnicas Ofensivas en un Binario

## Descripción General

Este repositorio contiene el desarrollo completo de la **Tarea 4 – Análisis y Detección de Técnicas Ofensivas en un Binario**, cuyo objetivo es diseñar, analizar y detectar comportamientos simulados típicamente asociados a software sospechoso, dentro de un entorno completamente seguro.

El proyecto incluye:

* Desarrollo de un **binario educativo en C++**
* Implementación de técnicas ofensivas simuladas
* Análisis estático del ejecutable
* Ingeniería inversa mediante Ghidra
* Análisis dinámico y de memoria
* Identificación de capacidades mediante **FLARE CAPA**
* Creación de reglas **YARA**
* Documentación técnica completa del proceso

Este repositorio está organizado para facilitar la revisión técnica y académica del trabajo realizado.

---

## ⚠️ Aviso Importante

Este repositorio contiene un **binario educativo diseñado únicamente con fines académicos**.

El ejecutable:

* **NO es malware real**
* **NO contiene código malicioso**
* **NO ejecuta shellcode**
* **NO realiza conexiones externas**
* **NO modifica configuraciones críticas del sistema**

El programa simula comportamientos típicos utilizados en análisis de seguridad informática.

Se recomienda ejecutar el binario únicamente en:

* Máquinas virtuales
* Entornos controlados
* Laboratorios educativos

---

## Objetivo del Proyecto

El objetivo principal del proyecto fue desarrollar un binario educativo que permitiera aplicar técnicas defensivas para:

* Analizar el comportamiento interno de un ejecutable
* Identificar funciones relevantes en memoria
* Detectar comportamiento sospechoso
* Observar asignación de memoria ejecutable
* Generar artefactos detectables
* Crear reglas YARA funcionales
* Identificar capacidades mediante CAPA

---

## Características del Binario

Archivo principal:

```text
bin/final/team_payload.exe
```

Características técnicas:

* Formato: Portable Executable (PE)
* Arquitectura: x64
* Lenguaje: C++
* Plataforma objetivo: Windows
* Tipo: Simulación educativa

---

## Técnicas Simuladas

El binario implementa múltiples comportamientos diseñados para análisis técnico.

Entre ellos:

* Impresión de strings sospechosas
* Detección de debugger
* Verificación de contraseña
* Descifrado de cadenas en tiempo de ejecución
* Simulación de asignación de memoria RWX
* Ejecución de procesos externos
* Delay programado
* Creación de archivo temporal
* Mensaje final de ejecución
* Uso de VirtualAlloc con permisos PAGE_EXECUTE_READWRITE (RWX)

Estas técnicas permiten observar patrones comunes utilizados en análisis de seguridad.

---

## Flujo General del Programa

El comportamiento del binario sigue el siguiente flujo:

```text
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
```

---

## Estructura del Repositorio

```text
T4_Analisis_Deteccion_de_Binarios/

├── bin/
│   ├── dev/
│   │   ├── team_payload_v1.exe
│   │   └── team_payload_v2.exe
│   │
│   └── final/
│       └── team_payload.exe
│
├── deliverables/
│   ├── static_analysis.md
│   ├── dynamic_memory_analysis.md
│   ├── network_behavior.md
│   ├── detection_summary.md
│   ├── capa_report.txt
│   └── team_report.md
│
├── docs/
│   ├── development_guides/
│   │   ├── binary_plan.md
│   │   ├── functions_design.md
│   │   └── versions.md
│   │
│   └── team_workflow/
│       └── workflow.md
│
├── detection/
│   └── yara/
│       └── team_rule.yar
│
├── screenshots/
│   ├── static_analysis/
│   ├── dynamic/
│   └── yara/
│
└── src/
    └── team_payload/
```

---

## Herramientas Utilizadas

Durante el desarrollo y análisis se utilizaron las siguientes herramientas:

### Desarrollo

* Visual Studio
* C++
* Windows API

### Análisis Estático (Ghidra)

* Ghidra
* Revision de imports y strings del ejecutable


### Análisis Dinámico

* x64dbg

### Análisis de Capacidades

* FLARE CAPA

### Detección

* YARA

---

## Flujo de Trabajo del Proyecto

El desarrollo del proyecto siguió un flujo estructurado:

1. Diseño del comportamiento del binario
2. Implementación modular en C++
3. Generación de versiones progresivas
4. Análisis estático e ingeniería inversa con Ghidra
5. Debugging dinámico
6. Análisis de memoria
7. Ejecución de CAPA
8. Creación de reglas YARA
9. Documentación final

---

## Resultados Esperados

Durante el análisis del binario se espera identificar:

* Uso de funciones del sistema operativo
* Asignación dinamica de memoria RWX
* Ejecución de procesos externos
* Creación de archivos temporales
* Strings identificables
* Patrones detectables mediante YARA
* Capacidades reconocidas por CAPA

---

## Entregables Principales

Los documentos principales del proyecto se encuentran en:

```text
deliverables/
```

Incluyen:

* static_analysis.md
  Resultados del análisis estático

* dynamic_memory_analysis.md
  Resultados del debugging y análisis de memoria

* network_behavior.md
  Análisis de comportamiento de red (si aplica)

* detection_summary.md
  Resumen de detección

* capa_report.txt
  Resultados generados por CAPA

* team_report.md
  Reporte técnico final

---

## Evidencias Visuales

Las capturas utilizadas como evidencia se encuentran en:

```text
screenshots/
```

Organizadas por:

* Static Analysis (Ghidra)
* Dynamic Analysis
* YARA

---

## Regla YARA

La regla desarrollada para detectar el binario se encuentra en:

```text
detection/yara/team_rule.yar
```

La regla utiliza strings sospechosas y APIs relevantes presentes en el ejecutable para identificar el binario.

---

## Limitaciones

Este proyecto fue desarrollado con fines educativos.

Limitaciones conocidas:

* No se realizan conexiones reales de red
* No se ejecuta código malicioso
* Las funcionalidades son simuladas
* El análisis depende del entorno controlado

---

## Autores

Equipo de trabajo:

| Integrante                           | Rol Principal                              |
| ------------------------------------ | ------------------------------------------ |
| **Josue Israel Castro Aguilar**      | Desarrollo del binario                     |
| **Marco Antonio Vargas Ruiz**        | Analisis Estatico (Ghidra)                 |
| **Ricardo Hervey Estrada Garcia**    | Debugging dinámico                         |
| **Sergio Pedro Sepulveda Rodriguez** | Detección (YARA / CAPA)                    |

---

## Licencia

Este proyecto fue desarrollado exclusivamente con fines académicos.

El contenido no debe utilizarse fuera de contextos educativos o de laboratorio.
