module alu_control(
    input [5:0] funct,
    input [1:0] aluOp,
    output reg [2:0] aluControlOutput
    );
    
    localparam add   = 6'b100000,
               sub   = 6'b100010,
               mult  = 6'b011000,
               div   = 6'b011010,
               andOp = 6'b100100,
               orOp  = 6'b100101,
               norOp = 6'b100111,
               xorOp = 6'b100110,
               sll   = 6'b000000,
               srl   = 6'b000001;
     
    always @ (*)
        begin
        case (aluOp)
            2'b00: aluControlOutput = 3'b000; //provide add
            2'b01: aluControlOutput = 3'b001; //provide sub
            2'b10: begin
                   case (funct)
                        add   : aluControlOutput = 3'b000;
                        sub   : aluControlOutput = 3'b001;
                        mult  : aluControlOutput = 3'b010;
                        div   : aluControlOutput = 3'b011;
                        andOp : aluControlOutput = 3'b100;
                        orOp  : aluControlOutput = 3'b101;
                        norOp : aluControlOutput = 3'b110;
                        xorOp : aluControlOutput = 3'b111;
                        //sll   : aluControlOutput = 4'b1000;
                        //srl   : aluControlOutput = 4'b1001;
                        default : aluControlOutput = 3'b000;
                        endcase
                   end
             default: aluControlOutput = 3'b000;
            endcase
        end
endmodule