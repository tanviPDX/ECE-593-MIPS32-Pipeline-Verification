
module top;
import mips32::*;

    mips32_bfm bfm ();
    MIPS_Processor mips (.CLOCK_50(bfm.clk), .rst(bfm.rst), .instr_in(bfm.instr_in), .forward_EN(bfm.forward_EN));

    test tt;

    initial begin
        bfm.reset();
        bfm.v_mem = mips.md;
        tt = new;
        tt.en.mips_vif = bfm;
        tt.execute();

        #50 $finish();
    end    

endmodule
