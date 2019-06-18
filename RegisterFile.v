module RegisterFile#(parameter N = 1)(clk,ReadRegister1, ReadRegister2, WriteRegister, WriteData, RegWrite, ReadData1, ReadData2);
	input clk;
	input [4:0] ReadRegister1, ReadRegister2, WriteRegister;	
	input [31:0]WriteData;
	input RegWrite;
	output[31:0] ReadData1,ReadData2;
	reg [31:0] Mem [0:N-1];
		
	initial begin
		Mem[0] <= 32'd0;
		Mem[1] <= 32'd0;
		Mem[2] <= 32'd0;
		Mem[3] <= 32'b0;
		Mem[4] <= 32'b0;
		Mem[5] <= 32'b0;
		Mem[6] <= 32'b0;
		Mem[7] <= 32'b0;
		Mem[8] <= 32'b0;
		Mem[9] <= 32'b0;
		Mem[10] <= 32'b0;
		Mem[11] <= 32'b0;
		Mem[12] <= 32'b0;
		Mem[13] <= 32'b0;
		Mem[14] <= 32'b0;
		Mem[15] <= 32'b0;
		Mem[16] <= 32'b0;
		Mem[17] <= 32'b0;
		Mem[18] <= 32'b0;
		Mem[19] <= 32'b0;
		Mem[20] <= 32'b0;
		Mem[21] <= 32'b0;
		Mem[22] <= 32'b0;
		Mem[23] <= 32'b0;
		Mem[24] <= 32'b0;
		Mem[25] <= 32'b0;
		Mem[26] <= 32'b0;
		Mem[27] <= 32'b0;
		Mem[28] <= 32'b0;
		Mem[29] <= 32'b0;
		Mem[30] <= 32'b0;
		Mem[31] <= 32'b0;
	end
	always@(posedge clk) begin
		if(RegWrite == 1'b1)
			Mem[WriteRegister] <= WriteData;
	end
	assign#(1) ReadData1 = Mem[ReadRegister1];
	assign#(1) ReadData2 = Mem[ReadRegister2];
endmodule
