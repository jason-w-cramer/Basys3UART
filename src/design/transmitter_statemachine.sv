`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: NA
// Engineer: Jason Cramer
// 
// Create Date: 04/18/2026 08:44:23 PM
// Design Name: UART-Basys3
// Module Name: transmitter_statemachine
// Project Name: UART-Basys3
// Target Devices: Basys3
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


module transmitter_statemachine(
        input logic req, timDone, cntDone, clr, clk,
        output logic clrData, clrTim, clrCnt, incCnt, ack, shift, load
    );
    
    typedef enum logic[2:0] {init, sft, wt, done, load_st, ERR='X} StateType;
    StateType ns, cs;
    
    // IFL and OFL logic in one combinational block
    always_comb
    begin
        // Default states for next state and output signals
        ns = ERR;
        clrData = 0;
        clrTim = 0;
        clrCnt = 0;
        incCnt = 0;
        ack = 0;
        shift = 0;
        load = 0;
        case (cs)
            // Initial state, clear everything and wait for a request (req)
            init: 
            begin
                clrData = 1;
                clrTim = 1;
                clrCnt = 1;
                if (req)
                    ns = load_st;
                else
                    ns = init;
            end
            
            // Load data to output
            load_st:
            begin
                load = 1;
                clrTim = 1;
                ns = wt;
            end
            
            // Waiting state, wait for timer to finish to let us know it's time to shift
            wt:
            begin
                if (timDone)
                begin
                    ns = sft;
                    incCnt = 1; // Increase shift counter (how many data bits have we sent)
                end
                else
                    ns = wt;
            end
            
            // Shift state, enable shift, clear timer for next shift wait time
            sft:
            begin
                clrTim = 1;
                shift = 1;
                if (~cntDone)
                    ns = wt;
                else
                    ns = done;
            end
            
            // Done state, we finished sending data, now send our acknowledge to host 
            // and wait for it to remove its request to finish the handshake
            done:
            begin
                ack = 1;
                if (req)
                    ns = done;
                else
                    ns = init;
            end
         endcase
         
         if (clr)
            ns = init;
    end
    
    // Flip flops for state register
    always_ff @(posedge clk)
        cs <= ns;
endmodule
