`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 03:50:58 PM
// Design Name: 
// Module Name: counter
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


module counter #(
    parameter COUNT_MAX = 10 // For 7 bits with a start, stop, and parity bit
    )(
        input logic clk, incCnt, clrCnt,
        output logic cntDone
    );
    
    // Make timer wide enough to fit COUNT_MAX
    logic [$clog2(COUNT_MAX)-1:0] count, nextCount;
    
    // Input and Output logic
    always_comb
    begin
        // Default values
        nextCount = count;
        cntDone = 0;
        
        if (clrCnt)
            nextCount = 0;
        else
        begin
            if (count == COUNT_MAX - 1)
            begin
                cntDone = 1;
                nextCount = count;
            end
            else if (~incCnt)
                nextCount = count;
            else
                nextCount = count + 1;  
        end
    end
    
    // Flip Flops
    always_ff @(posedge clk)
        count <= nextCount;
    
endmodule

