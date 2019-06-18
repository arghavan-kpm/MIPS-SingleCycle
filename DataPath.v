module DataPath(clk,Inst,InstAdd,
		ReadReg1,ReadReg2,ReadData1,ReadData2,RegDst,WriteReg,RegData,
		jal,branch,beqorne,jr,j,
		ALUSrc,ALUControl,
		MemAdd,MemData,MemReadData,MemtoReg,
		lui,loorhi,luiormf);

	input[31:0] Inst,ReadData1,ReadData2,MemReadData;
	input[3:0] ALUControl;
	input RegDst,jal,ALUSrc,MemtoReg,lui,loorhi,branch,beqorne,jr,j,luiormf,clk;
	
	output[31:0] InstAdd,MemAdd,MemData,RegData;
	output [4:0] ReadReg1,ReadReg2,WriteReg;

	wire[31:0] jumpRegOrimm;
	wire[31:0] pcADD4,Extended,ALUB,ALUlo,ALUhi,lo,PC,LUIout,LO,newPC,toPC;
	wire[4:0] WReg,writeReg;
	wire ALUzero,PCSrc;

	Reg ProgramCounter(clk,(newPC),PC);

	assign pcADD4 = PC + 4;
	assign ReadReg1 = Inst[25:21];
	assign ReadReg2 = Inst[20:16];
	assign MemAdd = (ALUlo);
	assign MemData = ReadData2;
	assign InstAdd = PC;

	MUX#(1) mux1((branch&~ALUzero),(branch&ALUzero),beqorne,PCSrc);
	MUX#(5) mux2(Inst[20:16],Inst[15:11],RegDst,WReg);
	MUX#(5) mux3(WReg,5'd31,jal,writeReg);
	MUX#(5) mux4(writeReg,Inst[25:21],luiormf,WriteReg);
	MUX#(32) mux5(ReadData2,Extended,ALUSrc,ALUB);
	MUX#(32) mux6(ALUlo,MemReadData,MemtoReg,lo);
	MUX#(32) mux7(lo,({Inst[15:0],16'b0}),lui,LUIout);
	MUX#(32) mux8(LUIout,ALUhi,loorhi,LO);
	MUX#(32) mux9(LO,pcADD4,jal,RegData);
	MUX#(32) mux10(pcADD4,(pcADD4 + {Extended[29:0],2'b0}),PCSrc,toPC);
	MUX#(32) mux12(toPC,jumpRegOrimm,j,newPC);
	MUX#(32) mux11({Extended[29:0],2'b0},{ReadData1[29:0],2'b0},jr,jumpRegOrimm);

	SignExtend SE(Inst[15:0],Extended);
	// A, B, ALU, hi, lo, zero);
	ALU alu(ReadData1,ALUB,ALUControl,ALUhi,ALUlo,ALUzero);


endmodule
