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

#define SECOND 0x2FAF08 //This value represents 1 second worth of counts of 16 clock pulses
//#define SECOND 0x1F

#define CHECK_BIT(var,pos) 	((var) & (1<<(pos)))
#define SET_BIT(var,pos) 	(var |= (1U << pos))
#define CLEAR_BIT(var,pos) 	(var &= ~(1U << (pos)))

int main()
{

	int readdata = 0;

	int interrupt_counter = 0;

	int GP0_val = 0, GP1_val = 0;

  // Set up Control registers

	// Initialize the values of GP0 and GP1
	IOWR_32DIRECT(REGFILE_0_BASE, GP0, GP0_val);
	IOWR_32DIRECT(REGFILE_0_BASE, GP1, GP1_val);

	// Initliaze counter 0 to have the value of 1 second worth of counts
	IOWR_32DIRECT(REGFILE_0_BASE, T0CMP, SECOND);

	// Initialize counter 1 to have a value smaller than counter 0
	IOWR_32DIRECT(REGFILE_0_BASE, T1CMP, SECOND/8 - 10);

	// Reset both timers
	// T0RST(0) active high
	// T1RST(1) active high
	IOWR_32DIRECT(REGFILE_0_BASE, TCTL, 0x00000003);

	// Enable both timers
	// T0CNTEN(2) active high
	// T1CNTEN(3) active high
	IOWR_32DIRECT(REGFILE_0_BASE, TCTL, 0x0000000F);

	// Clear reset (keep timers active)
	IOWR_32DIRECT(REGFILE_0_BASE, TCTL, 0x0000000C);

	// Enable interrupts and the avalon interface interrupts
	// Enable T0INTEN(0) active high
	// Enable T1INTEN(1) active high
	// Enable AVINTDIS(5) active low
	IOWR_32DIRECT(REGFILE_0_BASE, INTCTL, 0x00000003);

	while (1)
	{
		// Poll T0INTSTS
		readdata = IORD_32DIRECT(REGFILE_0_BASE, INTCTL);
		if (CHECK_BIT(readdata, 2))
		{



			/* USE THIS TO SHOW TIMER 1 OVERRUN AND TIMER 0 INTERRUPT */
			// IOWR_32DIRECT(REGFILE_0_BASE, TCTL, 0x00000004);
			// while(1);

			// Read current value of TCTL
			readdata = IORD_32DIRECT(REGFILE_0_BASE, TCTL);
			// Modify reset bit to 1
			SET_BIT(readdata, 0);
			// Write the reset
			IOWR_32DIRECT(REGFILE_0_BASE, TCTL, readdata);

			// Clear the interrupt on 0
			readdata = IORD_32DIRECT(REGFILE_0_BASE, INTCTL);
			CLEAR_BIT(readdata, 3);
			//CLEAR_BIT(readdata, 4); // Clear OVR
			IOWR_32DIRECT(REGFILE_0_BASE, INTCTL, readdata);

			// Disable the reset
			// Read current value of TCTL
			readdata = IORD_32DIRECT(REGFILE_0_BASE, TCTL);
			// Modify reset bit to 1
			CLEAR_BIT(readdata, 0);
			// Write the reset
			IOWR_32DIRECT(REGFILE_0_BASE, TCTL, readdata);

			GP0_val = 0;
			//GP1_val = 0;
			IOWR_32DIRECT(REGFILE_0_BASE, GP0, GP0_val);
			//IOWR_32DIRECT(REGFILE_0_BASE, GP1, GP1_val);
		}
		else
		{
			// Poll T1INTSTS
			readdata = IORD_32DIRECT(REGFILE_0_BASE, INTCTL);
			if (CHECK_BIT(readdata, 3))
			{


				IOWR_32DIRECT(REGFILE_0_BASE, TCTL, 0x00000008);
				while(1);

				// Read current value of TCTL
				readdata = IORD_32DIRECT(REGFILE_0_BASE + TCTL, 0);
				// Modify reset bit to 1
				SET_BIT(readdata, 1);
				// Write the reset
				IOWR_32DIRECT(REGFILE_0_BASE, TCTL, readdata);

				// Clear the interrupt on 1
				readdata = IORD_32DIRECT(REGFILE_0_BASE, INTCTL);
				CLEAR_BIT(readdata, 2);
				CLEAR_BIT(readdata, 4);
				IOWR_32DIRECT(REGFILE_0_BASE, INTCTL, readdata);

				// Disable the reset
				// Read current value of TCTL
				readdata = IORD_32DIRECT(REGFILE_0_BASE + TCTL, 0);
				// Modify reset bit to 1
				CLEAR_BIT(readdata, 1);
				// Write the reset
				IOWR_32DIRECT(REGFILE_0_BASE, TCTL, readdata);

				// Write the new values into the GP registers
				GP0_val = IORD_32DIRECT(REGFILE_0_BASE, GP0);
				//GP1_val *= GP0_val;
				IOWR_32DIRECT(REGFILE_0_BASE, GP0, GP0_val + 1);
				//IOWR_32DIRECT(REGFILE_0_BASE, GP1, GP1_val);
			}
		}
	}
  return 0;
}



