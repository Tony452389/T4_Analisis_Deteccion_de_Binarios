#pragma once 

//----------------------------------------------------------------------------------------- V2 --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

//Función que simula la asignación de memoria
//Nota: Esta función utiliza la API de Windows para asignar memoria con permisos de lectura, escritura y ejecución (RWX). Se utiliza la función VirtualAlloc para reservar y comprometer un bloque de memoria. Después de la simulación, la memoria asignada se libera utilizando VirtualFree. Esta función es útil para demostrar cómo se puede asignar memoria en un entorno controlado y no debe utilizarse para fines maliciosos.
void simulateMemoryAllocation();

