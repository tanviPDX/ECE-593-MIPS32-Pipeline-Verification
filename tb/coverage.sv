`include "defines.v" 

 import mips32::*;

 class coverage;
 
 //temperory adding these signals. Remove it later
	rand byte hazard_detected;
	rand byte forward_EN;
	rand byte Is_Imm;
	rand byte MEM_R_EN;
	rand byte EXE_CMD;
	rand byte val1;
	rand byte val2;
	rand byte in;
	rand byte opCode;

	
//coverpoint for hazard detection
	covergroup hazard;
		coverpoint hazard_detected; 
	endgroup 
	
//covergroup for forwarding unit 
    covergroup forward_unit;
		coverpoint forward_EN;
	endgroup
	
//covergroup for muxes
	covergroup muxes;
		coverpoint Is_Imm;
		coverpoint MEM_R_EN;
	endgroup 
	
//covergroup for ALU
	covergroup alu;
	//coverpoint for operations
	    coverpoint EXE_CMD {
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
		C2: coverpoint val1 {
				bins all0 = {'0};
				bins all1 = {'1};			
				bins everthingelse = {[1:(2**32)-1]};
		}
		C3: coverpoint val2 {
				bins all0 = {'0};
				bins all1 = {'1};		
				bins everthingelse = {[1:(2**32)-1]};
		}			
	endgroup 

	//covergroup for opcode
		covergroup opcodes;
			coverpoint opCode {
				bins op1[] = {[0:1]};
				bins op2   = {3};
				bins op2[] = {[5:12]};
				bins op2[] = {[32:33]};
				bins op2[] = {[36:37]};
				bins op2[] = {[40:42]};
			}
		endgroup

	//covergroup for immediate field 
		covergroup immediate;
			coverpoint in {
				bins imm1 = {'0};
				bins imm2 = {'1};
				bins imm3 = {[1:(2**15)-1]};
			}
		endgroup 
		
	//cross covergroup for branch-hazard 
		covergroup branch;
			coverpoint brTaken;
			cross brTaken, hazard_detected; 
		endgroup 

endclass
		
	
	
	
	
	
	
	
	
	
	
	
