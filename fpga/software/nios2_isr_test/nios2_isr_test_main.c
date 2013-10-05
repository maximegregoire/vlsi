/*
 * nios2_isr_main.c
 *
 *  Created on: 2013-10-05
 *      Author: pwhite8
 */
#include "system.h"
#include "io.h"


#include <stdio.h>

#define INTCTL 	0x0
#define TCTL 	0x4
#define T0CNT	0x8
#define T1CNT	0xC
#define T0CMP	0x10
#define T1CMP	0x14
#define GP0		0x18
#define GP1		0x1C

int main()
{

	int readdata = 0;

  // Set up Control registers

	// Enable interrupts and the avalon interface interrupts
	// Enable T0INTEN(0) active high
	// Enable T1INTEN(1) active high
	// Enable AVINTDIS(5) active low
	IOWR_32DIRECT(REGFILE_0_BASE + INTCTL, 0, 0x00000003);

	// Write compare values for counters into registers
	IOWR_32DIRECT(REGFILE_0_BASE + T0CMP, 0, 0x000000FF);
	IOWR_32DIRECT(REGFILE_0_BASE + T1CMP, 0, 0x000000FF);

	// Reset both timers
	// T0RST(0) active high
	// T1RST(1) active high
	IOWR_32DIRECT(REGFILE_0_BASE + TCTL, 0, 0x00000003);

	// Enable both timers
	// T0CNTEN(2) active high
	// T1CNTEN(3) active high
	IOWR_32DIRECT(REGFILE_0_BASE + TCTL, 0, 0x0000000F);

	// Clear reset (keep timers active)
	IOWR_32DIRECT(REGFILE_0_BASE + TCTL, 0, 0x0000000C);

	// Read counters to make sure they are reset
	readdata = IORD_32DIRECT(REGFILE_0_BASE + T0CNT, 0);
	printf("Count0 is %d", readdata);
	readdata = IORD_32DIRECT(REGFILE_0_BASE + T1CNT, 0);
	printf("Count1 is %d", readdata);


  return 0;
}


