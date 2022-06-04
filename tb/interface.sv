`include "defines.v"

interface mips32_bfm ();

// Interface signals
	logic clk;
	logic rst;
	logic [`INSTR_WIDTH-1:0] instr_in;

	logic [`MEM_CELL_SIZE-1:0] instMem [0:`INSTR_MEM_SIZE-1];
	logic [`MEM_CELL_SIZE-1:0] dataMem [0:`DATA_MEM_SIZE-1];
	logic [`WORD_LEN-1:0] regMem [0:`REG_FILE_SIZE-1];


	wire forward_EN; 

	wire [`WORD_LEN-1:0] PC_IF, PC_ID, PC_EXE, PC_MEM;
	wire [`WORD_LEN-1:0] inst_IF, inst_ID;
	wire [`WORD_LEN-1:0] reg1_ID, reg2_ID, ST_value_EXE, ST_value_EXE2MEM, ST_value_MEM;
	wire [`WORD_LEN-1:0] val1_ID, val1_EXE;
	wire [`WORD_LEN-1:0] val2_ID, val2_EXE;
	wire [`WORD_LEN-1:0] ALURes_EXE, ALURes_MEM, ALURes_WB;
	wire [`WORD_LEN-1:0] dataMem_out_MEM, dataMem_out_WB;
	wire [`WORD_LEN-1:0] WB_result;
	wire [`REG_FILE_ADDR_LEN-1:0] dest_EXE, dest_MEM, dest_WB; // dest_ID = instruction[25:21] thus nothing declared
	wire [`REG_FILE_ADDR_LEN-1:0] src1_ID, src2_regFile_ID, src2_forw_ID, src2_forw_EXE, src1_forw_EXE;
	wire [`EXE_CMD_LEN-1:0] EXE_CMD_ID, EXE_CMD_EXE;
	wire [`FORW_SEL_LEN-1:0] val1_sel, val2_sel, ST_val_sel;
	wire [1:0] branch_comm;
	wire Br_Taken_ID, IF_Flush, Br_Taken_EXE;
	wire MEM_R_EN_ID, MEM_R_EN_EXE, MEM_R_EN_MEM, MEM_R_EN_WB;
	wire MEM_W_EN_ID, MEM_W_EN_EXE, MEM_W_EN_MEM;
	wire WB_EN_ID, WB_EN_EXE, WB_EN_MEM, WB_EN_WB;
	wire hazard_detected, is_imm, ST_or_BNE;

	initial begin
		clk = 0;
		forever begin
			#10 clk = ~clk;
		end
	end
	
// task for reset	
	task reset();
        rst = 1'b1;
        repeat(`NO_INSTR)
            @(negedge clk);
        rst = 1'b0;
    endtask

	task mem();
	 	regMem = top.mips.md.regMem;
	 	dataMem = top.mips.md.dataMem;
		$display("val: %p", regMem); 
	endtask
    
	
endinterface

	
