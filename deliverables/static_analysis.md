# Análisis de Ingeniería Inversa — `team_payload.exe`
**Herramienta:** Ghidra
**Fecha de análisis:** 2026

---

## 1. Análisis Estático Inicial

En esta fase se examinó la estructura básica del ejecutable para identificar sus componentes principales antes de proceder con el análisis del flujo de control.

**Mapa de Memoria** *(ver `ghidra_memory_map.png`)*  
Se identificaron las secciones estándar del PE de 64 bits con imagen base en `0x140000000`. La sección `.text` (0x2800 bytes, R/X) contiene el código ejecutable, `.rdata` (0x2400 bytes, R) almacena las cadenas de texto e imports, y `.data` (0x228 bytes, R/W) contiene las variables globales inicializadas. Se observó adicionalmente una sección `tdb` marcada como *Volatile* y *Artificial*, generada por Ghidra durante el análisis, con un tamaño de 0x1850 bytes.

**Importaciones Críticas** *(ver `ghidra_symbol_tree_imports.png`)*  
Se analizaron las dependencias del binario, el cual importa funciones de `KERNEL32.DLL`, `MSVCP140.DLL`, `VCRUNTIME140.DLL` y varias DLLs del CRT de Windows. Dentro de `KERNEL32.DLL` se identificaron capacidades de alto interés: `VirtualAlloc` y `VirtualFree` para gestión de memoria ejecutable, `WinExec` para ejecución de procesos arbitrarios, `WriteFile` y `CreateFileA` para operaciones sobre el sistema de archivos, e `IsDebuggerPresent` como técnica de evasión ante análisis dinámico. La presencia combinada de estas funciones define un perfil de comportamiento consistente con un payload de ejecución modular.

**Extracción de Cadenas** *(ver `ghidra_defined_strings.png`)*  
Se localizaron 145 cadenas definidas en la sección `.rdata`. Entre las más relevantes se encuentran: `"Debugger detected!"`, `"disable_firewall"`, `"connect_to_server"`, `"upload_data"`, `"admin_login=true"`, `"Loading encrypted payl..."`, `"Simulating RWX memo..."` y `"calc.exe"`. La cadena `"MAGIC: edu-malware-sim"` actúa como firma interna del binario, confirmando su naturaleza como simulador educativo de técnicas de malware. También se identificaron strings de autenticación simulada: `"Enter password:"`, `"Access granted!"` y `"Access Denied"`.

---

## 2. Análisis del Flujo de Control (Grafo de Funciones)

Para comprender la lógica de decisión del programa se generó el grafo de función de `main_payload`, que presenta un total de **29 vértices**, reflejando una estructura de control compleja con múltiples bifurcaciones y bucles.

**Estructura del Grafo**

Dada la complejidad de la función, el flujo fue examinado en secciones:

**Bloque de entrada e inicialización** *(ver `ghidra_function_graph_part1.png`)*  
El bloque superior, iniciando en `0x140001db0`, contiene la lógica de inicialización del stack frame, la carga de cadenas de configuración (`s_connect_to_server`, `s_disable_firewall`, `s_admin_login`, `s_upload_data`) hacia buffers locales mediante instrucciones MOVSD/XORPS, y las primeras llamadas a funciones auxiliares. Este bloque establece el estado inicial del payload antes de entrar al flujo de decisión principal.

**Nodos intermedios y bifurcaciones** *(ver `ghidra_function_graph_part2.png`)*  
Los nodos intermedios presentan bucles de iteración sobre buffers STL con contadores en RDX y comparaciones contra `0xf` y `0x1000`, controlados por saltos condicionales (`JBE`, `JC`, `JA`). Se identifican llamadas a `MSVCP140.DLL` mediante punteros de función en tabla, evidenciando el uso de `std::string` u otras colecciones del STL de C++. En esta sección también aparecen las bifurcaciones que corresponden a las estructuras condicionales detectadas en el código descompilado.

**Bloques de error y fast-fail** *(ver `ghidra_function_graph_final1.png`)*  
Se identificaron bloques de manejo de errores que culminan en la instrucción `INT 0x29`, correspondiente a `__fastfail` en Windows x64. Esta instrucción provoca la terminación inmediata y controlada del proceso ante condiciones de corrupción de memoria o errores en runtime, sin posibilidad de interceptación por manejadores de excepciones del usuario.

**Bloques de salida y retorno** *(ver `ghidra_function_graph_final2.png`)*  
El bloque de salida principal, localizado en `0x1400020a3`, contiene la llamada a `__security_check_cookie` para verificar la integridad del stack antes del retorno, seguida de la instrucción `RET`. Este mecanismo confirma que el binario fue compilado con protecciones de stack activas.

---

## 3. Descompilación y Lógica Interna

El análisis del código descompilado permitió reconstruir la lógica de ejecución del payload y entender las condiciones que gobiernan su comportamiento. *(ver `ghidra_main_payload_overview.png`)*

**Identificación de la función principal**  
La función originalmente denominada `FUN_140001db0` fue renombrada a `main_payload` tras confirmar que concentra la lógica central de ejecución. Su firma es `void __fastcall main_payload(void)`, con un stack frame que declara múltiples variables locales, incluyendo cuatro buffers de 16 bytes destinados a almacenar objetos STL o arreglos de configuración.

**Lógica de condiciones observada**  
El decompilado revela estructuras condicionales anidadas que evalúan el tamaño de los buffers para determinar si se utiliza almacenamiento local o uno asignado dinámicamente en heap, patrón característico de la Small String Optimization (SSO) de `std::string` en MSVC. Las llamadas a `swi(0x29)` aparecen en las ramas de error de estas condiciones, actuando como mecanismo de terminación segura ante fallos de asignación.

**Secuencia de ejecución del payload**  
La función ejecuta las simulaciones en orden secuencial: inicialización de log, creación de archivo señuelo, simulación de asignación de memoria RWX, conexión remota simulada, escaneo del sistema, carga de payload cifrado, ejecución de `calc.exe` vía `WinExec`, y finalización con el mensaje `"Execution Complete"`. Cada paso queda registrado en el log de ejecución del propio binario.

---

## 4. Conclusiones

El análisis estático de `team_payload.exe` mediante Ghidra revela un binario PE64 compilado en C++ moderno que implementa, de forma simulada y controlada, un conjunto de técnicas representativas del ciclo de vida de un payload real.

Desde una perspectiva técnica, el ejecutable demuestra un perfil de comportamiento que abarca cuatro categorías: **evasión de análisis dinámico** mediante `IsDebuggerPresent` con respuesta activa al detectar depurador; **ejecución de código arbitrario** simulada a través de `VirtualAlloc` con permisos RWX seguida de `WinExec`; **interacción con el sistema de archivos** mediante `CreateFileA` y `WriteFile` para la creación de artefactos señuelo; e **integridad de ejecución** garantizada por `__security_check_cookie` y `__fastfail` (`INT 0x29`), indicando una compilación con mitigaciones de seguridad activas (`/GS`).

La estructura modular de `main_payload`, con su grafo de 29 vértices, el uso de STL para gestión de configuración interna y la firma `MAGIC: edu-malware-sim`, evidencia un diseño deliberadamente pedagógico orientado a ilustrar técnicas de análisis, detección y evasión en entornos de ciberseguridad ofensiva y defensiva. El binario no representa una amenaza real, pero constituye un caso de estudio válido para la comprensión de patrones de comportamiento malicioso a nivel de código máquina.

---

*Análisis realizado con Ghidra sobre `team_payload.exe` — Ingeniería Inversa Estática*
