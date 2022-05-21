`include "defines.v"

module instructionMem (rst, addr, instr_byte, instruction);
  integer i, j;
  input rst;
  input [`NO_INSTR_BYTES-1:0] [`MEM_CELL_SIZE-1:0] instr_byte;
  input [`WORD_LEN-1:0] addr;
  output [`WORD_LEN-1:0] instruction;

  wire [$clog2(`INSTR_MEM_SIZE)-1:0] address = addr[$clog2(`INSTR_MEM_SIZE)-1:0];
  reg [0:`INSTR_MEM_SIZE-1] [`MEM_CELL_SIZE-1:0] instMem;

  always @ (*) begin
  	if (rst) begin
        for (i = 0; i < `NO_INSTR_BYTES; i = i + 1) begin
			for (j = 0; j < `MEM_CELL_SIZE; j = j + 1) begin	
				instMem[i][j] <= instr_byte[i][j];
			end	
		end	
    end
  end

  assign instruction = {instMem[address], instMem[address + 1], instMem[address + 2], instMem[address + 3]};
endmodule // insttructionMem
