module Reg(clk,A,B);
	input clk;
	input[31:0] A;
	output [31:0] B;
	reg[31:0] data;
	initial begin
		data <= 0;
	end
	always @(posedge clk) begin
		#1
		data <= A;
	end
	assign B = data;
endmodule
