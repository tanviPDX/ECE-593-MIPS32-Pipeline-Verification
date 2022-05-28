`include "defines.v"

interface mips32_bfm ();

// Interface signals
	logic clk, rst;
	logic [`INSTR_WIDTH-1:0] instr_in;
	logic forward_EN; 

	logic [`WORD_LEN-1:0] PC_IF, PC_ID, PC_EXE, PC_MEM;
	logic [`WORD_LEN-1:0] inst_IF, inst_ID;
	logic [`WORD_LEN-1:0] reg1_ID, reg2_ID, ST_value_EXE, ST_value_EXE2MEM, ST_value_MEM;
	logic [`WORD_LEN-1:0] val1_ID, val1_EXE;
	logic [`WORD_LEN-1:0] val2_ID, val2_EXE;
	logic [`WORD_LEN-1:0] ALURes_EXE, ALURes_MEM, ALURes_WB;
	logic [`WORD_LEN-1:0] dataMem_out_MEM, dataMem_out_WB;
	logic [`WORD_LEN-1:0] WB_result;
	logic [`REG_FILE_ADDR_LEN-1:0] dest_EXE, dest_MEM, dest_WB; // dest_ID = instruction[25:21] thus nothing declared
	logic [`REG_FILE_ADDR_LEN-1:0] src1_ID, src2_regFile_ID, src2_forw_ID, src2_forw_EXE, src1_forw_EXE;
	logic [`EXE_CMD_LEN-1:0] EXE_CMD_ID, EXE_CMD_EXE;
	logic [`FORW_SEL_LEN-1:0] val1_sel, val2_sel, ST_val_sel;
	logic [1:0] branch_comm;
	logic Br_Taken_ID, IF_Flush, Br_Taken_EXE;
	logic MEM_R_EN_ID, MEM_R_EN_EXE, MEM_R_EN_MEM, MEM_R_EN_WB;
	logic MEM_W_EN_ID, MEM_W_EN_EXE, MEM_W_EN_MEM;
	logic WB_EN_ID, WB_EN_EXE, WB_EN_MEM, WB_EN_WB;
	logic hazard_detected, is_imm, ST_or_BNE;
	
// task for reset	
	task reset();
        rst = 1'b1;
        repeat(`NO_INSTR)
            @(negedge clk);
        rst = 1'b0;
    endtask

    
	
endinterface

	
