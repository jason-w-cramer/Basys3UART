`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 06:29:42 PM
// Design Name: 
// Module Name: receiver_dataflow_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module receiver_dataflow_tb;

    logic serialIn, shift, clk, readErr;
    logic [6:0] dataOut;
    
    receiver_dataflow DUT (
            .serialIn(serialIn), 
            .shift(shift), 
            .clk(clk),
            .dataOut(dataOut),
            .readErr(readErr)
        );
    
    initial clk = 0;
    always #5 clk = ~clk;
    initial
    begin
        serialIn = 1;
        shift = 0;
        #20;
        shift = 1;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 1;
        #10;
        serialIn = 1;
        #10;
        shift = 0;
        #30;
        shift = 1;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 0;
        #10;
        serialIn = 1;
        #10;
        serialIn = 1;
        #10;
        shift = 0;
        #30;
        $finish;
        
    end

endmodule
