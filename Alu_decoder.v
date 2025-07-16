`ifndef ALU_DECODER_V
`define ALU_DECODER_V

module alu_decoder(ALUOp, op, funct3, funct7, ALUControl);
// hare krishna harekrishna krishna krishna hare hare hare rama hara rama rama rama hare hare
    input[6:0] op, funct7;
    input [1:0] ALUOp;
    input [2:0] funct3;
    output [2:0] ALUControl;
    
    wire [1:0] concatenation;

    assign concatenation= {op[5], funct7[5]};

    assign ALUControl= (ALUOp==2'b00) ? 3'b000 :
                        (ALUOp==2'b01) ? 3'b001:
                        (ALUOp==2'b10 & funct3== 3'b010)? 3'b101:
                        (ALUOp==2'b10 & funct3== 3'b110)? 3'b011:
                        (ALUOp==2'b10 & funct3== 3'b111)? 3'b010:
                        (ALUOp==2'b10 & funct3== 3'b000 & concatenation==2'b11)? 3'b001: 
                          (ALUOp==2'b10 & funct3== 3'b000 & concatenation!=2'b11)? 3'b000:3'b000; 



endmodule
`endif


//all instructions are stored in instruction memory. this memory has different registers.
//all machine codes{of the instructions} are stored in these registers.
//we are making single cycle processor, 1 instruction complete in 1 cycle.
//so in each cycle one instruction gets out of the memory.
//lets see how this memory works, and is made.
//we talk to memory in language of instuctions. 