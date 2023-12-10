module program_counter 
(
    input [31:0]pc_in,   // pc intput value
    input pc_clk,   // pc clk
    input pc_rst,   //  pc reset
    input pc_en,
    output reg [31:0] pc_out // pc output

);

  always @(posedge pc_clk or negedge pc_rst) begin
    if(!pc_rst)
        pc_out <= 0;

    else if (!pc_en)begin
        pc_out <= pc_in;
    end
end

endmodule