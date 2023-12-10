module EX_MEM_register 
(
    input wire reset, clk, // common to all pipeline registers

    // control unit signals
    input wire MemtoReg_EX_MEM_in, // To WB stage
    input wire RegWrite_EX_MEM_in, // To WB stage

    input wire jump_EX_MEM_in, 
    input wire branch_EX_MEM_in, // To MEM stage
    input wire MemWrite_EX_MEM_in,       // To MEM stage
    input wire MemRead_EX_MEM_in,        // To MEM stage

    // Input from Execute stage
    input wire [31:0]branch_pc_EX_MEM_in,  
    input wire zero_EX_MEM_in,
    input wire [31:0]alu_out_EX_MEM_in,
    input [31:0]b_EX_MEM_in,
    input [4:0]wire rd_out_EX_MEM_in,


    // Output signals
    output reg MemtoReg_EX_MEM_out, // To WB stage
    output reg RegWrite_EX_MEM_out, // To WB stage

    input wire jump_EX_MEM_out,
    output reg branch_EX_MEM_out, // To MEM stage
    output reg MemWrite_EX_MEM_out,       // To MEM stage
    output reg MemRead_EX_MEM_out,        // To MEM stage

    output reg [31:0]branch_pc_EX_MEM_out,  
    output reg zero_EX_MEM_out,
    output reg [31:0]alu_out_EX_MEM_out,
    output reg [31:0]b_EX_MEM_out,
    output reg rd_out_EX_MEM_out


);


always @ (posedge clk or negedge reset)
        begin
            if(!reset)
                begin
                    MemtoReg_EX_MEM_out <= 0;
                    RegWrite_EX_MEM_out <= 0;

                    branch_EX_MEM_out <= 0;
                    MemWrite_EX_MEM_out <= 0;
                    MemRead_EX_MEM_out <= 0;

                    branch_pc_EX_MEM_out <= 0;  
                    zero_EX_MEM_out <= 0;
                    alu_out_EX_MEM_out <= 0;
                    b_EX_MEM_out <= 0;
                    rd_out_EX_MEM_out <= 0;
                end
            else 
                begin
                    MemtoReg_EX_MEM_out <= MemtoReg_EX_MEM_in;
                    RegWrite_EX_MEM_out <= RegWrite_EX_MEM_in;

                    branch_EX_MEM_out <= branch_EX_MEM_in;
                    MemWrite_EX_MEM_out <= MemWrite_EX_MEM_in;
                    MemRead_EX_MEM_out <= MemRead_EX_MEM_in;

                    branch_pc_EX_MEM_out <= branch_pc_EX_MEM_in;  
                    zero_EX_MEM_out <= zero_EX_MEM_in;
                    alu_out_EX_MEM_out <= alu_out_EX_MEM_in;
                    b_EX_MEM_out <= b_EX_MEM_in;
                    rd_out_EX_MEM_out <= rd_out_EX_MEM_in;
                end
        end

    
endmodule