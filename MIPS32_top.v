module MIPS32_top
 (
    input clk,
    input rst
);


wire PCSrc;
wire jump;
wire [31:0]w_branch_pc;
wire [31:0]w_pc_next;
wire [31:0]w_instruction;

// output of hazard control unit to PC of fetch unit.
wire w_pc_en;

fetch IF
(
    .clk(clk),
    .rst(rst),
    .PCSrc(PCSrc),
    .jump(jump),
    .pc_en(w_pc_en),
    .branch_pc(w_branch_pc), 

    .pc_next(w_pc_next),
    .instruction(w_instruction)
    
);

// output of hazard control unit to IF_ID stage
wire w_IF_ID_en;

// output of IF_ID_register
wire [31:0] w_instruction_IF_ID_out;    
wire [31:0] w_NPC_IF_ID_out;

IF_ID_register pipeline_reg1
(
    .clk(clk),
    .reset(rst),
    .IF_ID_en(w_IF_ID_en),
    .instruction_IF_ID_in(w_instruction),
    .NPC_IF_ID_in(w_pc_next),
    
    .instruction_IF_ID_out(w_instruction_IF_ID_out),
    .NPC_IF_ID_out(w_NPC_IF_ID_out)
    );

/////////////////////////////Hazard unit//////////////////////////////////////////////////
wire w_MemRead_ID_EX_out;
wire [4:0] w_rd2_ID_EX_out;
wire [4:0] w_rs, w_rt;
wire w_Mux_enable_ID;


hazard_detection_unit Hazard_unit
(
    .ID_EX_memRead(w_MemRead_ID_EX_out),
    .EX_rt(w_rd2_ID_EX_out), 
    .ID_rs(w_rs),
    .ID_rt(w_rt),

    .IF_ID_write(w_IF_ID_en),
    .PC_write(w_pc_en),
    .Mux_enable_ID(w_Mux_enable_ID)
    );


/////////////////////////////Hazard unit//////////////////////////////////////////////////

 // outputs of decoder stage
  wire [31:0] w_NPC_ID_out;
  wire [31:0] w_a; // source operand 1
  wire [31:0] w_b; // source operand 2
  wire [31:0] w_signed_offset;
  wire [4:0] w_rd1; // R-type source destination
  wire [4:0] w_rd2; // I-type source destination

  wire [1:0] w_aluOp;
  wire w_regDst;
  wire w_jump_ID_out;
  wire w_branch;
  wire w_memtoReg; 
  wire w_memWrite; 
  wire w_aluSrc;
  wire w_regWrite;
  wire w_memRead;


  wire RegWrite;
  wire [31:0]w_write_back_out; // from WB stage
  wire [4:0] w_rd_out_WB_out; // from WB stage

  // wire [4:0] w_rs, w_rt; (declared above hazard control unit)

decoder ID
( 
  .clk(clk),
  .Mux_enable_ID(w_Mux_enable_ID),

  .RegWrite(RegWrite),
  .NPC_ID_in(w_NPC_IF_ID_out),
  .instruction(w_instruction_IF_ID_out),

  .wrData(w_write_back_out),
  .rd(w_rd_out_WB_out), 

  // outputs
  .NPC_ID_out(w_NPC_IF_ID_out),
  .a(w_a), 
  .b(w_b),
  .signed_offset(w_signed_offset),
  .rd1(w_rd1),
  .rd2(w_rd2),

  .aluOp(w_aluOp), //
  .regDst(w_regDst), //
  .jump_ID_out(w_jump_ID_out),//
  .branch(w_branch), //
  .memtoReg(w_memtoReg), //
  .memWrite(w_memWrite), //
  .aluSrc(w_aluSrc), //
  .regWrite(w_regWrite),//
  .memRead(w_memRead),//

  .rs(w_rs), 
  .rt(w_rt)
);


// output of ID_EX register
    wire w_MemtoReg_ID_EX_out; // To WB stage
    wire w_RegWrite_ID_EX_out; // To WB stage

    wire w_jump_ID_EX_out;
    wire w_branch_ID_EX_out; // To MEM stage
    wire w_MemWrite_ID_EX_out;       // To MEM stage
   // wire w_MemRead_ID_EX_out;        // To MEM stage (already declared above hazard control unit)

    wire w_RegDst_ID_EX_out;      // To execute stage
    wire w_ALUOp_ID_EX_out;  // To execute stage
    wire w_ALUSrc_ID_EX_out;      // To execute stage


    wire [31:0] w_NPC_ID_EX_out;
    wire [31:0] w_a_ID_EX_out;
    wire [31:0] w_b_ID_EX_out;
    wire [31:0] w_signed_offset_ID_EX_out;
    wire [4:0] w_rd1_ID_EX_out;
    //wire [4:0] w_rd2_ID_EX_out; (already declared above hazard control unit)

    wire [4:0] w_rs_ID_EX_out; // rs from decode
    wire [4:0] w_rt_ID_EX_out; // rt from decode


ID_EX_register pipeline_reg2
(
    .reset(rst), 
    .clk(clk), 

    // control unit signals
    .MemtoReg_ID_EX_in(w_memtoReg), // To WB stage
    .RegWrite_ID_EX_in(w_regWrite), // To WB stage

    .jump_ID_EX_in(w_jump_ID_out),
    .branch_ID_EX_in(w_branch), // To MEM stage
    .MemWrite_ID_EX_in(w_memWrite),       // To MEM stage
    .MemRead_ID_EX_in(w_memRead),        // To MEM stage

    .RegDst_ID_EX_in(w_regDst),      // To execute stage
    .ALUOp_ID_EX_in(w_aluOp),        // To execute stage
    .ALUSrc_ID_EX_in(w_aluSrc),      // To execute stage

    //input from decode stage
    .NPC_ID_EX_in(w_NPC_ID_out),
    .a_ID_EX_in(w_a),
    .b_ID_EX_in(w_b),
    .signed_offset_ID_EX_in(w_signed_offset),
    .rs_ID_EX_in(w_rs), // rs from decode
    .rt_ID_EX_in(w_rt), // rt from decode
    .rd1_ID_EX_in(w_rd1),
    .rd2_ID_EX_in(w_rd2),

    // output ports
    .MemtoReg_ID_EX_out(w_MemtoReg_ID_EX_out), // To WB stage
    .RegWrite_ID_EX_out(w_RegWrite_ID_EX_out), // To WB stage

    .jump_ID_EX_out(w_jump_ID_EX_out),   // To MEM stage
    .branch_ID_EX_out(w_branch_ID_EX_out), // To MEM stage
    .MemWrite_ID_EX_out(w_MemWrite_ID_EX_out),       // To MEM stage
    .MemRead_ID_EX_out(w_MemRead_ID_EX_out),        // To MEM stage

    .RegDst_ID_EX_out(w_RegDst_ID_EX_out),      // To execute stage
    .ALUOp_ID_EX_out(w_ALUOp_ID_EX_out),  // To execute stage
    .ALUSrc_ID_EX_out(w_ALUSrc_ID_EX_out),      // To execute stage


    .NPC_ID_EX_out(w_NPC_ID_EX_out),
    .a_ID_EX_out(w_a_ID_EX_out),
    .b_ID_EX_out(w_b_ID_EX_out),
    .signed_offset_ID_EX_out(w_signed_offset_ID_EX_out),

    .rs_ID_EX_out(w_rs_ID_EX_out), // rs from decode
    .rt_ID_EX_out(w_rs_ID_EX_out), // rt from decode

    .rd1_ID_EX_out(w_rd1_ID_EX_out),
    .rd2_ID_EX_out(w_rd2_ID_EX_out)

    );

//output of execute stage

    wire w_MemtoReg_EX_out; // To WB stage
    wire w_RegWrite_EX_out; // To WB stage

    wire w_jump_EX_out;           // To MEM stage
    wire w_branch_EX_out; // To MEM stage
    wire w_MemWrite_EX_out;       // To MEM stage
    wire w_MemRead_EX_out;        // To MEM stage

    
    wire [31:0]w_branch_pc_EX_out;
    wire w_zero_EX_out;
    wire [31:0]w_alu_out;
    wire [31:0]w_b_out;
    wire [4:0] w_rd_EX_out;

     // new mux2 and mux3 controls
    wire [31:0] w_wb_out_EX_in;
    wire [31:0] w_address_MEM_out_EX_in;
    wire [1:0] w_forwardAE;
    wire [1:0] w_forwardBE;

    wire [31:0] w_alu_out_EX_MEM_out;

 execute EX
 (
    .clk(clk),

    // Control unit signals
    .MemtoReg_EX_in(w_MemtoReg_ID_EX_out), //
    .RegWrite_EX_in(w_RegWrite_ID_EX_out), //

    .jump_EX_in(w_jump_ID_EX_out), //
    .branch_EX_in(w_branch_ID_EX_out),  //
    .MemWrite_EX_in(w_MemWrite_ID_EX_out),  //     
    .MemRead_EX_in(w_MemRead_ID_EX_out),    //  

    .ALUSrc(w_ALUSrc_ID_EX_out),
    .RegDst(w_RegDst_ID_EX_out),
    .ALUOp(w_ALUOp_ID_EX_out),

    //input from decode stage
    .NPC_in(w_NPC_ID_EX_out),
    .a_EX_in(w_a_ID_EX_out),
    .b_EX_in(w_b_ID_EX_out),
    .signed_offset(w_signed_offset_ID_EX_out),
    .rd1_EX_in(w_rd1_ID_EX_out),
    .rd2_EX_in(w_rd2_ID_EX_out),

     // new mux2 and mux3 controls
    .wb_out_EX_in(w_write_back_out),
    .address_MEM_out_EX_in(w_alu_out_EX_MEM_out),
    .forwardAE(w_forwardAE),
    .forwardBE(w_forwardBE),

    
    // Outputs
    .MemtoReg_EX_out(w_MemtoReg_EX_out), // To WB stage
    .RegWrite_EX_out(w_RegWrite_EX_out), // To WB stage

    .jump_EX_out(w_jump_EX_out),
    .branch_EX_out(w_branch_EX_out), // To MEM stage
    .MemWrite_EX_out(w_MemWrite_EX_out),       // To MEM stage
    .MemRead_EX_out(w_MemRead_EX_out),        // To MEM stage

    
    .branch_pc_EX_out(w_branch_pc_EX_out), //
    .zero_EX_out(w_zero_EX_out), //
    .alu_out(w_alu_out), //
    .b_out(w_b_out), //
    .rd_EX_out(w_rd_EX_out) //
);


// output of EM_MEM register

    wire w_MemtoReg_EX_MEM_out; // To WB stage
    wire w_RegWrite_EX_MEM_out; // To WB stage

    wire w_jump_EX_MEM_out;
    wire w_branch_EX_MEM_out; // To MEM stage
    wire w_MemWrite_EX_MEM_out;       // To MEM stage
    wire w_MemRead_EX_MEM_out;        // To MEM stage

    wire [31:0] w_branch_pc_EX_MEM_out;  
    wire w_zero_EX_MEM_out;
    //wire [31:0] w_alu_out_EX_MEM_out;
    wire [31:0] w_b_EX_MEM_out;
    wire [4:0] w_rd_out_EX_MEM_out; 

EX_MEM_register pipeline_reg3
(
    .clk(clk), 
    .reset(rst), // common to all pipeline registers
     
    // control unit signals
    .MemtoReg_EX_MEM_in(w_MemtoReg_EX_out), // To WB stage
    .RegWrite_EX_MEM_in(w_RegWrite_EX_out), // To WB stage

    .jump_EX_MEM_in(w_jump_EX_out),
    .branch_EX_MEM_in(w_branch_EX_out), // To MEM stage
    .MemWrite_EX_MEM_in(w_MemWrite_EX_out),       // To MEM stage
    .MemRead_EX_MEM_in(w_MemRead_EX_out),        // To MEM stage

    // Input from Execute stage
    .branch_pc_EX_MEM_in(w_branch_pc_EX_out),  
    .zero_EX_MEM_in(w_zero_EX_out), //
    .alu_out_EX_MEM_in(w_alu_out),
    .b_EX_MEM_in(w_b_out),
    .rd_out_EX_MEM_in(w_rd_EX_out),


    // Output signals
    .MemtoReg_EX_MEM_out(w_MemtoReg_EX_MEM_out), // To WB stage
    .RegWrite_EX_MEM_out(w_RegWrite_EX_MEM_out), // To WB stage

    .jump_EX_MEM_out(w_jump_EX_MEM_out),
    .branch_EX_MEM_out(w_branch_EX_MEM_out), // To MEM stage
    .MemWrite_EX_MEM_out(w_MemWrite_EX_MEM_out),       // To MEM stage
    .MemRead_EX_MEM_out(w_MemRead_EX_MEM_out),        // To MEM stage

    .branch_pc_EX_MEM_out(w_branch_pc_EX_MEM_out),  
    .zero_EX_MEM_out(w_zero_EX_MEM_out),
    .alu_out_EX_MEM_out(w_alu_out_EX_MEM_out),
    .b_EX_MEM_out(w_b_EX_MEM_out),

    .rd_out_EX_MEM_out(w_rd_out_EX_MEM_out)

);

// output of memory_access stage
    //wire w_MemtoReg_EX_MEM_out;
    wire w_RegWrite_MEM_out;

    wire [31:0] w_data_MEM_out;
    wire [31:0] w_address_MEM_out;
    wire [4:0] w_rd_out_MEM_out;

    wire w_PCSrc_MEM_out;
/////////////////////////////////forwarding unit///////////////////////////////////////////

wire w_RegWrite_MEM_WB_out;

forwarding_unit fwd(
    .regWrite_mem(w_RegWrite_EX_MEM_out), 
    .regWrite_wb(w_RegWrite_MEM_WB_out),
    .ID_EX_rs(w_rs_ID_EX_out), 
    .ID_EX_rt(w_rt_ID_EX_out), 
    .EX_MEM_rd(w_rd_out_EX_MEM_out), 
    .MEM_WB_rd(w_rd_out_WB_out),
    .forwardAE(w_forwardAE),
    .forwardBE(w_forwardBE)
    );

/////////////////////////////////forwarding unit///////////////////////////////////////////
 memory_access MEM
 (
    .clk(clk),

    // Control unit signals
    .MemtoReg_MEM_in(w_MemtoReg_EX_MEM_out), // To WB stage
    .RegWrite_MEM_in(w_RegWrite_EX_MEM_out), // To WB stage

    .jump_MEM_in(w_jump_EX_MEM_out),
    .branch_MEM_in(w_branch_EX_MEM_out), 
    .MemWrite(w_MemWrite_EX_MEM_out),       
    .MemRead(w_MemRead_EX_MEM_out),        

    .branch_pc_MEM_in(w_branch_pc_EX_MEM_out),

    .zero_MEM_in(w_zero_EX_MEM_out),

    .address_MEM_in(w_alu_out_EX_MEM_out),
    .data_MEM_in(w_b_EX_MEM_out),

    .rd_out_MEM_in(w_rd_out_EX_MEM_out),
   
    // outputs
    .MemtoReg_EX_MEM_out(w_MemtoReg_EX_MEM_out),
    .RegWrite_MEM_out(w_RegWrite_MEM_out),

    .jump_MEM_out(jump),
    .data_MEM_out(w_data_MEM_out),
    .address_MEM_out(w_address_MEM_out),
    .rd_out_MEM_out(w_rd_out_MEM_out),

    .PCSrc_MEM_out(PCSrc),

    .branch_pc_MEM_out(w_branch_pc)
); 



// Outputs to Write back stage
    wire w_MemtoReg_MEM_WB_out; 
    //wire w_RegWrite_MEM_WB_out; )(already decalred above forwarding unit)

    wire [31:0] w_data_out_MEM_WB_out;
    wire [31:0] w_alu_out_MEM_WB_out;
    
    wire [4:0] w_rd_out_MEM_WB_out; 

MEM_WB_register pipeline_reg4
(
    .clk(clk), // common to all pipeline registers
    .reset(rst),

    // control unit signals
    .MemtoReg_MEM_WB_in(w_MemtoReg_EX_MEM_out), // To WB stage
    .RegWrite_MEM_WB_in(w_RegWrite_MEM_out), // To WB stage

    // input from data memory stage
    .data_out_MEM_WB_in(w_data_MEM_out),
    .alu_out_MEM_WB_in(w_address_MEM_out),
    
    .rd_out_MEM_WB_in(w_rd_out_MEM_out),

    // Outputs
    .MemtoReg_MEM_WB_out(w_MemtoReg_MEM_WB_out), 
    .RegWrite_MEM_WB_out(w_RegWrite_MEM_WB_out), 

    .data_out_MEM_WB_out(w_data_out_MEM_WB_out),
    .alu_out_MEM_WB_out(w_alu_out_MEM_WB_out),
    
    .rd_out_MEM_WB_out(w_rd_out_MEM_WB_out)


);


write_back WB
(   .w_RegWrite(w_RegWrite_MEM_WB_out),
    .MemtoReg(w_MemtoReg_MEM_WB_out),
    .data_mem_out(w_data_out_MEM_WB_out),
    .alu_out(w_alu_out_MEM_WB_out),
    .rd_out_WB_in(w_rd_out_MEM_WB_out),

    .RegWrite(RegWrite),
    .rd_out_WB_out(w_rd_out_WB_out),
    .write_back_out(w_write_back_out)
);

endmodule