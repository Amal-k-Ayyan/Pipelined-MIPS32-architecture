module MEM_WB_register
(
    input wire reset, clk, // common to all pipeline registers

    // control unit signals
    input wire MemtoReg_MEM_WB_in, // To WB stage
    input wire RegWrite_MEM_WB_in, // To WB stage

    // input from data memory stage
    input wire [31:0] data_out_MEM_WB_in,
    input wire [31:0]alu_out_MEM_WB_in,
    
    input wire [4:0] rd_out_MEM_WB_in,

    // Outputs
    output reg MemtoReg_MEM_WB_out, 
    output reg RegWrite_MEM_WB_out, 

    output reg [31:0] data_out_MEM_WB_out,
    output reg [31:0]alu_out_MEM_WB_out,
    
    output reg [4:0] rd_out_MEM_WB_out


);


always @ (posedge clk or negedge reset)
        begin
            if(!reset)
                begin
                    MemtoReg_MEM_WB_out <= 0;
                    RegWrite_MEM_WB_out <= 0; 

                    data_out_MEM_WB_out <= 0;
                    alu_out_MEM_WB_out <= 0;
    
                    rd_out_MEM_WB_out <= 0;
                end
            else 
                begin
                    MemtoReg_MEM_WB_out <= MemtoReg_MEM_WB_in;
                    RegWrite_MEM_WB_out <= RegWrite_MEM_WB_in; 

                    data_out_MEM_WB_out <= data_out_MEM_WB_in;
                    alu_out_MEM_WB_out <= alu_out_MEM_WB_in;
    
                    rd_out_MEM_WB_out <= rd_out_MEM_WB_in;
                end
        end
    
endmodule