module mux_4to1_32bit
(
  input [1:0] sel,
  input  i0,i1,i2,i3,
  output reg out
);
    
  always @(*) begin
    case(sel)
      2'h0: out = i0;
      2'h1: out = i1;
      2'h2: out = i2;
      2'h3: out = i3;
      default: out = 0;
    endcase
  end
endmodule