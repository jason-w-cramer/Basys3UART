`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: None
// Engineer: Jason Cramer
// 
// Create Date: 04/16/2026 08:01:33 PM
// Design Name: UART-Basys3
// Module Name: transmit_dataflow
// Project Name: UART-Basys3
// Target Devices: Basys3
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision: v1
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module transmit_dataflow(
        input logic [6:0] Din,
        input logic shift, load, clk,
        output logic serialOut
    );
    
    logic [8:0] data;
    logic oddParity, start, stop;
    

    assign start = 1'b0;   
    assign stop = 1'b1;
    assign serialOut = data[0];
        
    always_comb
        oddParity = ~^Din;

    always_ff @(posedge clk)
    begin
        if (shift)
            data <= {stop, data[8:1]};
        else if (load)
            data <= {oddParity, Din, start};
        else
            data <= data;

    end
    
endmodule
