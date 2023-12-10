/* address calculation is also carried out*/

module execute 
(
    input clk,

    // Control unit signals
    input wire MemtoReg_EX_in, // To WB stage
    input wire RegWrite_EX_in, // To WB stage

    input wire jump_EX_in,           // To MEM stage
    input wire branch_EX_in, // To MEM stage
    input wire MemWrite_EX_in,       // To MEM stage
    input wire MemRead_EX_in,        // To MEM stage

    input ALUSrc,
    input RegDst,
    input ALUOp,

    //input from decode stage
    input [31:0]NPC_in,
    input [31:0]a_EX_in,
    input [31:0]b_EX_in,
    input [31:0]signed_offset,

    // to forwarding unit
  input [4:0] rs_ID_EX_in, // rs from decode
  input [4:0] rt_ID_EX_in, // rt from decode

    input [4:0] rd1_EX_in,
    input [4:0] rd2_EX_in,

    // new mux2 and mux3 controls
    input [31:0] wb_out_EX_in,
    input [31:0] address_MEM_out_EX_in,
    input [1:0] forwardAE, forwardBE,

    
    // Outputs
    output wire MemtoReg_EX_out, // To WB stage
    output wire RegWrite_EX_out, // To WB stage

    output wire jump_EX_out,           // To MEM stage
    output wire branch_EX_out, // To MEM stage
    output wire MemWrite_EX_out,       // To MEM stage
    output wire MemRead_EX_out,        // To MEM stage

    
    output [31:0]branch_pc_EX_out,
    output zero_EX_out,
    output [31:0]alu_out,
    output [31:0]b_out,

    // to forwarding unit
    output [4:0] rs_ID_EX_out, // rs from decode
    output [4:0] rt_ID_EX_out, // rt from decode
    
    output [4:0] rd_EX_out

);


//control unit signals
assign MemtoReg_EX_out = MemtoReg_EX_in;
assign RegWrite_EX_out = RegWrite_EX_in;
assign branch_EX_out = branch_EX_in;
assign MemWrite_EX_out = MemWrite_EX_in;
assign MemRead_EX_out = MemRead_EX_in;



wire [31:0] word_offset;
wire [5:0] funct_in; // alu function
wire [5:0] funct_out;

assign funct_in = signed_offset[5:0];



left_2_shift shifter2
(
    .in(signed_offset),
    .out(word_offset)
);


adder branch_adder
(
    .src1(NPC_in),
    .src2(word_offset),
    .adder_out(branch_pc_EX_out)


);

supply0 gnd;

wire [31:0]mux2_out;

 mux_4to1_32bit mux2
(
  .sel(forwardAE),
  .i0(a_EX_in),
  .i1(wb_out_EX_in),
  .i2(address_MEM_out_EX_in),
  .i3(gnd),
  .out(mux2_out)
);
   

wire [31:0]mux3_out;
mux_4to1_32bit mux3
(
  .sel(forwardBE),
  .i0(b_EX_in),
  .i1(wb_out_EX_in),
  .i2(address_MEM_out_EX_in),
  .i3(gnd),
  .out(mux3_out)
);

wire [31:0]mux4_out;
mux_2to1_32bit mux4
(
    .select(ALUSrc),
    .in0(mux3_out),
    .in1(signed_offset),
    .out(mux4_out)

);



alu_control alu_controller 
(
    .funct(funct_in),
    .aluOp(ALUOp),
    .aluControlOutput(funct_out) // output to ALU
);

alu ALU1
 (  .op1(mux2_out),
    .op2(mux4_out),
    .alu_funct(alu_funct),
    .zero(zero_EX_out),
    .out(alu_out)
  );

mux_2to1_32bit mux5
(
    .select(RegDst),
    .in0(rd1_EX_in),
    .in1(rd2_EX_in),
    .out(rd_EX_out)

);


endmodule