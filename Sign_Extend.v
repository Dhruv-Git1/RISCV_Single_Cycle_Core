`ifndef SIGN_EXTEND_V
`define SIGN_EXTEND_V

module Sign_Extend(In,Imm_Ext, ImmSrc);
    input [31:0] In;
    input ImmSrc;
    output [31:0] Imm_Ext;

  //  assign Imm_Ext = (In[31])? { {20{1'b1} }, In[31:20] } :  { {20{1'b0} }, In[31:20] } ;
    // this was used when we only had load 
    //this is when we are including store also along with load

//ImmSrc 1 means that this is a store statement. 
    assign Imm_Ext = (ImmSrc == 1'b1) ? ({{20{In[31]}}, In[31:25], In[11:7]}):
                                            ({{20{In[31]}}, In[31:20]});

endmodule 
`endif

