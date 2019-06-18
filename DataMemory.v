module DataMemory#(parameter N = 1)(Address, WriteData, MemRead, MemWrite , ReadData );
	input [31:0] Address , WriteData;
	input MemRead , MemWrite;
	output reg [31:0] ReadData;
	reg [31:0] Mem [0 : N-1];
	integer               data_file    ; // file handler
	integer               scan_file    ; // file handler
	integer 	      index;
	reg[31:0] captured_data;
	`define NULL 0    
	`define FILENAME "data_set.txt"
	initial begin 
	  data_file = $fopen(`FILENAME, "r");	
	  if (data_file == `NULL) begin
	    $display("data_file handle was NULL");
	    $finish;
	  end
	  for (index=0; index < N; index = index + 1)
	 	scan_file = $fscanf(data_file, "%d\n", Mem[index]);
	end
	always @(Address, WriteData, MemRead, MemWrite) begin
		#5
		case( {MemRead,MemWrite } ) 
			2'b10: 	ReadData <= Mem[Address >> 2];
			2'b01:  Mem[Address >> 2] <= WriteData;
			default:   ReadData <= 32'b0;
		endcase
	end	
endmodule
