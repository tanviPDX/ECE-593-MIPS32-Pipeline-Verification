module memDefs;

reg [`MEM_CELL_SIZE-1:0] instMem [0:`INSTR_MEM_SIZE-1];
reg [`MEM_CELL_SIZE-1:0] dataMem [0:`DATA_MEM_SIZE-1];
reg [`WORD_LEN-1:0] regMem [0:`REG_FILE_SIZE-1];

endmodule