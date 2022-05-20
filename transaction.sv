`include "defines.v"

class transaction;
rand bit [`NO_INSTR_BYTES-1:0] [`MEM_CELL_SIZE-1:0] instr_byte;
bit [`WORD_LEN-1:0] PC_MEM;
bit [`WORD_LEN-1:0] ALURes_EXE;
bit [`WORD_LEN-1:0] dataMem_out_MEM;
bit [`WORD_LEN-1:0] WB_result;
bit hazard_detected;
endclass
