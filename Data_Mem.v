`ifndef DATA_MEM_V
`define DATA_MEM_V

module Data_Memory(A,rst, WD, clk, WE, RD);
//rst is not used in the documentation, and so we have not used here.

input [31:0] A,WD;
input clk, WE, rst;

output [31:0] RD;

reg [31:0] Data_Mem[1023:0];          //  1024 lines of 32 bit storage

assign RD= ( WE == 1'b0)? Data_Mem[A] : 32'h00000000; // read  is Asynchronous here 

//write 
always@(posedge clk)
begin
        if(WE)
        begin
            Data_Mem[A] <= WD;
        end

end


initial begin
Data_Mem[28]= 32'h00000000;
end


endmodule

`endif