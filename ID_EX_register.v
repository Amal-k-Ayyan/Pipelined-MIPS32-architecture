module ID_EX_register
(
    input wire reset, clk, // common to all pipeline registers

    // control unit signals
    input wire MemtoReg_ID_EX_in, // To WB stage
    input wire RegWrite_ID_EX_in, // To WB stage

    input wire jump_ID_EX_in,
    input wire branch_ID_EX_in, // To MEM stage
    input wire MemWrite_ID_EX_in,       // To MEM stage
    input wire MemRead_ID_EX_in,        // To MEM stage

    input wire RegDst_ID_EX_in,      // To execute stage
    input wire [1:0]ALUOp_ID_EX_in,  // To execute stage
    input wire ALUSrc_ID_EX_in,      // To execute stage

    //input from decode stage
    input wire [31:0]NPC_ID_EX_in,
    input wire [31:0]a_ID_EX_in,
    input wire [31:0]b_ID_EX_in,
    input wire [31:0]signed_offset_ID_EX_in,

    input wire [4:0] rs_ID_EX_in, // rs from decode
    input wire [4:0] rt_ID_EX_in, // rt from decode

    input wire [4:0] rd1_ID_EX_in,
    input wire [4:0] rd2_ID_EX_in,

    // output ports
    output reg MemtoReg_ID_EX_out, // To WB stage
    output reg RegWrite_ID_EX_out, // To WB stage

    output reg jump_ID_EX_out,
    output reg branch_ID_EX_out, // To MEM stage
    output reg MemWrite_ID_EX_out,       // To MEM stage
    output reg MemRead_ID_EX_out,        // To MEM stage

    output reg RegDst_ID_EX_out,      // To execute stage
    output reg [1:0]ALUOp_ID_EX_out,  // To execute stage
    output reg ALUSrc_ID_EX_out,      // To execute stage


    output reg [31:0]NPC_ID_EX_out,
    output reg [31:0]a_ID_EX_out,
    output reg [31:0]b_ID_EX_out,
    output reg [31:0]signed_offset_ID_EX_out,

    output reg [4:0] rs_ID_EX_out, // rs from decode
    output reg [4:0] rt_ID_EX_out, // rt from decode
    
    output reg [4:0] rd1_ID_EX_out,
    output reg [4:0] rd2_ID_EX_out

    );

    always @ (posedge clk or negedge reset)
        begin
            if(!reset)
                begin
                    MemtoReg_ID_EX_out <= 0;
                    RegWrite_ID_EX_out <= 0;

                    jump_ID_EX_out <= 0;
                    branch_ID_EX_out <= 0;
                    MemWrite_ID_EX_out <= 0;
                    MemRead_ID_EX_out <= 0;

                    RegDst_ID_EX_out <= 0;
                    ALUOp_ID_EX_out <= 0;
                    ALUSrc_ID_EX_out <= 0;


                    a_ID_EX_out <= 0;
                    b_ID_EX_out <= 0;
                    signed_offset_ID_EX_out <= 0;

                    rs_ID_EX_out <= 0;
                    rt_ID_EX_out <= 0;

                    rd1_ID_EX_out <= 0;
                    rd2_ID_EX_out <= 0;

                    NPC_ID_EX_out <= NPC_ID_EX_in;
                end
            else 
                begin
                    MemtoReg_ID_EX_out <= MemtoReg_ID_EX_in;
                    RegWrite_ID_EX_out <= RegWrite_ID_EX_in;

                    jump_ID_EX_out <= jump_ID_EX_in;
                    branch_ID_EX_out <= branch_ID_EX_in;
                    MemWrite_ID_EX_out <= MemWrite_ID_EX_in;
                    MemRead_ID_EX_out <= MemRead_ID_EX_in;

                    RegDst_ID_EX_out <= RegDst_ID_EX_in;
                    ALUOp_ID_EX_out <= ALUOp_ID_EX_in;
                    ALUSrc_ID_EX_out <= ALUSrc_ID_EX_in;

                    a_ID_EX_out <= a_ID_EX_in;
                    b_ID_EX_out <= b_ID_EX_in;
                    signed_offset_ID_EX_out <= signed_offset_ID_EX_in;

                    rs_ID_EX_out <= rs_ID_EX_in;
                    rt_ID_EX_out <= rt_ID_EX_in;
                    rd1_ID_EX_out <= rd1_ID_EX_in;
                    rd2_ID_EX_out <= rd2_ID_EX_in;

                    NPC_ID_EX_out <= NPC_ID_EX_in;
                end
        end

    endmodule