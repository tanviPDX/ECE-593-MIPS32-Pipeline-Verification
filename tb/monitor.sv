class monitor; 
    virtual mips32_bfm mips_vif;
    mailbox scb_mbx;

    task execute();
        forever begin 
            transaction mon_trans = new();
            @(posedge mips_vif.clk);
            #1;
            mon_trans.instr_in <= mips_vif.instr_in;
            scb_mbx.put(mon_trans);
        end 
    endtask
endclass