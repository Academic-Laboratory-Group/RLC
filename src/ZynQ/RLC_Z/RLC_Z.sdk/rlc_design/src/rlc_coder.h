/*
 * rlc_coder.h
 *
 *  Created on: 07.06.2021
 *      Author: Norbert
 */

#ifndef SRC_RLC_CODER_H_
#define SRC_RLC_CODER_H_

/***************************** Include Files *********************************/
#include "xil_io.h"
#include "xparameters.h"
#include "coder_ip.h"

/**************************** user definitions ********************************/
#define CODER_BASE_ADDR XPAR_CODER_IP_0_S00_AXI_BASEADDR

#define CODER_IN_FLAGS_OFF 	CODER_IP_S00_AXI_SLV_REG0_OFFSET // control
#define CODER_DATA_IN_OFF 	CODER_IP_S00_AXI_SLV_REG1_OFFSET // dataIn
#define CODER_OUT_FLAGS_OFF CODER_IP_S00_AXI_SLV_REG2_OFFSET // status
#define CODER_DATA_OUT_OFF	CODER_IP_S00_AXI_SLV_REG3_OFFSET // dataOut

/***************************** function **********************/
int bin2RLC(u32 data_in, u32* data_out, u32* oversize);


#endif /* SRC_RLC_CODER_H_ */
