`include "defines.v"

module loadtomem (rst, instr_in);
  input rst;
  input [`INSTR_WIDTH-1:0] instr_in;

  integer address = 0;

  always @(instr_in) begin
    if(rst) begin
        MIPS_Processor.md.instMem[address] <= instr_in[7:0];
        MIPS_Processor.md.instMem[address+1] <= instr_in[15:8];
        MIPS_Processor.md.instMem[address+2] <= instr_in[23:16];
        MIPS_Processor.md.instMem[address+3] <= instr_in[31:24];
        address = address + 4;
    end
  end  
  
endmodule // instructionMem
