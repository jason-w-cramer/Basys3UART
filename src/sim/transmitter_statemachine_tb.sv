`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 12:41:45 PM
// Design Name: 
// Module Name: transmitter_statemachine_tb
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


module transmitter_statemachine_tb;

    // DUT signals
    logic req, timDone, cntDone, clr, clk;                      // Inputs
    logic clrData, clrTim, clrCnt, incCnt, ack, shift, load;    // Outputs

    // Instantiate DUT
    transmitter_statemachine DUT (
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

    // Clock generation (10 time unit period)
    always #5 clk = ~clk;

    // Test sequence
    initial begin
        // Initialize signals
        clk = 0;
        req = 0;
        timDone = 0;
        cntDone = 0;
        clr = 1;
        #6; // align clock cycles but add 1 so that logic is clearly after clock edge

        // Apply reset
        #10;
        clr = 0;

        // Start transmission request
        #10;
        req = 1;

        // Simulate shifting 3 bits
        repeat (3) begin
            #60 timDone = 1;   // timer done → shift
            #10 timDone = 0;
        end

        // Indicate counter done (last bit sent)
        #10 cntDone = 1;
        #10 timDone = 1;  // trigger final shift
        #10 timDone = 0;

        // Wait and then drop request to complete handshake
        #20 req = 0;

        // Finish simulation
        #50 $stop;
    end

endmodule
