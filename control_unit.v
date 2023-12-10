module control_unit
(
    input [5:0] opcode,

    output reg [1:0] aluOp,
    output reg regDst,
    output reg jump,
    output reg branch,
    output reg memtoReg, 
    output reg memWrite, 
    output reg aluSrc,
    output reg regWrite,
    output reg memRead
    );
    reg [9:0] flags;
    
    localparam loadWord = 6'b100011,
               storeWord = 6'b101011,
               beq = 6'b000100,
               //bne = 6'b000101,
               rI = 6'b000000,
               jumpImm = 6'b000010,
               addi = 6'b001000;
               //andi = 6'b001100,
               //ori = 6'b001101,
               //xori = 6'b001110;
    
    always @ (*)
        begin
        {jump, aluOp, memWrite, regWrite, regDst, aluSrc, memtoReg, branch, memRead} = flags;
        end
        
    always @ (*)
        begin
        case (opcode)
            loadWord      : flags = 10'b0_0001_01101;
            storeWord     : flags = 10'b0_0010_01100;
            rI            : flags = 10'b0_1001_10000;
            addi          : flags = 10'b0_0001_01000;
            beq           : flags = 10'b0_0100_00010;
            jumpImm       : flags = 10'b1_0000_00000;
            default       : flags = 10'b0_0000_00000;
            endcase
        end
endmodule