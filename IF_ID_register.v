module IF_ID_register
(
    // common to all pipeline registers
    input wire clk,
    input wire reset, 
    input wire IF_ID_en,

    // input from fetch stage
    input wire [31:0] instruction_IF_ID_in,
    input wire [31:0]NPC_IF_ID_in,
    
    output reg [31:0] instruction_IF_ID_out,
    output reg [31:0] NPC_IF_ID_out
    );

    always @ (posedge clk or negedge reset)
        begin
            if(!reset)
                begin
                    instruction_IF_ID_out <= 32'b0;
                    NPC_IF_ID_out <= NPC_IF_ID_in;
                end
            else if (!IF_ID_en)
                begin
                    instruction_IF_ID_out <= instruction_IF_ID_in;
                    NPC_IF_ID_out <= NPC_IF_ID_in;
                end
        end
endmodule
