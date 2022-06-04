class scoreboard;
    
    reg [`MEM_CELL_SIZE-1:0] instMem [0:`INSTR_MEM_SIZE-1];
    reg [`MEM_CELL_SIZE-1:0] dataMem [0:`DATA_MEM_SIZE-1];
    reg [`WORD_LEN-1:0] regMem [0:`REG_FILE_SIZE-1];

    mailbox scb_mbx;
    virtual mips32_bfm v2bfm;

    task execute();

        forever begin
            transaction trans;
            scb_mbx.get(trans);

            case (trans.opCode)
                6'b000000: begin
                    
                end

                6'b000001: begin
                    regMem[trans.rd] = v2bfm.regMem[trans.rs1] + v2bfm.regMem[trans.rs2_imm];
                end

                6'b000011: begin
                    regMem[trans.rd] = v2bfm.regMem[trans.rs1] - v2bfm.regMem[trans.rs2_imm];
                end

                6'b000101: begin
                    regMem[trans.rd] = v2bfm.regMem[trans.rs1] & v2bfm.regMem[trans.rs2_imm];
                end

                6'b000110: begin
                    regMem[trans.rd] = v2bfm.regMem[trans.rs1] | v2bfm.regMem[trans.rs2_imm];
                end    

                6'b000111: begin
                    regMem[trans.rd] = ~(v2bfm.regMem[trans.rs1] | v2bfm.regMem[trans.rs2_imm]);
                end

                6'b001000: begin
                    regMem[trans.rd] = v2bfm.regMem[trans.rs1] ^ v2bfm.regMem[trans.rs2_imm];
                end

                6'b001001: begin
                    regMem[trans.rd] = v2bfm.regMem[trans.rs1] <<< v2bfm.regMem[trans.rs2_imm];
                end

                6'b001010: begin
                    regMem[trans.rd] = v2bfm.regMem[trans.rs1] << v2bfm.regMem[trans.rs2_imm];
                end

                6'b001011: begin
                    regMem[trans.rd] = v2bfm.regMem[trans.rs1] >>> v2bfm.regMem[trans.rs2_imm];
                end

                6'b001100: begin
                    regMem[trans.rd] = v2bfm.regMem[trans.rs1] >> v2bfm.regMem[trans.rs2_imm];
                end

                6'b100000: begin
                    if (trans.rs2_imm[4] == 0)
                        regMem[trans.rd] = v2bfm.regMem[trans.rs1] + {{16{'0}}, {trans.rs2_imm, trans.immediate}};
                    else
                        regMem[trans.rd] = v2bfm.regMem[trans.rs1] + {{16{'1}}, {trans.rs2_imm, trans.immediate}};
                end

                6'b100001: begin
                    if (trans.rs2_imm[4] == 0)
                        regMem[trans.rd] = v2bfm.regMem[trans.rs1] - {{16{'0}}, {trans.rs2_imm, trans.immediate}};
                    else
                        regMem[trans.rd] = v2bfm.regMem[trans.rs1] - {{16{'1}}, {trans.rs2_imm, trans.immediate}};
                end

                6'b100100: begin
                    if (trans.rs2_imm[4] == 0)
                        regMem[trans.rd] = v2bfm.dataMem[v2bfm.regMem[trans.rs1] + {{16{'0}}, {trans.rs2_imm, trans.immediate}}];
                    else
                        regMem[trans.rd] = v2bfm.dataMem[v2bfm.regMem[trans.rs1] + {{16{'1}}, {trans.rs2_imm, trans.immediate}}];
                end

                6'b100101: begin
                    if (trans.rs2_imm[4] == 0)
                        dataMem[v2bfm.regMem[trans.rs1] + {{16{'0}}, {trans.rs2_imm, trans.immediate}}] = v2bfm.regMem[trans.rd];
                    else
                        dataMem[v2bfm.regMem[trans.rs1] + {{16{'1}}, {trans.rs2_imm, trans.immediate}}] = v2bfm.regMem[trans.rd];
                end

                6'b101000: begin
                    
                end

                6'b101001: begin
                    
                end

                6'b101010: begin
                    
                end

                default: begin

                end
            endcase

            foreach (regMem[i]) begin
                if(regMem[i] === v2bfm.regMem[i])
                    $display("[%0t] Scoreboard for Reg Memory PASS.", $time);
                else
                    $display("[%0t] Scoreboard for Reg Memory FAIL. value: %h", $time, regMem[i]);
            end

            foreach (dataMem[i]) begin
                if(dataMem[i] === v2bfm.dataMem[i])
                    $display("[%0t] Scoreboard for Data Memory PASS.", $time);
                else
                    $display("[%0t] Scoreboard for Data Memory FAIL. value: %h", $time, dataMem[i]);
            end
        end    
    endtask

endclass