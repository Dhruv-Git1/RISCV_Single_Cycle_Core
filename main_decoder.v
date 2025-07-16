`ifndef MAIN_DECODER_V
`define MAIN_DECODER_V

module main_decoder(op, branch, RegWrite,ALUop, MemWrite, ResultSrc, ALUSrc, ImmSrc );

// input zero;  this is not part of the main decoder
input [6:0] op;
output RegWrite, MemWrite,ResultSrc, ALUSrc,branch;
output [1:0] ImmSrc, ALUop;
//internal wires
//wire branch;

//      the 4 instructions we will be including are lw, sw, r type, beq !!

assign RegWrite= ((op==7'b0000011) | (op==7'b0110011))? 1'b1 : 1'b0;//we are including only 4 instruction, so very simple. 
                                                                    //If we add more instructions then we'll have to make this more complex
assign MemWrite= (op==7'b0100011)? 1'b1: 1'b0; //simply by seeing truth table

assign ResultSrc= (op== 7'b0000011)? 1'b1: 1'b0; //we are considering don't care as 0

assign ALUSrc= ((op==7'b0000011) | (op==7'b0100011))? 1'b1: 1'b0;

assign branch = (op==7'b1100011)? 1'b1 : 1'b0;
//now considering 2 bit signals

assign ImmSrc = (op==7'b0100011)? 2'b01 : (op==7'b1100011)? 2'b10: 2'b00;

assign ALUop=  (op==7'b0110011)? 2'b10 : (op==7'b1100011)? 2'b01: 2'b00;

//assign PCSrc= zero & branch;

endmodule
`endif