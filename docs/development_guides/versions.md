# Binary Versions Strategy — team_payload.exe

Proyecto: **T4_Analisis_Deteccion_de_Binarios**

---

# 1. Objetivo

Definir la estrategia de versiones del binario durante el desarrollo del proyecto.

Las versiones intermedias se utilizarán para validar el funcionamiento progresivo del binario antes de generar la versión final utilizada para análisis técnico.

Cada versión representa un estado funcional específico del sistema.

---

# 2. Estrategia General de Versionado

Durante el desarrollo se generarán versiones progresivas del binario para:

* Validar estabilidad del programa
* Verificar comportamiento esperado
* Facilitar debugging
* Permitir control de cambios
* Mantener una base funcional estable

Se utilizarán **tres versiones principales**.

---

# 3. Versiones de Desarrollo

Estas versiones serán utilizadas internamente para validación progresiva.

---

## Version 1 — Base Funcional

Nombre:

team_payload_v1.exe

Ubicación:

bin/dev/

Funciones incluidas:

* printSuspiciousStrings()
* addDecoyStrings()
* launchCalculator()
* performDelay()
* createDummyFile()
* showFinalMessage()

Objetivo:

Validar el funcionamiento básico del binario y confirmar la ejecución correcta del flujo principal sin lógica condicional avanzada.

Esta versión permite:

* Verificar compilación correcta
* Confirmar ejecución básica
* Validar comportamiento observable

---

## Version 2 — Integración de Técnicas Avanzadas

Nombre:

team_payload_v2.exe

Ubicación:

bin/dev/

Funciones añadidas:

* checkDebugger()
* requestPassword()
* validatePassword()
* decodeHiddenString()
* simulateMemoryAllocation()

Objetivo:

Integrar las técnicas principales requeridas para el análisis técnico del binario.

Esta versión permite:

* Verificar lógica condicional
* Validar decodificación en tiempo de ejecución
* Confirmar asignación de memoria RWX
* Preparar el binario para análisis dinámico

Esta versión representa el **estado funcional completo previo a validación final**.

---

# 4. Versión Final Oficial

Nombre:

team_payload.exe

Ubicación:

bin/final/

Esta versión incluirá:

* Todas las funciones implementadas
* Todas las técnicas simuladas
* Ajustes finales de estabilidad
* Configuración en modo Release

Será utilizada para:

* Análisis estático
* Ingeniería inversa
* Debugging dinámico
* Análisis de memoria
* Generación de reglas YARA
* Identificación mediante CAPA

Esta versión será la utilizada en la entrega final del proyecto.

---

# 5. Política de Congelamiento (Freeze Policy)

Una vez generada la versión final:

team_payload.exe

No se permitirán modificaciones adicionales al código fuente.

Todos los análisis y capturas deberán realizarse utilizando esta versión final.

Esto garantiza:

* Consistencia en los resultados
* Reproducibilidad del análisis
* Estabilidad del entorno

---

# 6. Control de Versiones

Cada versión del binario deberá:

* Ser compilada correctamente
* Ser verificada antes de su almacenamiento
* Mantener consistencia funcional

Los binarios se almacenarán en:

```text
bin/

├── dev/
│   ├── team_payload_v1.exe
│   └── team_payload_v2.exe
│
└── final/
    └── team_payload.exe
```

---

# 7. Responsabilidad de Generación

La generación del binario será realizada por el responsable técnico del desarrollo.

Cada nueva versión será creada únicamente después de:

* Confirmar funcionamiento correcto
* Verificar ejecución esperada
* Validar estabilidad del sistema

Esto permite mantener un control claro del desarrollo.

---

# 8. Notas Finales

Este esquema de versiones permite mantener un proceso ordenado y controlado durante el desarrollo del binario.

El uso de versiones progresivas facilita:

* Identificación de errores
* Control del comportamiento
* Validación técnica
* Documentación estructurada

Todas las modificaciones relevantes deberán registrarse también en:

docs/development_guides/functions_design.md
