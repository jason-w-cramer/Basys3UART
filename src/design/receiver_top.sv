`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2026 02:25:14 AM
// Design Name: 
// Module Name: receiver_top
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


module receiver_top(
        input logic ack, clk, clrReceive, serialIn,
        output logic req, readErr, 
        output logic [6:0] data
    );
        
        // Internal wires
        logic shift, incCnt, cntDone, clrCnt, clrTim;
        logic [13:0] timePassed;
    
        receiver_dataflow rdf(
            .serialIn(serialIn), 
            .shift(shift), 
            .clk(clk),
            .dataOut(data),
            .readErr(readErr)
        );
        
        receive_tim tim2(
            .clrTimer(clrTim),
            .clk(clk),
            .count(timePassed)
        );
        
        counter cnt2(
            .clk(clk),
            .incCnt(incCnt), 
            .clrCnt(clrCnt), 
            .cntDone(cntDone)
        );
        
        receiver_statemachine rsm(
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
        
endmodule
