`timescale 1ns/1ns
`include "defines.v"

module testbench ();
  reg clk,rst, forwarding_EN;
  reg [`INSTR_WIDTH-1:0] instr_in;
  MIPS_Processor top_module (clk, rst, instr_in, forwarding_EN);

  initial begin
    clk=1;
    repeat(5000) #50 clk=~clk ;
  end

  initial begin
    rst = 1;
    forwarding_EN = 1;
		instr_in <= 32'h0A002080;
    @posedge(clk);
    instr_in <= 32'h00084004;
    @posedge(clk);
    instr_in <= 32'h0008600C;
    @posedge(clk);
    instr_in <= 32'h00188214;
    @posedge(clk);
    instr_in <= 32'h3402A084;
    @posedge(clk);
    rst = 0;
  end
endmodule // test
