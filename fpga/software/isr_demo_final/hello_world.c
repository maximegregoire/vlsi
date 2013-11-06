/*
 * nios2_isr_main.c
 *
 *  Created on: 2013-10-05
 *      Author: pwhite8
 */
#include "system.h"
#include "io.h"


#include <stdio.h>

#define HARDWARE 0
#define SOFTWARE 1

#define POLL 0
#define AVALON 1

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
#define FREQUENCY 100000

#define CHECK_BIT(var,pos) 	((var) & (1<<(pos)))
#define SET_BIT(var,pos) 	(var |= (1U << pos))
#define CLEAR_BIT(var,pos) 	(var &= ~(1U << (pos)))

int GP0_val, GP1_val;

static void interruptServiceRoutine();
int interruptMode();

int main()
{
	int readdata = 0;

	// 0 -- HARDWARE  1 -- MODELSIM
	int testingMode = 1;

	/* FOR REPORT TO SHOW REG WRITE/READ */
	GP0_val = 0xDEADBEEF;
	GP1_val = 0xFACECAFE;
	IOWR_32DIRECT(REGFILE_0_BASE, GP0, GP0_val);
	IOWR_32DIRECT(REGFILE_0_BASE, GP1, GP1_val);
	IORD_32DIRECT(REGFILE_0_BASE, GP0);
	IORD_32DIRECT(REGFILE_0_BASE, GP1);

	int intMode = interruptMode();

	// Set up Control registers
	GP0_val = 0;
	GP1_val = 1;

	// Initialize the values of GP0 and GP1
	IOWR_32DIRECT(REGFILE_0_BASE, GP0, GP0_val);
	IOWR_32DIRECT(REGFILE_0_BASE, GP1, GP1_val);

	if (testingMode == HARDWARE)
	{
		// Initliaze counter 0 to have the value of 1 second worth of counts
		IOWR_32DIRECT(REGFILE_0_BASE, T0CMP, SECOND);
		// Initialize counter 1 to have a value smaller than counter 0
		IOWR_32DIRECT(REGFILE_0_BASE, T1CMP, SECOND/FREQUENCY);
	}
	else if (testingMode == SOFTWARE)
	{
		// Initliaze counter 0 to have the value of 1 second worth of counts
		IOWR_32DIRECT(REGFILE_0_BASE, T0CMP, 0x2F);
		// Initialize counter 1 to have a value smaller than counter 0
		IOWR_32DIRECT(REGFILE_0_BASE, T1CMP, 0xF);
	}

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
	//IOWR_32DIRECT(REGFILE_0_BASE, INTCTL, 0x00000003);

	// Register IRQ
	alt_irq_register(0,0, interruptServiceRoutine);

	while (1)
	{
		// Poll
		if (intMode == POLL)
		{
			// Poll T0INTSTS
			readdata = IORD_32DIRECT(REGFILE_0_BASE, INTCTL);
			if (CHECK_BIT(readdata,2))
			{
				/* UNCOMMENT THIS TO SHOW TIMER 1 INTERRUPT AND TIMER 0 INTERRUPT */
				// IOWR_32DIRECT(REGFILE_0_BASE, TCTL, 0x00000004);
				// while(1);
				interrupt0();
			}
			if (CHECK_BIT(readdata,3))
			{
				/* UNCOMMENT THIS TO SHOW TIMER 1 INTERRUPT AND TIMER 1 INTERRUPT */
				// IOWR_32DIRECT(REGFILE_0_BASE, TCTL, 0x00000008);
				// while(1);
				interrupt1();
			}
		}
		// IRQ
		else if (intMode == AVALON)
		{
		}
	}

	return 0;
}


static void interruptServiceRoutine()
{
	// Poll T0INTSTS
	int readdata = IORD_32DIRECT(REGFILE_0_BASE, INTCTL);
	if (CHECK_BIT(readdata,2))
	{
		/* UNCOMMENT THIS TO SHOW TIMER 1 OVERRUN AND TIMER 0 INTERRUPT */
		// IOWR_32DIRECT(REGFILE_0_BASE, TCTL, 0x00000004);
		// while(1);
		interrupt0();
	}
	if (CHECK_BIT(readdata,3))
	{
		/* UNCOMMENT THIS TO SHOW TIMER 1 OVERRUN AND TIMER 1 INTERRUPT */
		// IOWR_32DIRECT(REGFILE_0_BASE, TCTL, 0x00000008);
		// while(1);
		interrupt1();
	}
}


void interrupt0()
{
	// Uncomment to show final count of Timer 1 events serviced
	// while(1);

	GP0_val = 0;
	GP1_val = 0;
	IOWR_32DIRECT(REGFILE_0_BASE, GP0, GP0_val);
	IOWR_32DIRECT(REGFILE_0_BASE, GP1, GP1_val);

	// Clear the interrupt on 0
	int readdata = IORD_32DIRECT(REGFILE_0_BASE, INTCTL);
	CLEAR_BIT(readdata, 3);
	CLEAR_BIT(readdata, 4); // Don't clear overrun
	IOWR_32DIRECT(REGFILE_0_BASE, INTCTL, readdata);
}

void interrupt1()
{
	// Write the new values into the GP registers
	GP0_val = IORD_32DIRECT(REGFILE_0_BASE, GP0);
	IOWR_32DIRECT(REGFILE_0_BASE, GP0, GP0_val + 1);
	GP1_val = IORD_32DIRECT(REGFILE_0_BASE, GP1);
	IOWR_32DIRECT(REGFILE_0_BASE, GP1, GP1_val * GP0_val);

	// Clear the interrupt on 1
	int readdata = IORD_32DIRECT(REGFILE_0_BASE, INTCTL);
	CLEAR_BIT(readdata, 2);
	IOWR_32DIRECT(REGFILE_0_BASE, INTCTL, readdata);
}

int interruptMode()
{
	int readdata = IORD_32DIRECT(REGFILE_0_BASE, INTCTL);
	if(CHECK_BIT(readdata, 5))
	{
		return 0;
	}

	return 1;
}

