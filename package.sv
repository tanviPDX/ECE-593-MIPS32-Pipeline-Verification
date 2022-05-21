package mips32;
    typedef enum logic [5:0] 
	{
		NOP =6'b000000, 
		ADD =6'b000001, 
		SUB =6'b000011, 
		AND =6'b000101, 
		OR =6'b000110, 
		NOR =6'b000111, 
		XOR =6'b001000, 
		SLA =6'b001001, 
		SLL =6'b001011, 
		SRA =6'b001100, 
		ADDI =6'b100000, 
		SUBI =6'b100001, 
		LD =6'b100100, 
		ST =6'b100101, 
		BEZ =6'b101000, 
		BNE =6'b101001, 
		JMP =6'b101010 
	} opcode_t;
endpackage
