
module hazard_detection_unit(
    input ID_EX_memRead,
    input [4:0] EX_rt, ID_rs, ID_rt,

    output IF_ID_write, PC_write, Mux_enable_ID
    );
    assign IF_ID_write = (ID_EX_memRead & ((EX_rt == ID_rs) | (EX_rt==ID_rt)) );
    assign PC_write = (ID_EX_memRead & ((EX_rt==ID_rs) | (EX_rt==ID_rt)) );
    assign Mux_enable_ID = (ID_EX_memRead & ((EX_rt==ID_rs) | (EX_rt==ID_rt)) );
endmodule
