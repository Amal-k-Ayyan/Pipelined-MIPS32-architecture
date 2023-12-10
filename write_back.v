module write_back 
(   
    input wire w_RegWrite,
    input MemtoReg,
    input [31:0]data_mem_out,
    input [31:0]alu_out,
    input [4:0] rd_out_WB_in,

    output wire RegWrite,
    output reg [4:0] rd_out_WB_out,
    output [31:0] write_back_out
);

assign w_RegWrite = RegWrite;

always @(rd_out_WB_in) begin
    rd_out_WB_out <= rd_out_WB_in;
end
    
mux_2to1_32bit WB
(
    .select(MemtoReg ),
    .in0(alu_out),
    .in1(data_mem_out),

    .out(write_back_out)

);


endmodule