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
        memDefs.regMem[i] <= 0;
	    end

    else if (writeEn) memDefs.regMem[dest] <= writeVal;
    memDefs.regMem[0] <= 0;
  end

  assign reg1 = (memDefs.regMem[src1]);
  assign reg2 = (memDefs.regMem[src2]);
endmodule // regFile
