//top is made becoz testbench will communicatem to this file only, ...its wrapper module

// we are mainly inplementing LOAD INSTRUCTION in this lecture 
`ifndef SINGLE_CYCLE_TOP_V
`define SINGLE_CYCLE_TOP_V

`include "P_c.v"
`include "Instruction_Memory.v"
`include "Register_file.v"
`include "Sign_Extend.v"
`include "ALU.V"
`include "Control_Unit_Top.v"
`include "Data_Mem.v"
`include "PC_Adder.v"
`include "Mux.v"


module Single_Cycle_Top(clk,rst);
input clk, rst;
wire [31:0] PC_Top , SrcB, RD_Instr, RD1_Top, RD2_Top,IMM_Ext_Top, ALUResult, ReadData, PCPlus4, Result  ;
wire [2:0] ALUControl_Top;
wire RegWrite, MemWrite, ALUSrc, ResultSrc;
wire [1:0] ImmSrc;


P_C PC(.clk(clk),                 //understand that pc_module is the name of the module in
                                  // the P_c.v file. and we can give any name to this
              .rst(rst),                //instantiated module....just as in simple instantiation
              .PC(PC_Top),
              .PC_NEXT(PCPlus4)
              );

PC_Adder PC_Adder(
                  .a(PC_Top),
                  .b(32'd4),
                  .c(PCPlus4)

                );

Instruction_Memory Instruction_Memory(.rst(rst),
                                         .A(PC_Top), 
                                         .RD(RD_Instr)
                                        );


Register_file Register_file(
                            .clk(clk),
                            .rst(rst),
                            .WE3(RegWrite),
                            .WD3(Result),
                            .A1(RD_Instr[19:15]),
                            .A2(RD_Instr[24:20]),
                            .A3(RD_Instr[11:7]),
                            .RD1(RD1_Top),
                            .RD2(RD2_Top) 
                            );

Mux Mux_Register_tO_ALU(
                        .a(RD2_Top),
                        .b(IMM_Ext_Top),
                        .s(ALUSrc),
                        .c(SrcB)
                        );

Sign_Extend  Sign_Extend(
                            .In(RD_Instr),
                            .ImmSrc(ImmSrc[0]),
                            .Imm_Ext(IMM_Ext_Top)
                        );


ALU ALU(
         .A(RD1_Top),
         .B(SrcB),
         .ALUControl( ALUControl_Top ),
          .Result(ALUResult),
           .Z(),
           .N(),
           .V(),
           .C()
         );

Control_Unit_Top Control_Unit_Top(
                                .Op(RD_Instr[6:0]),
                                .RegWrite(RegWrite),
                                .ImmSrc(ImmSrc),
                                .ALUSrc(ALUSrc),
                                .MemWrite(MemWrite),
                                .ResultSrc(ResultSrc),
                                .Branch(),
                                .funct3( RD_Instr[14:12] ),
                                .funct7(),
                                .ALUControl( ALUControl_Top )
                                    );

Data_Memory Data_Memory( .clk(clk),
                            .rst(rst),
                            .WE(MemWrite),
                            .WD(RD2_Top),
                            .A(ALUResult),
                            .RD(ReadData)
                            );

Mux Mux_DataMemeory_to_RegFile(
                        .a(ALUResult),
                        .b(ReadData),
                        .s(ResultSrc),
                        .c(Result)
                        );


endmodule

`endif