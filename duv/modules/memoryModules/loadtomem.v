`include "defines.v"

module loadtomem (rst, addr, instr_in);
  input rst;
  input [`WORD_LEN-1:0] addr;
  input [`INSTR_WIDTH-1:0] instr_in;

  wire [$clog2(`INSTR_MEM_SIZE)-1:0] address = addr[$clog2(`INSTR_MEM_SIZE)-1:0];

  always @(*) begin
    if(rst) begin
        MIPS_Processor.md.instMem[address] <= instr_in[7:0];
        MIPS_Processor.md.instMem[address+1] <= instr_in[15:8];
        MIPS_Processor.md.instMem[address+2] <= instr_in[23:16];
        MIPS_Processor.md.instMem[address+3] <= instr_in[31:24];
    end
  end  
  
endmodule // instructionMem
