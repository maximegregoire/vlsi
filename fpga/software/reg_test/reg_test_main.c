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

int main(int i, char ** pp, char ** ppp)
{
	  int REG_ADDR;
	  volatile int readData;

	  // Read address 0
	  REG_ADDR = 0;
	  int counter = 0;
	  while (1)
	  {
	  readData = IORD_32DIRECT(REGFILE_0_BASE, REG_ADDR);
	  IOWR_32DIRECT(REGFILE_0_BASE, REG_ADDR + 8, counter + readData);
	  counter++;
	  }

	  return 0;
}
