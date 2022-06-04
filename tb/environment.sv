class env;
	generator gen;
	driver dri;
	monitor mon;
	scoreboard sco;
	coverage cov;
	mailbox scb_mbx;
	virtual mips32_bfm mips_vif;
	
	event drv_done;
	mailbox drv_mbx;
	
	function new();
		gen = new;
		dri = new;
		mon = new;
		sco = new;
		sco.v2bfm = mips_vif;
		cov = new;
		cov.bfm = mips_vif;
		scb_mbx = new();
		drv_mbx = new;
	endfunction 
	
	virtual task execute(); 
		//connect virtual interface handles
		dri.mips_vif = mips_vif;
		mon.mips_vif = mips_vif;

		//connect mailboxes
		dri.drv_mbx = drv_mbx;
		gen.drv_mbx = drv_mbx; 
		
		mon.scb_mbx = scb_mbx;
		sco.scb_mbx = scb_mbx; 

		//connect event handles
		dri.drv_done = drv_done;
		gen.drv_done = drv_done;
		
		fork 
			cov.execute();
			sco.execute();
			dri.execute();
			mon.execute();
			gen.execute();
		join_any 
	endtask	
endclass