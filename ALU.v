//hare krishna hare krishna 
//simplest ALU
`ifndef ALU_V 
`define ALU_V

module ALU(A,B,ALUControl, Result, Z,N,V,C);     //V means over flow
//declaring inputs
input [31:0] A,B;
input [2:0] ALUControl;
output  [31:0] Result;
output Z,N,V,C;

//declaring internal wires
wire [31:0] a_and_b, a_or_b, not_b;

wire  [31:0] mux_1, sum;

wire [31:0] mux_2;
wire [31:0] slt;    

wire cout;
//logic design
assign a_and_b= A & B;
assign a_or_b = A | B;
assign not_b= ~B;

assign mux_1= (ALUControl[0] == 1'b0)? B: not_b;
assign {cout,sum}=A + mux_1 + ALUControl[0];          //this contatination is done to include the

assign slt= {31'b0,sum[31]};

assign mux_2= (ALUControl[2:0] ==3'b000) ? sum:
                (ALUControl[2:0] ==3'b001) ? sum:
                (ALUControl[2:0] ==3'b010) ? a_and_b :
                (ALUControl[2:0]== 3'b011)? a_or_b:
                (ALUControl[2:0]== 3'b101)? slt: 32'h00000000;
                

assign Result= mux_2; 

assign Z= &(~Result);
assign N= Result [31];
assign C= cout & (~ALUControl[1]);
assign V= (~ALUControl[1]) & (A[31] ^ sum[31]) & (~(A[31]^ B[31]^ ALUControl[0])) ;

//zero extension


endmodule
`endif