module fetch 
(
    input clk,
    input rst,

    // control unit input
    input PCSrc,
    input jump,

    input pc_en,

    // from memory access stage
    input [31:0]branch_pc, 

    output [31:0]pc_next,  // pc to next stage
    output [31:0] instruction
    
);
  
  wire [31:0]pc_mux1_out;
  wire [31:0]pc_in;  // input to pc
  wire [31:0]w_pc_out; 
  wire [31:0]w_pc_adder_out;

  mux_2to1_32bit pc_mux1
(
    .select(PCSrc),
    .in0(w_pc_adder_out ),
    .in1(branch_pc),
    .out(pc_mux1_out)

);

program_counter pc
    ( 
        .pc_in(pc_in),
        .pc_clk(clk),
        .pc_rst(rst),
        .pc_en(pc_en),
        .pc_out(w_pc_out)

    );

adder pc_adder
(
  	.src1(w_pc_out),  // Input from pc
    .src2(32'h0004),
    .adder_out(w_pc_adder_out)

);

instruction_memory inst_mem
(
  	.address(w_pc_out), 
    .instruction(instruction)
);


assign pc_next = w_pc_adder_out;

wire [25:0] target_address;
wire [31:0] word_target_address;


assign target_address = instruction[25:0];


left_2_shift shifter1
(
    .in(target_address),
    .out(word_target_address)
);

 mux_2to1_32bit pc_mux2
(
    .select(jump),
    .in0(pc_mux1_out),
    .in1(word_target_address),
    .out(pc_in)

);

endmodule
