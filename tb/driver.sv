class driver;
    virtual mips32_bfm mips_vif;
    event drv_done;
    mailbox drv_mbx;

    task execute();
        forever begin
            transaction trans;
            drv_mbx.get(trans);
            @ (posedge mips_vif.clk);
            mips_vif.instr_in = trans.instr_in;
            $display("instr: %h", mips_vif.instr_in);
            mips_vif.forward_EN = trans.forward_EN;
            mips_vif.mem();
            ->drv_done;
        end    
    endtask
endclass