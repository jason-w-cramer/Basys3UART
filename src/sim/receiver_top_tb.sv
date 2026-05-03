`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2026 02:46:38 AM
// Design Name: 
// Module Name: receiver_top_tb
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


module receiver_top_tb;
    logic ack, clk, clrReceive, serialIn, req, readErr; 
    logic [6:0] data;
    
    receiver_top DUT(
        .ack(ack), 
        .clk(clk), 
        .clrReceive(clrReceive), 
        .serialIn(serialIn),
        .req(req),
        .readErr(readErr), 
        .data(data)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
    initial
    begin
        
    end
endmodule
