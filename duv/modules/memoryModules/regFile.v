`include "defines.v"

module regFile (clk, rst, src1, src2, dest, writeVal, writeEn, reg1, reg2);
  input clk, rst, writeEn;
  input [`REG_FILE_ADDR_LEN-1:0] src1, src2, dest;
  input [`WORD_LEN-1:0] writeVal;
  output [`WORD_LEN-1:0] reg1, reg2;

  integer i;

  always @ (negedge clk) begin
    if (rst) begin
      for (i = 0; i < `WORD_LEN; i = i + 1)
        MIPS_Processor.md.regMem[i] <= 0;
	    end

    else if (writeEn) MIPS_Processor.md.regMem[dest] <= writeVal;
    MIPS_Processor.md.regMem[0] <= 0;
  end

  assign reg1 = (MIPS_Processor.md.regMem[src1]);
  assign reg2 = (MIPS_Processor.md.regMem[src2]);
endmodule // regFile
