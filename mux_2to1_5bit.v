module mux_2to1_5bit
(
    input select,
    input [4:0]in0,
    input [4:0]in1,

    output [4:0]out

);

  assign out = (select) ? in1: in0;
  
endmodule