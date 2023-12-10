module adder 
(
  	input [31:0]src1,
    input [31:0]src2,
    output reg[31:0]adder_out

);

always @(src1 or src2) begin
    adder_out = src1 + src2;
end
    
endmodule