`timescale 1ns/1ns
`include "defines.v"

module testbench ();
  reg clk,rst, forwarding_EN;
  reg [`NO_INSTR_BYTES-1:0] [`MEM_CELL_SIZE-1:0] instr_byte;
  MIPS_Processor top_module (clk, rst, instr_byte, forwarding_EN);

  initial begin
    clk=1;
    repeat(5000) #50 clk=~clk ;
  end

  initial begin
    rst = 1;
    forwarding_EN = 1;
		instr_byte[0] <= 8'b10000000; //-- Addi	r1,r0,10
        instr_byte[1] <= 8'b00100000;
        instr_byte[2] <= 8'b00000000;
        instr_byte[3] <= 8'b00001010;

        instr_byte[4] <= 8'b00000100; //-- Add 	r2,r0,r1
        instr_byte[5] <= 8'b01000000;
        instr_byte[6] <= 8'b00001000;
        instr_byte[7] <= 8'b00000000;

        instr_byte[8] <= 8'b00001100; //-- sub	r3,r0,r1
        instr_byte[9] <= 8'b01100000;
        instr_byte[10] <= 8'b00001000;
        instr_byte[11] <= 8'b00000000;

        instr_byte[12] <= 8'b00010100; //-- And	r4,r2,r3
        instr_byte[13] <= 8'b10000010;
        instr_byte[14] <= 8'b00011000;
        instr_byte[15] <= 8'b00000000;

        instr_byte[16] <= 8'b10000100; //-- Subi	r5,r0,564
        instr_byte[17] <= 8'b10100000;
        instr_byte[18] <= 8'b00000010;
        instr_byte[19] <= 8'b00110100;

        instr_byte[20] <= 8'b00011000; //-- or	r5,r5,r3
        instr_byte[21] <= 8'b10100101;
        instr_byte[22] <= 8'b00011000;
        instr_byte[23] <= 8'b00000000;

        instr_byte[24] <= 8'b00011100; //-- nor 	r6,r5,r0
        instr_byte[25] <= 8'b11000101;
        instr_byte[26] <= 8'b00000000;
        instr_byte[27] <= 8'b00000000;

        instr_byte[28] <= 8'b00100000; //-- xor	r0,r5,r1
        instr_byte[29] <= 8'b00000101;
        instr_byte[30] <= 8'b00001000;
        instr_byte[31] <= 8'b00000000;

        instr_byte[32] <= 8'b00100000; //-- xor	r7,r5,r0
        instr_byte[33] <= 8'b11100101;
        instr_byte[34] <= 8'b00001000;
        instr_byte[35] <= 8'b00000000;

        instr_byte[36] <= 8'b00100100; //-- sla	r7,r4,r2
        instr_byte[37] <= 8'b11100100;
        instr_byte[38] <= 8'b00010000;
        instr_byte[39] <= 8'b00000000;

        instr_byte[40] <= 8'b00101001; //-- sll	r8,r3,r2
        instr_byte[41] <= 8'b00000011;
        instr_byte[42] <= 8'b00010000;
        instr_byte[43] <= 8'b00000000;

        instr_byte[44] <= 8'b00101101; //-- sra	r9,r6,r2
        instr_byte[45] <= 8'b00100110;
        instr_byte[46] <= 8'b00010000;
        instr_byte[47] <= 8'b00000000;

        instr_byte[48] <= 8'b00110001; //-- srl	r10,r6,r2
        instr_byte[49] <= 8'b01000110;
        instr_byte[50] <= 8'b00010000;
        instr_byte[51] <= 8'b00000000;

        instr_byte[52] <= 8'b10000000; //-- Addi 	r1,r0,1024
        instr_byte[53] <= 8'b00100000;
        instr_byte[54] <= 8'b00000100;
        instr_byte[55] <= 8'b00000000;

        instr_byte[56] <= 8'b10010100; //-- st	r2,r1,0
        instr_byte[57] <= 8'b01000001;
        instr_byte[58] <= 8'b00000000;
        instr_byte[59] <= 8'b00000000;

        instr_byte[60] <= 8'b10010001; //-- ld	r11,r1,0
        instr_byte[61] <= 8'b01100001;
        instr_byte[62] <= 8'b00000000;
        instr_byte[63] <= 8'b00000000;

        instr_byte[64] <= 8'b10010100; //-- st	r3,r1,4
        instr_byte[65] <= 8'b01100001;
        instr_byte[66] <= 8'b00000000;
        instr_byte[67] <= 8'b00000100;

        instr_byte[68] <= 8'b10010100; //-- st	r4,r1,8
        instr_byte[69] <= 8'b10000001;
        instr_byte[70] <= 8'b00000000;
        instr_byte[71] <= 8'b00001000;

        instr_byte[72] <= 8'b10010100; //-- st	r5,r1,12
        instr_byte[73] <= 8'b10100001;
        instr_byte[74] <= 8'b00000000;
        instr_byte[75] <= 8'b00001100;

        instr_byte[76] <= 8'b10010100; //-- st	r6,r1,16
        instr_byte[77] <= 8'b11000001;
        instr_byte[78] <= 8'b00000000;
        instr_byte[79] <= 8'b00010000;

        instr_byte[80] <= 8'b10010100; //-- st	r7,r1,20
        instr_byte[81] <= 8'b11100001;
        instr_byte[82] <= 8'b00000000;
        instr_byte[83] <= 8'b00010100;

        instr_byte[84] <= 8'b10010101; //-- st	r8,r1,24
        instr_byte[85] <= 8'b00000001;
        instr_byte[86] <= 8'b00000000;
        instr_byte[87] <= 8'b00011000;

        instr_byte[88] <= 8'b10010101; //-- st	r9,r1,28
        instr_byte[89] <= 8'b00100001;
        instr_byte[90] <= 8'b00000000;
        instr_byte[91] <= 8'b00011100;

        instr_byte[92] <= 8'b10010101; //-- st	r10,r1,32
        instr_byte[93] <= 8'b01000001;
        instr_byte[94] <= 8'b00000000;
        instr_byte[95] <= 8'b00100000;

        instr_byte[96] <= 8'b10010101; //-- st	r11,r1,36
        instr_byte[97] <= 8'b01100001;
        instr_byte[98] <= 8'b00000000;
        instr_byte[99] <= 8'b00100100;

        instr_byte[100] <= 8'b10000000; //-- Addi 	r1,r0,3
        instr_byte[101] <= 8'b00100000;
        instr_byte[102] <= 8'b00000000;
        instr_byte[103] <= 8'b00000011;

        instr_byte[104] <= 8'b10000000; //-- Addi	r4,r0,1024
        instr_byte[105] <= 8'b10000000;
        instr_byte[106] <= 8'b00000100;
        instr_byte[107] <= 8'b00000000;

        instr_byte[108] <= 8'b10000000; //-- Addi 	r2,r0,0
        instr_byte[109] <= 8'b01000000;
        instr_byte[110] <= 8'b00000000;
        instr_byte[111] <= 8'b00000000;

        instr_byte[112] <= 8'b10000000; //-- Addi 	r3,r0,1
        instr_byte[113] <= 8'b01100000;
        instr_byte[114] <= 8'b00000000;
        instr_byte[115] <= 8'b00000001;

        instr_byte[116] <= 8'b10000001; //-- Addi 	r9,r0,2
        instr_byte[117] <= 8'b00100000;
        instr_byte[118] <= 8'b00000000;
        instr_byte[119] <= 8'b00000010;

        instr_byte[120] <= 8'b00101001; //-- sll	r8,r3,r9
        instr_byte[121] <= 8'b00000011;
        instr_byte[122] <= 8'b01001000;
        instr_byte[123] <= 8'b00000000;

        instr_byte[124] <= 8'b00000101; //-- Add 	r8,r4,r8
        instr_byte[125] <= 8'b00000100;
        instr_byte[126] <= 8'b01000000;
        instr_byte[127] <= 8'b00000000;

        instr_byte[128] <= 8'b10010000; //-- ld	r5,r8,0
        instr_byte[129] <= 8'b10101000;
        instr_byte[130] <= 8'b00000000;
        instr_byte[131] <= 8'b00000000;

        instr_byte[132] <= 8'b10010000; //-- ld	r6,r8,-4
        instr_byte[133] <= 8'b11001000;
        instr_byte[134] <= 8'b11111111;
        instr_byte[135] <= 8'b11111100;

        instr_byte[136] <= 8'b00001101; //-- sub 	r9,r5,r6
        instr_byte[137] <= 8'b00100101;
        instr_byte[138] <= 8'b00110000;
        instr_byte[139] <= 8'b00000000;

        instr_byte[140] <= 8'b10000001; //-- Addi 	r10,r0,0x8000
        instr_byte[141] <= 8'b01000000;
        instr_byte[142] <= 8'b10000000;
        instr_byte[143] <= 8'b00000000;

        instr_byte[144] <= 8'b10000001; //-- Addi	r11,r0,16
        instr_byte[145] <= 8'b01100000;
        instr_byte[146] <= 8'b00000000;
        instr_byte[147] <= 8'b00010000;

        instr_byte[148] <= 8'b00101001; //-- sll	r10,r10,r11
        instr_byte[149] <= 8'b01001010;
        instr_byte[150] <= 8'b01011000;
        instr_byte[151] <= 8'b00000000;

        instr_byte[152] <= 8'b00010101; //-- And 	r9,r9,r10
        instr_byte[153] <= 8'b00101001;
        instr_byte[154] <= 8'b01010000;
        instr_byte[155] <= 8'b00000000;

        instr_byte[156] <= 8'b10100000; //-- Bez	r9,2
        instr_byte[157] <= 8'b00001001;
        instr_byte[158] <= 8'b00000000;
        instr_byte[159] <= 8'b00000010;

        instr_byte[160] <= 8'b10010100; //-- st	r5,r8,-4
        instr_byte[161] <= 8'b10101000;
        instr_byte[162] <= 8'b11111111;
        instr_byte[163] <= 8'b11111100;

        instr_byte[164] <= 8'b10010100; //-- st	r6,r8,0
        instr_byte[165] <= 8'b11001000;
        instr_byte[166] <= 8'b00000000;
        instr_byte[167] <= 8'b00000000;

        instr_byte[168] <= 8'b10000000; //-- Addi 	r3,r3,1
        instr_byte[169] <= 8'b01100011;
        instr_byte[170] <= 8'b00000000;
        instr_byte[171] <= 8'b00000001;

        instr_byte[172] <= 8'b10100100; //-- BNE	r3,r1,-15
        instr_byte[173] <= 8'b01100001;
        instr_byte[174] <= 8'b11111111;
        instr_byte[175] <= 8'b11110001;

        instr_byte[176] <= 8'b10000000; //-- Addi 	r2,r2,1
        instr_byte[177] <= 8'b01000010;
        instr_byte[178] <= 8'b00000000;
        instr_byte[179] <= 8'b00000001;

        instr_byte[180] <= 8'b10100100; //-- BNE	r2,r1,-18
        instr_byte[181] <= 8'b01000001;
        instr_byte[182] <= 8'b11111111;
        instr_byte[183] <= 8'b11101110;

        instr_byte[184] <= 8'b10000000; //-- Addi 	r1,r0,1024
        instr_byte[185] <= 8'b00100000;
        instr_byte[186] <= 8'b00000100;
        instr_byte[187] <= 8'b00000000;

        instr_byte[188] <= 8'b10010000; //-- ld	r2,r1,0
        instr_byte[189] <= 8'b01000001;
        instr_byte[190] <= 8'b00000000;
        instr_byte[191] <= 8'b00000000;

        instr_byte[192] <= 8'b10010000; //-- ld	r3,r1,4
        instr_byte[193] <= 8'b01100001;
        instr_byte[194] <= 8'b00000000;
        instr_byte[195] <= 8'b00000100;

        instr_byte[196] <= 8'b10010000; //-- ld	r4,r1,8
        instr_byte[197] <= 8'b10000001;
        instr_byte[198] <= 8'b00000000;
        instr_byte[199] <= 8'b00001000;

        instr_byte[200] <= 8'b10010000; //-- ld	r5,r1,12
        instr_byte[201] <= 8'b10100001;
        instr_byte[202] <= 8'b00000000;
        instr_byte[203] <= 8'b00001100;

        instr_byte[204] <= 8'b10010000; //-- ld	r6,r1,16
        instr_byte[205] <= 8'b11000001;
        instr_byte[206] <= 8'b00000000;
        instr_byte[207] <= 8'b00010000;

        instr_byte[208] <= 8'b10010000; //-- ld	r7,r1,20
        instr_byte[209] <= 8'b11100001;
        instr_byte[210] <= 8'b00000000;
        instr_byte[211] <= 8'b00010100;

        instr_byte[212] <= 8'b10010001; //-- ld	r8,r1,24
        instr_byte[213] <= 8'b00000001;
        instr_byte[214] <= 8'b00000000;
        instr_byte[215] <= 8'b00011000;

        instr_byte[216] <= 8'b10010001; //-- ld	r9,r1,28
        instr_byte[217] <= 8'b00100001;
        instr_byte[218] <= 8'b00000000;
        instr_byte[219] <= 8'b00011100;

        instr_byte[220] <= 8'b10010001; //-- ld	r10,r1,32
        instr_byte[221] <= 8'b01000001;
        instr_byte[222] <= 8'b00000000;
        instr_byte[223] <= 8'b00100000;

        instr_byte[224] <= 8'b10010001; //-- ld	r11,r1,36
        instr_byte[225] <= 8'b01100001;
        instr_byte[226] <= 8'b00000000;
        instr_byte[227] <= 8'b00100100;

        instr_byte[228] <= 8'b10101000; //-- JMP 	-1
        instr_byte[229] <= 8'b00000000;
        instr_byte[230] <= 8'b11111111;
        instr_byte[231] <= 8'b11111111;

        instr_byte[232] <= 8'b00000000; //-- NOPE
        instr_byte[233] <= 8'b00000000;
        instr_byte[234] <= 8'b00000000;
        instr_byte[235] <= 8'b00000000;

    #100
    rst = 0;
  end
endmodule // test
