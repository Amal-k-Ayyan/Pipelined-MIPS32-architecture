module decoder 
( 
  input wire clk,
  input Mux_enable_ID,

  // control unit signal
  input RegWrite,

  // input from fetch
  input wire [31:0] NPC_ID_in,
  input wire [31:0] instruction,

  // input from write back stage
  input wire [31:0]wrData,
  input wire[4:0] rd,  // register destination address

  
  // outputs
  output wire [31:0] NPC_ID_out,
  output wire [31:0]a, // source operand 1
  output wire [31:0]b, // source operand 2
  output wire [31:0] signed_offset,
  output wire [4:0] rd1, // R-type source destination
  output wire [4:0] rd2, // I-type source destination


  //control unit outputs

  output wire [1:0] aluOp,
  output wire regDst,
  output wire jump_ID_out,
  output wire branch,
  output wire memtoReg, 
  output wire memWrite, 
  output wire aluSrc,
  output wire regWrite,
  output wire memRead,

   // To hazard detection unit

   output [4:0] rs, rt

);

  wire [5:0] w_opcode;
  wire [15:0] immediate;


  assign w_opcode = instruction[31:26];

  // for R-type
  assign rs = instruction[25:21];
  assign rt = instruction[20:16];
  assign rd1 = instruction[15:11]; 


  // for I-type
  assign rd2 = instruction[20:16]; // also pass it to hazard control unit
  assign immediate = instruction[15:0]; //15-bit offset



  // Next PC
  assign NPC_ID_out = NPC_ID_in;
  
  wire [1:0] w_aluOp;
  wire w_regDst,
   w_jump_ID_out, 
   w_branch,
    w_memtoReg,
     w_memWrite, 
     w_aluSrc,
      w_RegWrite,
       w_memRead;

control_unit cont
(
    .opcode(w_opcode),
    .regDst(w_regDst),
    .aluOp(w_aluOp),
    .jump(w_jump_ID_out),
    .branch(w_branch),
    .memtoReg(w_memtoReg), 
    .memWrite(w_memWrite), 
    .aluSrc(w_aluSrc),
    .regWrite(w_regWrite),
    .memRead(w_memRead)
    );

wire [9:0] control_bus_in, control_bus_out;
assign control_bus_in = {w_regDst, w_aluOp, w_jump_ID_out, w_branch,w_memtoReg, w_memWrite, w_aluSrc, w_RegWrite,w_memRead};

mux_ID t0
(
    .Mux_enable_ID(Mux_enable_ID),
    .control_in(control_bus_in),
    .control_out(control_bus_out)
);

assign {regDst, aluOp, jump_ID_out, branch,memtoReg, memWrite, aluSrc, RegWrite, memRead} = control_bus_out;


  register_file reg_file
(
    .clk(clk), 
    .wr_en(RegWrite), 

    .wrData(wrData), 
    .src1(rs), // Source register address
    .src2(rt), // Source register address
    .dest(rd), // destination register address from write back stage

    .rdData1(a),
    .rdData2(b)
 );

  sign_extender extender
(
    .offset(immediate),
    .signed_offset(signed_offset)

  );


endmodule
