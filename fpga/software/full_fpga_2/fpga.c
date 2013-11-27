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

// #define LINE_PITCH 		1440
#define LINE_PITCH			256

//#define DMA_LINE_PTICH	1440
#define DMA_LINE_PTICH	256

#define DMA_LINE_SIZE	1440

#define GFSTART_increment 512

// Register Map
#define GCTRL		0x00
#define GFSTART		0x04
#define GLPITCH 	0x08
#define GINT	 	0x0C
#define DMACTRL		0x10
#define DMAFSTART	0x14
#define DMALPITCH	0x18
#define DMASIZE		0x1C
#define VGACTRL		0x20
#define HTOTAL		0x24
#define HSSYNC		0x28
#define HESNC		0x2C
#define HSVALID		0x30
#define HEVALID		0x34
#define	VTOTAL		0x38
#define VSSYNC		0x3C
#define VESYNC		0x40
#define VSVALID		0x44
#define VEVALID		0x48

#define CHECK_BIT(var,pos) 	((var) & (1<<(pos)))
#define SET_BIT(var,pos) 	(var |= (1U << pos))
#define CLEAR_BIT(var,pos) 	(var &= ~(1U << (pos)))

static void interruptServiceRoutine();

int main()
{
	int readdata = 0;
	int offset = 0;
	int toggle = 0;

	int data = 0xDEAD;

	// Register IRQ
	alt_irq_register(0, 0, interruptServiceRoutine);

	// Enable DMA
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, DMACTRL, 0x1);

	// Set DMA start address to 0
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, DMAFSTART, 0);

	// Write DMA line pitch
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, DMALPITCH, DMA_LINE_PTICH);

	// Define DMA line size
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, DMASIZE, DMA_LINE_SIZE);

	// Set Grab start address to 0
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, GFSTART, 0);

	// Enable a snapshot and write 10 to GMODE // MUST BE STARTED AT 10
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, GCTRL, 0x51);

	// Write the line pitch
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, GLPITCH, LINE_PITCH);

	while (1)
	{
	}
	return 0;
}


static void interruptServiceRoutine()
{
	int readdata;
	int update_gfstart = 0;

	// Reset SOFISTS and EOFISTS
	readdata = IORD_32DIRECT(REGFILE_FINAL_0_BASE, GINT);
	SET_BIT(readdata, 1);
	SET_BIT(readdata, 3);
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, GINT, readdata);

	// Set SHHT and Grab controls
	readdata = IORD_32DIRECT(REGFILE_FINAL_0_BASE, GCTRL);
	if (CHECK_BIT(readdata, 5))
	{
		CLEAR_BIT(readdata, 5);
		update_gfstart = 1;
	}
	else
	{
		SET_BIT(readdata, 5);
	}

	// Set the SHHT
	SET_BIT(readdata, 0);
	// Write the control register
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, GCTRL, readdata);

	// Update GFSTART to new line location
	readdata = IORD_32DIRECT(REGFILE_FINAL_0_BASE, GFSTART);

	if (update_gfstart == 1)
	{
		readdata += GFSTART_increment - 1;
	}
	else
	{
		readdata += 1;
	}
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, GFSTART, readdata);
}
