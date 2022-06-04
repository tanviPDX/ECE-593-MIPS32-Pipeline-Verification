import mips32::*;
`include "defines.v"

module top;

    
    mips32_bfm bfm ();
    MIPS_Processor mips (.bif(bfm), .instr_in(bfm.instr_in));

    bind memDefs mips32_bfm inst1();
    
    test tt;

    initial begin
        bfm.reset();
        tt = new;
        tt.en.mips_vif = bfm;
        tt.execute();

        #50 $finish();
    end    

endmodule
