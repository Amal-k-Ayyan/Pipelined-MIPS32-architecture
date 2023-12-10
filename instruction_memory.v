/*   - Instruction memory is a 1-D array.
     - Contains instrucion to be excecuted.
     - Can only be read. 
     - Cannot be modified using datapath.
*/

module instruction_memory 
(
  	input [31:0] address,
    output [31:0] instruction
);
    
reg [31:0]mem[0:1 << 10]; // 1024 locatins

initial begin
    $readmemh("instruct.txt", mem);
end

assign instruction = mem[address >> 2]; // To acces index of word

endmodule 