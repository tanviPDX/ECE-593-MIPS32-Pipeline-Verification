`include "defines.v"

class generator;
	mailbox drv_mbx;
	event drv_done;
	int iter = `NO_INSTR;
	
	task execute();
		for (int i = 0; i < iter; i = i + 1) begin
			transaction trans = new;
			if(!trans.randomize()) $fatal("Randomization failed");
			trans.instr_in = {trans.opCode, trans.rd, trans.rs1, trans.rs2_imm, trans.immediate};
			drv_mbx.put(trans);
			@(drv_done);
		end
	endtask
endclass