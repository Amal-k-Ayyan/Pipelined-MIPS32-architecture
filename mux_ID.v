module mux_ID
(


    input Mux_enable_ID,
    input [9:0] control_in,
    output reg [9:0] control_out

);
supply0 gnd;
always @(*)
begin
    if (Mux_enable_ID)
        control_out <= gnd;
    else
        control_out <= control_in;
end


    
endmodule