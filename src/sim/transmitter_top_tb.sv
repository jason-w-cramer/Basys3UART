`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 06:36:12 PM
// Design Name: 
// Module Name: transmmitter_top_tb
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


module transmitter_top_tb;

    logic [6:0] data;           // Input
    logic clk, clr, req;        // Input
    logic serialOut, ack;       // Output
    
    transmitter_top DUT ( 
                .data(data), 
                .clk(clk), 
                .clr(clr), 
                .req(req), 
                .serialOut(serialOut),
                .ack(ack) 
            ); 
            
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial
    begin
        clr = 1;
        data = 7'b1010101;
        req = 0;
        #50;
        $monitor("time=%0t clrData=%0b", $time, DUT.clrData);
        clr = 0;
        req = 1;
        #100_000_000;
        req = 0;
        #20;
        $finish;
    end
endmodule
