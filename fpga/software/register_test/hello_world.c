/*
 * "Hello World" example.
 *
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example
 * designs. It runs with or without the MicroC/OS-II RTOS and requires a STDOUT
 * device in your system's hardware.
 * The memory footprint of this hosted application is ~69 kbytes by default
 * using the standard reference design.
 *
 * For a reduced footprint version of this template, and an explanation of how
 * to reduce the memory footprint for a given application, see the
 * "small_hello_world" template.
 *
 */

#include <stdio.h>
#include <system.h>
#include <io.h>

#define REGFILE_0_BASE 0x0

int main()
{
	  printf("Hello from Nios II!\n");

	  int REG_ADDR;
	  int *readData;

	  // Read address 0
	  REG_ADDR = 0;

	  readData =  IORD_32DIRECT(REGFILE_0_BASE, REG_ADDR);

	  REG_ADDR = 2;
	  IOWR_32DIRECT(REGFILE_0_BASE, REG_ADDR, 0xDEADBEEF+1);
//	  printf("DONE READING\n");

	  return 0;
}