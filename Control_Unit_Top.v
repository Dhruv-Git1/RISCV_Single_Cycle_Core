  `ifndef CONTROL_UNIT_TOP_V
`define CONTROL_UNIT_TOP_V

`include "ALU_Decoder.v"
`include "Main_Decoder.v"

module Control_Unit_Top( Op, RegWrite, ImmSrc, ALUSrc, MemWrite,ResultSrc,Branch,funct3,funct7,ALUControl );

input [6:0] Op, funct7;
input [2:0] funct3;
output ResultSrc, MemWrite, ALUSrc, RegWrite,Branch;
output [1:0] ImmSrc;

output [2:0] ALUControl;    //so see that when something is output + it is being used as input in the same file, then
                        // make it wire. and the outputs which are not getting used anywhere, then make them simple output
wire zero;
wire [1:0]  ALUop;       // IMPORTANT-- this is not declared in the ports..since there is no
                        // need to do so, just declare as wire
//wire [2:0] ALUControl;
//assign zero= branch & Zero;
main_decoder main_decoder(
                        .op(Op),
                    //     .zero(zero),
                          .RegWrite(RegWrite),
                           .MemWrite(MemWrite),
                            .ResultSrc(ResultSrc),
                             .ALUSrc(ALUSrc),
                              .ImmSrc(ImmSrc),
                             .ALUop(ALUop),
                               .branch(Branch)
                             //   .PCSrc(PCSrc)
                        );

alu_decoder ALU_Decoder(
                        .ALUOp(ALUop),
                         .op(Op),
                          .funct3(funct3),
                           .funct7(funct7),
                            .ALUControl(ALUControl)
                            );

endmodule

`endif