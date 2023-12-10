module sign_extender
(
  input wire [15:0]offset,
  output wire [31:0]signed_offset

  );

  reg [31:0] extended;

always @(offset) begin
  
  extended[15:0] = offset[15:0];
  extended[31:16] = {16{offset[15]}};
    end
  
  assign signed_offset = extended;
    
endmodule