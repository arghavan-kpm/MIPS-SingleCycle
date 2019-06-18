module Controller(Instruction, clk, 
	RegDst, RegWrite, AluSrc, MemRead, MemWrite, MemToReg, branch, LoOrHi, j, jr, jal, Lui, beqOrbne,
	LuiOrMf, AluControl);

	input [31:0] Instruction;
	input clk;

	output RegDst, RegWrite, AluSrc, MemRead, MemWrite, MemToReg, branch, LoOrHi, j, jr, jal, Lui, beqOrbne,
	LuiOrMf;
	output reg [3:0] AluControl;
	
	reg [13:0] OutSignals;

	initial begin
		OutSignals<=14'b0;
		AluControl <= 4'b0;
	end

	always@(posedge clk,Instruction)begin
		#1;
		case(Instruction[31:26])
			6'b001000:begin//addi
				OutSignals<=14'b01100000000000;
				AluControl <= 4'b0;
			end
			6'b100000:begin//add
				OutSignals<=14'b11000000000000;
				AluControl <= 4'b0;
			end
			6'b100010:begin//sub
				OutSignals<=14'b11000000000000;
				AluControl <= 4'b0010;
			end
			6'b100100:begin//and
				OutSignals<=14'b11000000000000;
				AluControl <= 4'b0100;
			end
			6'b100101:begin//or
				OutSignals<=14'b11000000000000;
				AluControl <= 4'b0101;
			end
			6'b100110:begin//xor
				OutSignals<=14'b11000000000000;
				AluControl <= 4'b0110;
			end
			6'b101010:begin//slt

				OutSignals<=14'b11000000000000;
				AluControl <= 4'b0111;
			end
			6'b001010:begin//slti
				OutSignals<=14'b01100000000000;
				AluControl <= 4'b0111;
			end
			6'b011000:begin//mult
				OutSignals<=14'b0;
				AluControl <= 4'b0001;
			end
			6'b011010:begin//div
				OutSignals<=14'b0;
				AluControl <= 4'b0011;
			end
			6'b100011:begin//lw
				OutSignals<=14'b01110100000000;
				AluControl <= 4'b0;
			end
			6'b101011:begin//sw
				OutSignals<=14'b00101000000000;
				AluControl <= 4'b0;
			end
			6'b010000:begin//mflo
				OutSignals<=14'b01000000000001;
				AluControl <= 4'b1001;
			end
			6'b010001:begin//mfhi
				OutSignals<=14'b01000001000001;
				AluControl <= 4'b1001;
			end
			6'b000010:begin//j
				OutSignals<=14'b00000000100000;
				AluControl <= 4'b0;
			end
			6'b000011:begin//jal
				OutSignals<=14'b01000000101000;
				AluControl <= 4'b0;
			end
			6'b000111:begin//jr
				OutSignals<=14'b00000000110000;
				AluControl <= 4'b0;
			end
			6'b000100:begin//beq
				OutSignals<=14'b00000010000010;
				AluControl <= 4'b1000;
			end
			6'b000101:begin//bne
				OutSignals<=14'b00000010000000;
				AluControl <= 4'b1000;
			end
			6'b001111:begin//Lui
				OutSignals<=14'b01000000000101;
				AluControl <= 4'b0;
			end
			default:begin

				OutSignals<=14'b0;
				AluControl <= 4'b0;
			end
		endcase
	end
	assign {RegDst,RegWrite,AluSrc,MemRead,MemWrite,MemToReg,branch,LoOrHi,j,jr,jal,Lui,beqOrbne,LuiOrMf} = OutSignals;
endmodule


