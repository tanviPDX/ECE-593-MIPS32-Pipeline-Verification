`include "defines.v" 

 import mips32::*;

 class coverage;
	rand byte hazard_detected;
	rand byte forward_EN;
	rand byte Is_Imm;
	rand byte MEM_R_EN;
	rand byte EXE_CMD;
	rand byte val1;
	rand byte val2;
	
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
	    /* coverpoint EXE_CMD {
			bins ADD;
			bins SUB;
			bins AND;
			bins OR;
			bins NOR;
			bins XOR;
			bins SLA;
			bins SLL;
			bins SRA;
			bins SRL;
		} */
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

endclass
		
	
	
	
	
	
	
	
	
	
	
	
