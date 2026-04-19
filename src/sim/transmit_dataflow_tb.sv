`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2026 08:42:56 PM
// Design Name: 
// Module Name: transmit_dataflow_tb
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


module transmit_dataflow_tb;
    logic [6:0] Din;
    logic shift, load, clk, clrData;
    logic serialOut;
    
    transmit_dataflow DUT (
        .Din(Din), .shift(shift), .load(load), .clk(clk), .serialOut(serialOut), .clrData(clrData)
    );
    
    initial clk = 0;
    always #5 clk = ~clk;
    
    initial
    begin
        clrData = 1;
        shift = 0;
        load = 1;
        #10;
        clrData = 0;
        load = 0;
        shift = 1;
        #30;
        shift = 0;
        Din = 7'b1101100;
        load = 1;
        #10;
        load = 0;
        shift = 1;
        #200;
        $finish;
    end
    
endmodule
