class monitor; 
    virtual mips32_bfm mips_vif;
    mailbox drv_mbx;

    task start ();
        forever begin 
            transaction m_trans= new();
            @(posedge mips_vif);
            #1;
                m_trans.op_code     = mips_vif.op_code;
                m_trans.rd          = mips_vif.rd;
                m_trans.rs1         = mips_vif.rs1;
                m_trans.rs2         = mips_vif.rs2;
                m_trans.immediate_r = mips_vif.immediate_r;
                m_trans.immediate_i = mips_vif.immediate_i;
            drv_mbx.put(m_trans);
        end 
    endtask
endclass

