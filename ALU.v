module ALU( A, B, ALU, hi, lo, zero);
	reg [63:0] tmp;
	input [31:0] A, B;
	input [3:0] ALU;
	output reg [31:0] hi, lo;
	output reg zero;
	reg[31:0] LO,HI;
	initial begin
		zero <= 0;
	end
	always@(A, B, ALU)begin
		#1;
		case(ALU)
			4'b0000 : begin 
				#1;

				lo <= $signed(A) + $signed(B);
				hi <= 32'b0;
				zero <= ( {hi, lo}==64'b0 )?1:0;
			end
			4'b0001 : begin 
				#1;
				tmp <= $signed(A)*$signed(B);
				#1;
				LO <= tmp[31:0];
				HI <= tmp[63:32];
				#1;
				zero <= ({hi, lo}==64'b0)?1:0;
				lo <= LO;
				hi <= HI;
			end // 3'b001 :
			4'b0010 : begin
				#1;
				lo <= $signed(A) - $signed(B);
				hi <= 32'b0;
				#1;
				zero <= ({hi, lo}==64'b0)?1:0;
			end
			4'b0011 : begin
				#1;
				LO <= $signed(A) / $signed(B);
				HI <= $signed(A) % $signed(B);
				#1;
				zero <= ({HI, LO}==64'b0)?1:0;
				lo <= LO;
				hi <= HI;
			end // 3'b011 :
			4'b0100 : begin
				#1;
				lo <= $signed(A) & $signed(B);
				hi <= 32'b0;
				#1;
				zero <= ({hi, lo}==64'b0)?1:0;
			end
			4'b0101 : begin
				#1;
				lo <= $signed(A) | $signed(B);
				hi <= 32'b0;
				#1;
				zero <= ({hi, lo}==64'b0)?1:0;
			end
			4'b0110 : begin 
				#1;
				lo <= $signed(A) ^ $signed(B);
				hi <= 32'b0;
				#1;
				zero <= ({hi, lo}==64'b0)?1:0;
			end
			4'b0111 : begin 
				#1;
				hi <= 32'b0;
				lo <= ($signed(A) < $signed(B))?32'b1 : 32'b0;
				#1;
				zero <= ({hi, lo}==64'b0)?1:0; 
			end
			4'b1000 : begin	
				zero <= (A == B)?1:0;
			end
			4'b1001: begin//	mfhi
				lo <= LO;
				hi <= HI;
			end
			default : {hi, lo, zero} <= 65'b0;
		endcase
	end // always@(A, B, ALU)
endmodule



