`include "defines.v"

class transaction;
rand byte instr_byte [`NO_INSTR_BYTES-1:0];
bit [`WORD_LEN-1:0] PC_MEM;
bit [`WORD_LEN-1:0] ALURes_EXE;
bit [`WORD_LEN-1:0] dataMem_out_MEM;
bit [`WORD_LEN-1:0] WB_result;
bit hazard_detected;

constraint opcode { foreach (instr_byte[i]) {
			if (i % 4 == 3){
                        (( instr_byte[i] & 252) >> 2) inside {0, 1, 3, 5, 6, 7, 
				8, 9, 10, 11, 12, 32, 33, 36, 37, 40, 41, 42 };	  
		  			}
		  }}

constraint imm_field { foreach (instr_byte[i]) {
		        if (i % 4 == 3){
                            if ((( instr_byte[i] & 252) >> 2) > 36) {  
				      instr_byte[i-2] == 8'b0; }
		     }}}
	
endclass
