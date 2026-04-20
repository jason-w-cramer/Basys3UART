`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 04:06:52 PM
// Design Name: 
// Module Name: counter_tb
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


module counter_tb;
    logic clk, incCnt, clrCnt;  // Input
    logic cntDone;              // Output
    
    counter DUT (.clk(clk), .incCnt(incCnt), .clrCnt(clrCnt), .cntDone(cntDone));
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial
    begin
        clrCnt = 1;
        incCnt = 0;
        #10;
        clrCnt = 0;
        incCnt = 1;
        #10;
        incCnt = 0;
        #50;
        incCnt = 1;
        #100;
        $finish;      
    end
endmodule
