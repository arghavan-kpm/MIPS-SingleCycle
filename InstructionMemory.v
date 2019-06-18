module InstructionMemory #(parameter N = 1)( Address, Instruction );
	input [31:0] Address;
	output [31:0] Instruction;	
	reg [31:0] Mem [0:N-1];
	reg [31:0] address;
	integer               data_file    ; // file handler
	integer               scan_file    ; // file handler
	integer 	      index;
	reg[31:0] captured_data;
	`define NULL 0    
	`define FILENAME "inst_set.txt"
	initial begin
		//Mem[0] <= 32'b10101000000000010001000000000000;
	  data_file = $fopen(`FILENAME, "r");	
	  if (data_file == `NULL) begin
	    $display("data_file handle was NULL");
	    $finish;
	  end
	  for (index=0; index < N; index = index + 1)
	 	scan_file = $fscanf(data_file, "%b\n", Mem[index]);
	end
	always@(Address) begin
		#1
		address <= Address >> 2;
	end
	assign Instruction = Mem[address];
endmodule
