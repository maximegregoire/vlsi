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

#define LINE_PITCH 0x2

#define LINE_COUNT 8192

#define GLPITCH 	0x08
#define GINT	 	0x0C

#define CHECK_BIT(var,pos) 	((var) & (1<<(pos)))
#define SET_BIT(var,pos) 	(var |= (1U << pos))
#define CLEAR_BIT(var,pos) 	(var &= ~(1U << (pos)))

int main()
{
	int readdata = 0;
	int offset = 0;
	int toggle = 0;

	int data = 0xDEAD;


	// Write the LINE PITCH
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, GLPITCH, LINE_PITCH);

	// Enable Start-Of-Frame interrupt and End-Of-Frame interrupt
	IOWR_32DIRECT(REGFILE_FINAL_0_BASE, GINT, 0x05);


	while (1)
	{
//		IOWR_16DIRECT(NEW_SDRAM_CONTROLLER_0_BASE, offset * LINE_PITCH, data);
//
//		readdata = IORD_16DIRECT(NEW_SDRAM_CONTROLLER_0_BASE, offset);
//
//		offset++;
//
//		if (toggle == 0)
//		{
//			toggle = 1;
//			data = 0xDEAD;
//		}
//		else
//		{
//			toggle = 0;
//			data = 0xCAFE;
//		}
	}
	return 0;
}
