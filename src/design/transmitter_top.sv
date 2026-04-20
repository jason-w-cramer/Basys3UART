`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 04:28:14 PM
// Design Name: 
// Module Name: transmitter_top
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


module transmitter_top( 
            input logic [6:0] data, 
            input logic clk, clr, req, 
            output logic serialOut, ack 
        ); 
        
        logic clrTim, timDone;
        logic clrCnt, cntDone;
        logic clrData, incCnt;
        logic shift, load;
        
        tim tim1( 
            .clk(clk), 
            .clrTimer(clrTim), 
            .timerDone(timDone) 
        ); 
        
        counter cnt1( 
            .clk(clk), 
            .incCnt(incCnt), 
            .clrCnt(clrCnt), 
            .cntDone(cntDone) 
        ); 
        
        transmitter_statemachine tsm ( 
            .req(req), 
            .timDone(timDone), 
            .cntDone(cntDone), 
            .clr(clr), 
            .clk(clk), 
            .clrData(clrData), 
            .clrTim(clrTim), 
            .clrCnt(clrCnt), 
            .incCnt(incCnt), 
            .ack(ack), 
            .shift(shift), 
            .load(load) 
        ); 
        
        transmit_dataflow tsr ( 
            .Din(data), 
            .serialOut(serialOut), 
            .clk(clk), 
            .shift(shift), 
            .load(load), 
            .clrData(clrData) 
        ); 
        
endmodule