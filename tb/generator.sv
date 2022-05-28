`include "defines.v"

import mips32::*;
class generator;
	mailbox drv_mbx;
	event drv_done;
	int iter = `NO_INSTR;
	
	task execute();
		for (int i = 0; i < iter; i = i + 1) begin
			transaction trans = new;
			if(!trans.randomize()) $fatal("Randomization failed");
			drv_mbx.put(trans);
			@(drv_done);
		end
	endtask
endclass