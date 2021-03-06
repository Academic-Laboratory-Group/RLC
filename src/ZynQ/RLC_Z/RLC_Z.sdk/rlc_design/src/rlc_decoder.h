/*
 * rlc_decoder.h
 *
 *  Created on: 07.06.2021
 *      Author: Norbert
 */

#ifndef SRC_RLC_DECODER_H_
#define SRC_RLC_DECODER_H_

/***************************** Include Files *********************************/
#include "xil_io.h"
#include "xparameters.h"
#include "decoder_ip.h"
#include "Utils.h"

/**************************** user definitions ********************************/
#define DECODER_BASE_ADDR XPAR_DECODER_IP_0_S00_AXI_BASEADDR

#define DECODER_IN_FLAGS_OFF 	DECODER_IP_S00_AXI_SLV_REG0_OFFSET // control
#define DECODER_DATA_IN_OFF 	DECODER_IP_S00_AXI_SLV_REG1_OFFSET // dataIn
#define DECODER_OUT_FLAGS_OFF 	DECODER_IP_S00_AXI_SLV_REG2_OFFSET // status
#define DECODER_DATA_OUT_OFF	DECODER_IP_S00_AXI_SLV_REG3_OFFSET // dataOut

/***************************** function **********************/
int RLC2bin(u32 data_in, u32* data_out, u32* undersize);

#endif /* SRC_RLC_DECODER_H_ */
