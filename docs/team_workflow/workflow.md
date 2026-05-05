# Workflow del Proyecto — T4

Proyecto: **T4_Analisis_Deteccion_de_Binarios**

---

# 1. Objetivo del Workflow

Definir un flujo de trabajo claro que permita:

* Mantener organización del repositorio
* Evitar conflictos entre integrantes
* Garantizar integración correcta de avances
* Mantener trazabilidad del trabajo
* Facilitar revisión del progreso

Este flujo asegura que todos los cambios realizados puedan integrarse correctamente sin afectar la estabilidad del proyecto.

---

# 2. Ramas del Repositorio

Cada integrante trabajará en su propia rama basada en la rama principal.

No se permite trabajar directamente en **main**.

Formato sugerido:

```text
feature/development-nombre  
feature/ghidra-nombre  
feature/debug-nombre  
feature/detection-nombre  
```

Ejemplo:

```text
feature/development-josue  
feature/ghidra-marco  
feature/debug-ricardo  
feature/detection-sergio  
```

---

# 3. Flujo de Trabajo con Git

El flujo recomendado será:

1. Crear nueva rama desde **main**
2. Realizar cambios en la rama local
3. Guardar avances mediante commits descriptivos
4. Subir cambios al repositorio remoto
5. Crear Pull Request
6. Revisar cambios antes de hacer merge

---

# 4. Pull Requests

Todo cambio debe realizarse mediante **Pull Request**.

No se permite:

* Hacer push directo a **main**
* Subir archivos sin revisión previa

Cada Pull Request debe incluir:

* Descripción clara del cambio
* Archivos modificados
* Breve explicación del objetivo

Esto permite mantener control sobre la integración.

---

# 5. Responsabilidades por Área

Cada integrante tendrá responsabilidades específicas dentro del proyecto.

---

## Desarrollo del Binario

Responsable:

**Josue Castro**

Actividades:

* Desarrollo del código principal
* Integración de nuevas funciones
* Compilación del ejecutable
* Generación de versiones del binario
* Validación del flujo general

Archivos relacionados:

```text
src/team_payload/
bin/
docs/development_guides/
```

---

## Analisis Estatico e Ingeniería Inversa (Ghidra)

Responsable:

**Marco Vargas**

Actividades:

* Análisis del ejecutable en Ghidra
* Identificación de funciones
* Documentación de imports
* Análisis de secciones PE
* Generación de capturas

Archivos relacionados:

```text
deliverables/ghidra_notes.md
screenshots/ghidra/
```

---

## Debugging y Análisis Dinámico

Responsable:

**Ricardo Estrada**

Actividades:

* Ejecución del binario en debugger
* Colocación de breakpoints
* Observación de memoria
* Identificación de regiones RWX
* Captura de evidencia visual

Archivos relacionados:

```text
deliverables/dynamic_memory_analysis.md
screenshots/dynamic/
```

---

## Detección (YARA / CAPA)

Responsable:

**Sergio Sepulveda**

Actividades:

* Ejecución de FLARE CAPA
* Generación de reporte CAPA
* Creación de regla YARA
* Validación de detección

Archivos relacionados:

```text
deliverables/capa_report.txt
detection/yara/team_rule.yar
deliverables/detection_summary.md
screenshots/yara/
```

---

# 6. Convención de Nombres de Archivos

Todos los archivos deben tener nombres descriptivos.

Ejemplo correcto:

```text
ghidra_main_function.png  
debug_breakpoint_virtualalloc.png  
yara_detection_result.png  
```

Ejemplo incorrecto:

```text
image1.png  
captura.png  
test.png  
```

---

# 7. Capturas Requeridas

Toda herramienta utilizada debe documentarse con capturas.

Las capturas deberán almacenarse en:

```text
screenshots/
```

Organización sugerida:

```text
screenshots/

├── static_analysis/
├── dynamic/
└── yara/
```

---

# 8. Versionado del Binario

El binario se generará en versiones progresivas.

Ubicación:

```text
bin/

├── dev/
│   ├── team_payload_v1.exe
│   └── team_payload_v2.exe
│
└── final/
    └── team_payload.exe
```

Cada versión debe:

* Compilar correctamente
* Ejecutarse sin errores
* Mantener comportamiento esperado

---

# 9. Validación de Cambios

Antes de integrar cualquier cambio:

Se debe verificar:

* Compilación correcta
* Funcionamiento esperado
* Ausencia de errores críticos
* Integración sin conflictos

Esto evita problemas durante la fase final.

---

# 10. Documentación Continua

La documentación debe actualizarse progresivamente.

No se recomienda:

* Dejar documentación para el final
* Subir información incompleta
* Ignorar evidencia visual

Se recomienda:

Actualizar documentos después de cada avance significativo.

---

# 11. Control de Calidad

Antes de la entrega final:

Se deberá verificar:

* Existencia de todos los archivos requeridos
* Capturas organizadas correctamente
* Binario funcional
* Documentación completa
* Reglas YARA funcionales
* Reporte CAPA generado

---

# 12. Notas Finales

Este workflow establece un proceso estructurado que permite:

* Mantener estabilidad del proyecto
* Facilitar la integración del equipo
* Reducir errores organizativos
* Mejorar la calidad del resultado final

Todos los integrantes deben seguir este flujo para garantizar consistencia en el desarrollo.
