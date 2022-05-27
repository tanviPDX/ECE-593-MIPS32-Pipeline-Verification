class generator;
	mailbox drv_mbx;
	event drv_done;
	int iter = 10;
	
	task run();
		for (int i = 0; i < iter; i = i + 1) begin
			transaction trans = new;
			trans.randomize();
			drv_mbx.put(trans);
			@(drv_done);
		end
	endtask
endclass