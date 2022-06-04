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
	    coverpoint bfm.EXE_CMD_EXE {
			bins b1 = {ADD};
			bins b2 = {SUB};
			bins b3 = {AND};
			bins b4 = {OR};
			bins b5 = {NOR};
			bins b6 = {XOR};
			bins b7 = {SLA};
			bins b8 = {SLL};
			bins b9 = {SRA};
			bins b10= {SRL};
		} 
	//coverpoint for operands 
		C2: coverpoint bfm.val1_EXE {
			bins all0 = {'0};
			bins all1 = {'1};			
			bins everthingelse = {[1:(2**32)-1]};
		}
		C3: coverpoint bfm.val2_EXE {
			bins all0 = {'0};
			bins all1 = {'1};		
			bins everthingelse = {[1:(2**32)-1]};
		}			
	endgroup 

	//covergroup for opcode
	// covergroup opcodes;
	// 	coverpoint bfm.opCode {
	// 		bins op1[] = {[0:1]};
	// 		bins op2   = {3};
	// 		bins op3[] = {[5:12]};
	// 		bins op4[] = {[32:33]};
	// 		bins op5[] = {[36:37]};
	// 		bins op6[] = {[40:42]};
	// 	}
	// endgroup

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
		//opcodes = new();
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
		//opcodes.sample();
		immediate.sample();
		branch.sample();
      end
   endtask : execute
endclass