module Testbench;
	reg clk;
	wire [31:0] MemAdd,MemReadData,WriteData,Inst,InstAdd;
	wire MemRead,Memwrite;

	MIPS mips(clk,InstAdd,Inst,MemAdd,WriteData,MemRead,MemWrite,MemReadData);
	`define InstructionCount 15   
	`define MemoryCount 20
	InstructionMemory#(`InstructionCount) IM(InstAdd,Inst);
	DataMemory#(`MemoryCount) DM(MemAdd, WriteData, MemRead, MemWrite , MemReadData ); 

	initial begin
		clk <= 0;
	end
	initial repeat(10000) begin
		#45
		clk <= ~clk;
	end

	initial begin
		#(160000)
		$stop;
	end
endmodule 
