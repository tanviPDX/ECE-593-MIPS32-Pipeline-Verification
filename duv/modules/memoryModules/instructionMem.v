`include "defines.v"

module instructionMem (rst, addr, instruction);
  
  input rst;
  input [`WORD_LEN-1:0] addr;
  output [`WORD_LEN-1:0] instruction;

  wire [$clog2(`INSTR_MEM_SIZE)-1:0] address = addr[$clog2(`INSTR_MEM_SIZE)-1:0];

  assign instruction = {memDefs.instMem[address], memDefs.instMem[address + 1], memDefs.instMem[address + 2], memDefs.instMem[address + 3]};
endmodule // instructionMem
