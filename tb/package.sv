package mips32;
    typedef enum logic [5:0] 
	{
		NOP   = 6'b000000, 
		ADD   = 6'b000001, 
		SUB   = 6'b000011, 
		AND   = 6'b000101, 
		OR    = 6'b000110, 
		NOR   = 6'b000111, 
		XOR   = 6'b001000, 
		SLA   = 6'b001001, 
		SLL   = 6'b001010, 
		SRA   = 6'b001011,
		SRL   = 6'b001100,
		ADDI  = 6'b100000, 
		SUBI  = 6'b100001, 
		LD    = 6'b100100, 
		ST    = 6'b100101, 
		BEZ   = 6'b101000, 
		BNE   = 6'b101001, 
		JMP   = 6'b101010 
	} opcode_t;
	
	typedef enum logic [3:0] 
	{
		EX_ADD          = 4'b0000,
		EX_SUB          = 4'b0010,
		EX_AND          = 4'b0100,
		EX_OR           = 4'b0101,
		EX_NOR          = 4'b0110,
		EX_XOR          = 4'b0111,
		EX_SLA          = 4'b1000,
		EX_SLL          = 4'b1001,
		EX_SRA          = 4'b1010,
		EX_SRL          = 4'b1011,
		EX_NO_OPERATION = 4'b1111
	} Execute; 
	
	`include "transaction.sv"
	`include "driver.sv"
	`include "generator.sv"
	`include "scoreboard.sv"
	`include "coverage.sv"
	`include "environment.sv"

endpackage
