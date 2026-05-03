`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/22/2026 06:13:26 PM
// Design Name: 
// Module Name: receiver_dataflow
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


module receiver_dataflow(
        input logic serialIn, shift, clk,
        output logic [6:0] dataOut,
        output logic readErr
    );
    
    // Declare 9 bits of data (shouldn't need to keep start bit)
    logic [8:0] data;
        
    always_comb
    begin
        readErr = ~((^data[7:0]) & (data[8]));      // Check odd parity and stop bit
        dataOut = data[6:0];                        // The actual data
    end
    
    always_ff @(posedge clk)
    begin
        if (shift)
            data <= {serialIn, data[8:1]};          // Right shift, LSB comes in first
    end
    
endmodule
