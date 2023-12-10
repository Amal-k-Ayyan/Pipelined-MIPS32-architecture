module left_2_shift(
    input [25:0]in,
    output [31:0]out
);
reg [31:0]shifted;
always @(in) begin
    shifted = in << 2;
end
assign out = shifted;
    
endmodule