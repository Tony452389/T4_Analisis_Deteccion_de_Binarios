#include <windows.h>
#include <iostream>

#include "memory_sim.h"

void simulateMemoryAllocation() {
	std::cout << "\nSimulating RWX memory allocation..." << std::endl;

	SIZE_T size = 1024; // Tamaño de la memoria a asignar

	LPVOID memory = VirtualAlloc(
		NULL,
		size,
		MEM_COMMIT | MEM_RESERVE,
		PAGE_EXECUTE_READWRITE
	);

	if (memory == NULL) {
		std::cout << "VirtualAlloc failed" << std::endl;
		return;
	}

	std::cout << "RWX memory allocated successfully" << std::endl;

	//Liberar la memoria asignada
	VirtualFree(memory, 0, MEM_RELEASE);

	std::cout << "Memory released" << std::endl;
}