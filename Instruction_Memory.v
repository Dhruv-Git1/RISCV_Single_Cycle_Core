`ifndef INSTRUCTION_MEMORY_V
`define INSTRUCTION_MEMORY_V

module Instruction_Memory(A, rst, RD);              //rst is not there in the documentation

    input [31:0] A;
    input rst;
    output [31:0] RD;
//we need to create memory
reg[31:0] Mem [1023:0]; //1024 registers of 32 bit 


assign RD= (rst==1'b0)?32'h00000000 : Mem[A[31:2]];  //IMPORTANT-- this 31:2 is important.If we do 31:0 it will be wrong. 
//if pc is 0-> mem[0], if pc = 4 -> mem[1] na islea done so.

initial begin
    
    $readmemh("memfile.hex",Mem);
end

/*
initial begin
    // Mem[0]=  32'hFFC4A303;
    // now for store
    // Mem[0]= 32'h0064A423;
    Mem[0]= 32'h0062E233;
end
*/
endmodule

`endif