`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2026 02:06:24 AM
// Design Name: 
// Module Name: receiver_statemachine_tb
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


module receiver_statemachine_tb;

    logic ack, clrReceive, serialIn, cntDone, clk, req, shift, clrTim, incCnt, clrCnt;
    logic [13:0] timePassed;
    
    
    receiver_statemachine DUT (
        .ack(ack),
        .clrReceive(clrReceive),
        .serialIn(serialIn),
        .cntDone(cntDone),
        .clk(clk),
        .timePassed(timePassed),
        .req(req),
        .shift(shift),
        .clrTim(clrTim),
        .incCnt(incCnt),
        .clrCnt(clrCnt)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial
    begin
        ack = 0;
        clrReceive = 1;
        serialIn = 1;
        cntDone = 0;
        timePassed = 0;
        #20;
        clrReceive = 0;
        #20;
        serialIn = 0;
        #20;
        serialIn = 1;
        #30;
        timePassed = 5208;
        #30;
        timePassed = 10416;
        #30;
        cntDone = 1;
        timePassed = 10416;
        #30;
        ack = 1;
        #20;
        ack = 0;
        
    end

endmodule
