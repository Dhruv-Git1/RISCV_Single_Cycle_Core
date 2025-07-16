`ifndef P_C_V
`define P_C_V

module P_C(PC_NEXT, PC, rst, clk);            //again here is rst

input [31:0] PC_NEXT;
input clk,rst;

output reg [31:0]PC;

always@(posedge clk )
begin
if(rst == 1'b0)    PC<= 32'h00000000; //the enable is active low- this is ingeneral for all. we have seen this in comparch also 

else PC<= PC_NEXT;


end

endmodule

`endif
