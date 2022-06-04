`include "defines.v"
class transaction;
    rand bit [5:0] opCode;
    rand bit [4:0] rd;
    rand bit [4:0] rs1;
    rand bit [4:0] rs2_imm;
    rand bit [10:0] immediate;

	bit [`INSTR_WIDTH-1:0] instr_in;
	
constraint opcode {  
                opCode inside {0, 1, 3, 5, 6, 7, 8, 9, 10, 11, 12, 32, 33, 36, 37, 40, 41, 42};	  
}

constraint imm_field {
                    if (opCode > 36)
				    	{rs2_imm, immediate[10:8]} == 8'b0; 
}

constraint no_op {
                if (opCode == 0)
                { rd, rs1, rs2_imm, immediate } == '0;
}

constraint branch_eq {  
                if (opCode == 40)
                rd == '0;
}
endclass