`include "defines.v"

module IFStage (clk, rst, brTaken, brOffset, freeze, PC, instr_byte, instruction);
  input clk, rst, brTaken, freeze;
  input [`NO_INSTR_BYTES-1:0] [`MEM_CELL_SIZE-1:0] instr_byte;
  input [`WORD_LEN-1:0] brOffset;
  output [`WORD_LEN-1:0] PC, instruction;

  wire [`WORD_LEN-1:0] adderIn1, adderOut, brOffserTimes4;

  mux #(.LENGTH(`WORD_LEN)) adderInput (
    .in1(32'd4),
    .in2(brOffserTimes4),
    .sel(brTaken),
    .out(adderIn1)
  );

  adder add4 (
    .in1(adderIn1),
    .in2(PC),
    .out(adderOut)
  );

  register PCReg (
    .clk(clk),
    .rst(rst),
    .writeEn(~freeze),
    .regIn(adderOut),
    .regOut(PC)
  );

  instructionMem instructions (
    .rst(rst),
    .addr(PC),
	.instr_byte(instr_byte),
    .instruction(instruction)
  );

  assign brOffserTimes4 = brOffset << 2;
endmodule // IFStage
