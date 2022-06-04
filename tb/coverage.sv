`include "defines.v" 

 class coverage;

	virtual mips32_bfm bfm;
	
//coverpoint for hazard detection
	covergroup hazard;
		coverpoint bfm.hazard_detected; 
	endgroup 
	
//covergroup for forwarding unit 
    covergroup forward_unit;
		coverpoint bfm.forward_EN;
	endgroup
	
//covergroup for muxes
	covergroup muxes;
		coverpoint bfm.is_imm;
		coverpoint bfm.MEM_R_EN_WB;
	endgroup 
	
//covergroup for ALU
	covergroup alu;
	//coverpoint for operations
	    coverpoint bfm.EXE_CMD_ID {
			bins b1 = {EX_ADD};
			bins b2 = {EX_SUB};
			bins b3 = {EX_AND};
			bins b4 = {EX_OR};
			bins b5 = {EX_NOR};
			bins b6 = {EX_XOR};
			bins b7 = {EX_SLA};
			bins b8 = {EX_SLL};
			bins b9 = {EX_SRA};
			bins b10= {EX_SRL};
			bins b11= {EX_NO_OPERATION};
		} 
	//coverpoint for operands 
		C2: coverpoint bfm.val1_EXE {
			bins all0 = {'0};
			bins all1 = {'1};			
			bins everthingelse = {[1:32'hFFFFFFFE]};
		}
		C3: coverpoint bfm.val2_EXE {
			bins all0 = {'0};
			bins all1 = {'1};		
			bins everthingelse = {[1:32'hFFFFFFFE]};
		}			
	endgroup 

	//covergroup for opcode
	covergroup opcodes;
		coverpoint bfm.instr_in[31:26] {
			bins op1[] = {[0:1]};
			bins op2   = {3};
			bins op3[] = {[5:12]};
			bins op4[] = {[32:33]};
			bins op5[] = {[36:37]};
			bins op6[] = {[40:42]};
		}
	endgroup

	//covergroup for immediate field 
	covergroup immediate;
		coverpoint bfm.instr_in[15:0] {
			bins imm1 = {'0};
			bins imm2 = {'1};
			bins imm3 = {[1:(2**15)-1]};
		}
	endgroup 
		
	//cross covergroup for branch-hazard 
	covergroup branch;
		b1: coverpoint bfm.hazard_detected;
		b2: coverpoint bfm.Br_Taken_EXE;
		cross b1, b2; 
	endgroup 

	covergroup cross_fwd_hazard;
		a1: coverpoint bfm.hazard_detected;
		a2: coverpoint bfm.forward_EN;
		cross a1, a2;
	endgroup

	function new (virtual mips32_bfm b);
    	hazard = new();
    	forward_unit = new();
    	muxes = new();
		alu = new();
		opcodes = new();
		immediate = new();
		branch = new();
		bfm = b;
	 endfunction

	task execute();
		forever begin
        @(negedge bfm.clk);
         
        hazard.sample();
        forward_unit.sample();
		muxes.sample();
		alu.sample();
		opcodes.sample();
		immediate.sample();
		branch.sample();
      end
   endtask : execute
endclass