`include "defines.v"

module MIPS_Processor (mips32_bfm bif, input [`INSTR_WIDTH-1:0] instr_in);

	regFile regFile(
		// INPUTS
		.clk(bif.clk),
		.rst(bif.rst),
		.src1(bif.src1_ID),
		.src2(bif.src2_regFile_ID),
		.dest(bif.dest_WB),
		.writeVal(bif.WB_result),
		.writeEn(bif.WB_EN_WB),
		// OUTPUTS
		.reg1(bif.reg1_ID),
		.reg2(bif.reg2_ID)
	);

	hazard_detection hazard (
		// INPUTS
		.forward_EN(bif.forward_EN),
		.is_imm(bif.is_imm),
		.ST_or_BNE(bif.ST_or_BNE),
		.src1_ID(bif.src1_ID),
		.src2_ID(bif.src2_regFile_ID),
		.dest_EXE(bif.dest_EXE),
		.dest_MEM(bif.dest_MEM),
		.WB_EN_EXE(bif.WB_EN_EXE),
		.WB_EN_MEM(bif.WB_EN_MEM),
		.MEM_R_EN_EXE(bif.MEM_R_EN_EXE),
		// OUTPUTS
		.branch_comm(bif.branch_comm),
		.hazard_detected(bif.hazard_detected)
	);

	forwarding_EXE forwrding_EXE (
		.src1_EXE(bif.src1_forw_EXE),
		.src2_EXE(bif.src2_forw_EXE),
		.ST_src_EXE(bif.dest_EXE),
		.dest_MEM(bif.dest_MEM),
		.dest_WB(bif.dest_WB),
		.WB_EN_MEM(bif.WB_EN_MEM),
		.WB_EN_WB(bif.WB_EN_WB),
		.val1_sel(bif.val1_sel),
		.val2_sel(bif.val2_sel),
		.ST_val_sel(bif.ST_val_sel)
	);

	memDefs md ();

	loadtomem loadmem (
		.rst(bif.rst),
		.instr_in(instr_in)
	);

	//###########################
	//##### PIPLINE STAGES ######
	//###########################
	IFStage IFStage (
		// INPUTS
		.clk(bif.clk),
		.rst(bif.rst),
		.freeze(bif.hazard_detected),
		.brTaken(bif.Br_Taken_ID),
		.brOffset(bif.val2_ID),
		// OUTPUTS
		.instruction(bif.inst_IF),
		.PC(bif.PC_IF)
	);

	IDStage IDStage (
		// INPUTS
		.clk(bif.clk),
		.rst(bif.rst),
		.hazard_detected_in(bif.hazard_detected),
		.instruction(bif.inst_ID),
		.reg1(bif.reg1_ID),
		.reg2(bif.reg2_ID),
		// OUTPUTS
		.src1(bif.src1_ID),
		.src2_reg_file(bif.src2_regFile_ID),
		.src2_forw(bif.src2_forw_ID),
		.val1(bif.val1_ID),
		.val2(bif.val2_ID),
		.brTaken(bif.Br_Taken_ID),
		.EXE_CMD(bif.EXE_CMD_ID),
		.MEM_R_EN(bif.MEM_R_EN_ID),
		.MEM_W_EN(bif.MEM_W_EN_ID),
		.WB_EN(bif.WB_EN_ID),
		.is_imm_out(bif.is_imm),
		.ST_or_BNE_out(bif.ST_or_BNE),
		.branch_comm(bif.branch_comm)
	);

	EXEStage EXEStage (
		// INPUTS
		.clk(bif.clk),
		.EXE_CMD(bif.EXE_CMD_EXE),
		.val1_sel(bif.val1_sel),
		.val2_sel(bif.val2_sel),
		.ST_val_sel(bif.ST_val_sel),
		.val1(bif.val1_EXE),
		.val2(bif.val2_EXE),
		.ALU_res_MEM(bif.ALURes_MEM),
		.result_WB(bif.WB_result),
		.ST_value_in(bif.ST_value_EXE),
		// OUTPUTS
		.ALUResult(bif.ALURes_EXE),
		.ST_value_out(bif.ST_value_EXE2MEM)
	);

	MEMStage MEMStage (
		// INPUTS
		.clk(bif.clk),
		.rst(bif.rst),
		.MEM_R_EN(bif.MEM_R_EN_MEM),
		.MEM_W_EN(bif.MEM_W_EN_MEM),
		.ALU_res(bif.ALURes_MEM),
		.ST_value(bif.ST_value_MEM),
		// OUTPUTS
		.dataMem_out(bif.dataMem_out_MEM)
	);

	WBStage WBStage (
		// INPUTS
		.MEM_R_EN(bif.MEM_R_EN_WB),
		.memData(bif.dataMem_out_WB),
		.aluRes(bif.ALURes_WB),
		// OUTPUTS
		.WB_res(bif.WB_result)
	);

	//############################
	//#### PIPLINE REGISTERS #####
	//############################
	IF2ID IF2IDReg (
		// INPUTS
		.clk(bif.clk),
		.rst(bif.rst),
		.flush(bif.IF_Flush),
		.freeze(bif.hazard_detected),
		.PCIn(bif.PC_IF),
		.instructionIn(bif.inst_IF),
		// OUTPUTS
		.PC(bif.PC_ID),
		.instruction(bif.inst_ID)
	);

	ID2EXE ID2EXEReg (
		.clk(bif.clk),
		.rst(bif.rst),
		// INPUTS
		.destIn(bif.inst_ID[25:21]),
		.src1_in(bif.src1_ID),
		.src2_in(bif.src2_forw_ID),
		.reg2In(bif.reg2_ID),
		.val1In(bif.val1_ID),
		.val2In(bif.val2_ID),
		.PCIn(bif.PC_ID),
		.EXE_CMD_IN(bif.EXE_CMD_ID),
		.MEM_R_EN_IN(bif.MEM_R_EN_ID),
		.MEM_W_EN_IN(bif.MEM_W_EN_ID),
		.WB_EN_IN(bif.WB_EN_ID),
		.brTaken_in(bif.Br_Taken_ID),
		// OUTPUTS
		.src1_out(bif.src1_forw_EXE),
		.src2_out(bif.src2_forw_EXE),
		.dest(bif.dest_EXE),
		.ST_value(bif.ST_value_EXE),
		.val1(bif.val1_EXE),
		.val2(bif.val2_EXE),
		.PC(bif.PC_EXE),
		.EXE_CMD(bif.EXE_CMD_EXE),
		.MEM_R_EN(bif.MEM_R_EN_EXE),
		.MEM_W_EN(bif.MEM_W_EN_EXE),
		.WB_EN(bif.WB_EN_EXE),
		.brTaken_out(bif.Br_Taken_EXE)
	);

	EXE2MEM EXE2MEMReg (
		.clk(bif.clk),
		.rst(bif.rst),
		// INPUTS
		.WB_EN_IN(bif.WB_EN_EXE),
		.MEM_R_EN_IN(bif.MEM_R_EN_EXE),
		.MEM_W_EN_IN(bif.MEM_W_EN_EXE),
		.PCIn(bif.PC_EXE),
		.ALUResIn(bif.ALURes_EXE),
		.STValIn(bif.ST_value_EXE2MEM),
		.destIn(bif.dest_EXE),
		// OUTPUTS
		.WB_EN(bif.WB_EN_MEM),
		.MEM_R_EN(bif.MEM_R_EN_MEM),
		.MEM_W_EN(bif.MEM_W_EN_MEM),
		.PC(bif.PC_MEM),
		.ALURes(bif.ALURes_MEM),
		.STVal(bif.ST_value_MEM),
		.dest(bif.dest_MEM)
	);

	MEM2WB MEM2WB(
		.clk(bif.clk),
		.rst(bif.rst),
		// INPUTS
		.WB_EN_IN(bif.WB_EN_MEM),
		.MEM_R_EN_IN(bif.MEM_R_EN_MEM),
		.ALUResIn(bif.ALURes_MEM),
		.memReadValIn(bif.dataMem_out_MEM),
		.destIn(bif.dest_MEM),
		// OUTPUTS
		.WB_EN(bif.WB_EN_WB),
		.MEM_R_EN(bif.MEM_R_EN_WB),
		.ALURes(bif.ALURes_WB),
		.memReadVal(bif.dataMem_out_WB),
		.dest(bif.dest_WB)
	);

	assign bif.IF_Flush = bif.Br_Taken_ID;
endmodule
