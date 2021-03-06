`include "defines.v"

module dataMem (clk, rst, writeEn, readEn, address, dataIn, dataOut);
  input clk, rst, readEn, writeEn;
  input [`WORD_LEN-1:0] address, dataIn;
  output [`WORD_LEN-1:0] dataOut;

  integer i;

  wire [`WORD_LEN-1:0] base_address;

  always @ (posedge clk) begin
    if (rst)
      for (i = 0; i < `DATA_MEM_SIZE; i = i + 1)
        MIPS_Processor.md.dataMem[i] <= 0;
    else if (writeEn)
      {MIPS_Processor.md.dataMem[base_address], MIPS_Processor.md.dataMem[base_address + 1], MIPS_Processor.md.dataMem[base_address + 2], MIPS_Processor.md.dataMem[base_address + 3]} <= dataIn;
  end

  assign base_address = ((address & 32'b11111111111111111111101111111111) >> 2) << 2;
  assign dataOut = (address < 1024) ? 0 : {MIPS_Processor.md.dataMem[base_address], MIPS_Processor.md.dataMem[base_address + 1], MIPS_Processor.md.dataMem[base_address + 2], MIPS_Processor.md.dataMem[base_address + 3]};
endmodule // dataMem
