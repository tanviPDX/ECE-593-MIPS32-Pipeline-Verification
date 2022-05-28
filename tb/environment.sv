import mips32::*;

class environment;
	generator gen;
	driver dri;
	scoreboard sco;
	virtual mips32_bfm mips_vif;
	
	event drv_done;
	mailbox drv_mbx;
	
	function new();
		gen = new;
		dri = new;
		sco = new;
		drv_mbx = new;
	endfunction 
	
	virtual task execute(); 
		//connect virtual interface handles
		dri.mips_vif = mips_vif;
		
		//connect mailboxes
		dri.drv_mbx = drv_mbx;
		gen.drv_mbx = drv_mbx; 
		
		//connect event handles
		dri.drv_done = drv_done;
		gen.drv_done = drv_done;
		
		fork 
			dri.execute();
			gen.execute();
		join_any 
	endtask	
endclass