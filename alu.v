
module alu
 (input [31:0] op1,
  input [31:0] op2,
  input [2:0] alu_funct,
  output carry,
  output zero,
  output [31:0]out
  );
  reg [32:0] outputWire;

 assign zero = ~|(out); // bitwise reduction
 assign {carry, out[31:0]} = outputWire[32:0];

 //fsm
 localparam ADD = 0;
 localparam SUB = 1;
 localparam MUL = 2;
 localparam DIV = 3;
 localparam AND = 4;
 localparam OR  = 5;
 localparam NOR = 6;
 localparam XOR = 7;
 //localparam sll = 8;
 //localparam srl = 9;

 always @(*)
    begin
        case(alu_funct)
            //NOP: out = 0; //No operation
            ADD: outputWire = op1 + op2;
            SUB: outputWire = op1 - op2;
            MUL: outputWire = op1 * op2;
            AND: outputWire = op1 & op2;
            OR : outputWire = op1 | op2;
            NOR: outputWire = ~(op1 | op2);
            XOR: outputWire = op1 ^ op2;
            //sll: outputWire = 
            default: outputWire = 0;
        endcase
    end

endmodule
