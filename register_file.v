module register_file
(
 input wire clk, 
 input wire wr_en, 

 input [31:0]wrData, 
 input [4:0]src1, // Source register address
 input [4:0]src2, // Source register address
 input [4:0]dest, // destination register address

 output reg [31:0]rdData1,
 output reg [31:0]rdData2
 );

// 32, 32-bit register files
reg [31:0] R0, R1, R2, R3, R4, R5, R6, R7, R8, R9, R10, R11, R12, R13, R14, R15;
reg [31:0] R16, R17, R18, R19, R20, R21, R22, R23 ,R24, R25, R26, R27, R28, R29, R30, R31;


always @(*)
    begin
        case (src1)
            0: rdData1 = R0;
            1: rdData1 = R1;
            2: rdData1 = R2;
            3: rdData1 = R3;
            4: rdData1 = R4;
            5: rdData1 = R5;
            6: rdData1 = R6;
            7: rdData1 = R7;
            8: rdData1 = R8;
            9: rdData1 = R9;
            10: rdData1 = R10;
            11: rdData1 = R11;
            12: rdData1 = R12;
            13: rdData1 = R13;
            14: rdData1 = R14;
            15: rdData1 = R15;
            16: rdData1 = R16;
            17: rdData1 = R17;
            18: rdData1 = R18;
            19: rdData1 = R19;
            20: rdData1 = R20;
            21: rdData1 = R21;
            22: rdData1 = R22;
            23: rdData1 = R23;
            24: rdData1 = R24;
            25: rdData1 = R25;
            26: rdData1 = R26;
            27: rdData1 = R27;
            28: rdData1 = R28;
            29: rdData1 = R29;
            30: rdData1 = R30;
            31: rdData1 = R31;
            
            default: rdData1 = 1;
        endcase
    end


    always @(*)
    begin
        case (src2)
           0: rdData2 = R0;
            1: rdData2 = R1;
            2: rdData2 = R2;
            3: rdData2 = R3;
            4: rdData2 = R4;
            5: rdData2 = R5;
            6: rdData2 = R6;
            7: rdData2 = R7;
            8: rdData2 = R8;
            9: rdData2 = R9;
            10: rdData2 = R10;
            11: rdData2 = R11;
            12: rdData2 = R12;
            13: rdData2 = R13;
            14: rdData2 = R14;
            15: rdData2 = R15;
            16: rdData2 = R16;
            17: rdData2 = R17;
            18: rdData2 = R18;
            19: rdData2 = R19;
            20: rdData2 = R20;
            21: rdData2 = R21;
            22: rdData2 = R22;
            23: rdData2 = R23;
            24: rdData2 = R24;
            25: rdData2 = R25;
            26: rdData2 = R26;
            27: rdData2 = R27;
            28: rdData2 = R28;
            29: rdData2 = R29;
            30: rdData2 = R30;
            31: rdData2 = R31;
            default: rdData2 = 1;
        endcase
    end

always @(posedge clk)
    begin
        if (wr_en)
            case (dest)
                0: R0 <= wrData;
                1: R1 <= wrData;
                2: R2 <= wrData;
                3: R3 <= wrData;
                4: R4 <= wrData;
                5: R5 <= wrData;
                6: R6 <= wrData;
                7: R7 <= wrData;
                0: R0 <= wrData;
                11: R11 <= wrData;
                12: R12 <= wrData;
                13: R13 <= wrData;
                14: R14 <= wrData;
                15: R15 <= wrData;
                16: R16 <= wrData;
                17: R17 <= wrData;
                20: R20 <= wrData;
                21: R21 <= wrData;
                22: R22 <= wrData;
                23: R23 <= wrData;
                24: R24 <= wrData;
                25: R25 <= wrData;
                26: R26 <= wrData;
                27: R27 <= wrData;
                28: R28 <= wrData;
                29: R29 <= wrData;
                30: R30 <= wrData;
                31: R31 <= wrData;

            endcase
    end

endmodule