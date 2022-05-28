import mips32::*;

class driver;
    virtual mips32_bfm mips_vif;
    event drv_done;
    mailbox drv_mbx;
    transaction trans;

    task execute();
        forever begin
            drv_mbx.get(trans);
            @ (posedge mips_vif.clk);
            mips_vif.instr_in <= trans.instr_in;
            ->drv_done;
        end    
    endtask
endclass