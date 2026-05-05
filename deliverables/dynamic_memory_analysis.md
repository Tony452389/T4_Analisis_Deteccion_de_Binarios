# Análisis Dinámico y de Memoria — team_payload.exe

**Herramienta:** x64dbg  
**Fecha:** 05 de mayo de 2026  

---

## Entry Point

Al abrir el binario en x64dbg, la ejecución se pausó automáticamente en el punto de entrada del programa.

- **RIP:** `00007FF71B232BB8`
- El registro apunta a `team_payload.OptionalHeader.AddressOfEntryPoint`

![Entry Point](../screenshots/dynamic/00_entry_point_registers.png)

---

## Breakpoints Analizados

### IsDebuggerPresent
El binario llama a esta función para detectar si está siendo analizado. Es una técnica de anti-debugging.

- Breakpoint activado correctamente en `kernel32.dll`
- Dirección: `00007FFC7123D9B0`

![IsDebuggerPresent](../screenshots/dynamic/01_breakpoint_IsDebuggerPresent.png)

---

### VirtualAlloc
El binario reserva memoria dinámica. En malware real esta función se usa para ejecutar código malicioso en memoria.

- Breakpoint activado correctamente en `kernel32.dll`
- Dirección: `00007FFC71233CA0`

![VirtualAlloc](../screenshots/dynamic/03_breakpoint_VirtualAlloc.png)

---

## Memory Map

Se revisó el mapa de memoria del proceso durante la ejecución.

| Sección | Protección | Descripción |
|---|---|---|
| `.text` | ER---- | Código ejecutable |
| `.rdata` | -R---- | Strings y datos de solo lectura |
| `.data` | -RW--- | Variables del programa |
| `.reloc` | -R---- | Tabla de reubicación |

![Memory Map](../screenshots/dynamic/05_memory_map_binario.png)

---

## Conclusión

Se confirmaron dos técnicas simuladas en el binario:

1. **Anti-debugging** — usa `IsDebuggerPresent` para detectar análisis
2. **Memoria dinámica** — usa `VirtualAlloc` para reservar memoria en tiempo de ejecución

Ambos son simulaciones seguras pero representan patrones reales de malware detectables por herramientas defensivas.
