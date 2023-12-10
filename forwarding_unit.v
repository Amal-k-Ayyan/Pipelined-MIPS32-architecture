module forwarding_unit(
    input wire regWrite_mem, regWrite_wb,
    input wire [4:0] ID_EX_rs, ID_EX_rt, EX_MEM_rd, MEM_WB_rd,
    output reg [1:0] forwardAE, forwardBE
    );
    always @(*)
        begin
            if ((EX_MEM_rd!=0) & (EX_MEM_rd == ID_EX_rs) & regWrite_mem)
                forwardAE = 2'b10;
            else if ((MEM_WB_rd!=0) & (MEM_WB_rd == ID_EX_rs) & regWrite_wb)
                forwardAE = 2'b01;
            else
                forwardAE = 2'b00; 
        end
    always @(*)
        begin
            if ((EX_MEM_rd!=0) & (EX_MEM_rd == ID_EX_rt) & regWrite_mem)
                forwardBE = 2'b10;
            else if ((MEM_WB_rd!=0) & (MEM_WB_rd == ID_EX_rt) & regWrite_wb)
                forwardBE = 2'b01;
            else
                forwardBE = 2'b00;
        end
endmodule