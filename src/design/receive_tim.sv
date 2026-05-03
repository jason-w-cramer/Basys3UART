`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2026 12:59:46 AM
// Design Name: 
// Module Name: receive_tim
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


module tim #(
    parameter COUNT_MAX = 10_416 // Baud rate of 9600 when clk frequency is 100MHz
    )(
        input logic clrTimer,
        input logic clk,
        output logic [$clog2(COUNT_MAX)-1:0] count
    );
        
    // Make timer wide enough to fit COUNT_MAX
    logic [$clog2(COUNT_MAX)-1:0] nextCount;
    
    // Input and Output logic
    always_comb
    begin
        // Default values
        nextCount = count;
        
        if (clrTimer)
            nextCount = 0;
        else
            nextCount = count + 1;  
    end
    
    // Flip Flops
    always_ff @(posedge clk)
        count <= nextCount;
    
endmodule
