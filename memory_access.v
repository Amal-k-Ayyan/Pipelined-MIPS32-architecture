/* control signals are named as it is in stages which needs them. 
Else they are named as <signal_name>_<stage_name>_<in/out>
*/

module memory_access
 (
    input clk,

    // Control unit signals
    input wire MemtoReg_MEM_in, // To WB stage
    input wire RegWrite_MEM_in, // To WB stage

    input wire jump_MEM_in,
    input wire branch_MEM_in, 
    input wire MemWrite,       
    input wire MemRead,        

    input wire [31:0]branch_pc_MEM_in,

    input wire zero_MEM_in,

    input [31:0] address_MEM_in,
    input [31:0] data_MEM_in,

    input wire rd_out_MEM_in,
   
    output wire MemtoReg_EX_MEM_out,
    output wire RegWrite_MEM_out,
    output wire jump_MEM_out, // to fetch

    output reg[31:0] data_MEM_out,
    output [31:0] address_MEM_out,
    output [4:0] rd_out_MEM_out,

    output PCSrc_MEM_out, // to fetch

    output wire [31:0]branch_pc_MEM_out
); 
    
    reg [31:0]data_memory[0:1024]; // 1K*32 memory


    always @ (posedge clk) begin
        if(MemRead)
          data_MEM_out <= data_memory[address_MEM_in];
    end

    always @ (posedge clk) begin
        if(MemWrite)
            data_memory[address_MEM_in] <= data_MEM_in;
    end

    assign jump_MEM_out = jump_MEM_in;
    assign address_MEM_out = address_MEM_in;
    assign PCSrc_MEM_out = branch_MEM_in & zero_MEM_in;
endmodule