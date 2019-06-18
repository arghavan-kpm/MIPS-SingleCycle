module MIPS(clk,InstAdd,Inst,MemAdd,WriteData,MemRead,MemWrite,MemReadData);
	input clk;
	input[31:0] Inst,MemReadData;
	output[31:0] InstAdd,MemAdd,WriteData;
	output MemRead,MemWrite;
           /*   Controller Signals  */

	wire RegDst,RegWrite,MemtoReg,lui,loorhi,luiormf,ALUSrc,jal,branch,beqorne,jr,j;
	wire[3:0] ALUControl;
	wire[4:0] ReadRegister1, ReadRegister2, WriteRegister;
	wire[31:0]  ReadData1, ReadData2, RegData;

	Controller CU(Inst, clk, 
	RegDst, RegWrite, ALUSrc, MemRead, MemWrite, MemtoReg, branch, loorhi, j, jr, jal, lui, beqorne,
	luiormf, ALUControl);
/*
		DataPath(Inst,InstAdd,
		ReadReg1,ReadReg2,ReadData1,ReadData2,RegDst,WriteReg,RegData,
		jal,branch,beqorne,jr,j,
		ALUSrc,ALUControl,
		MemAdd,MemData,MemReadData,MemtoReg,
		lui,loorhi,luiormf);
*/
	DataPath DP (clk,Inst,InstAdd,
		    ReadRegister1, ReadRegister2, ReadData1, ReadData2, RegDst, WriteRegister, RegData,
		    jal,branch,beqorne,jr,j,		//controller signals
	      	    ALUSrc,ALUControl,			//controller signals
		    MemAdd,WriteData,MemReadData,MemtoReg, 	// Mem to Reg : controller signal  : Added
		    lui,loorhi,luiormf);	//controller signals  : Added
									/*   controller signal : Added */
	RegisterFile#(32) RF(clk,ReadRegister1, ReadRegister2, WriteRegister, RegData, RegWrite, ReadData1, ReadData2);	
endmodule
