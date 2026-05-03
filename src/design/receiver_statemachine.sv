`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2026 01:04:27 AM
// Design Name: 
// Module Name: receiver_statemachine
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


module receiver_statemachine(
        input logic ack, clrReceive, serialIn, cntDone, clk,
        input logic [13:0] timePassed,
        output logic req, shift, clrTim, incCnt, clrCnt
    );
    
    typedef enum logic[2:0] {INIT, WAIT_HALF, WAIT_FULL, SHIFT, SEND_DATA, ERR='X} StateType;
    StateType cs, ns;
    
    always_comb
    begin
        // Default states
        req = 0;
        shift = 0;
        clrTim = 0;
        incCnt = 0;
        clrCnt = 0;
        ns = ERR;
        
        // State logic
        case(cs)
        
            // Initial state, wait for the serialIn to drop low
            INIT:
            begin
                clrTim = 1;
                clrCnt = 1;
                if (~serialIn)
                    ns = WAIT_HALF;
                else
                    ns = INIT;
            end
            
            // Wait Half state, here we wait half of period so we can sample at the middle of the data
            WAIT_HALF:
            begin
                if (timePassed == 5207)     // 10417/2 = 5208.5
                begin
                    ns = WAIT_FULL;
                    clrTim = 1;             // Mealy output, clear on way to wait full state
                end
                else
                    ns = WAIT_HALF;
            end
            
            // Wait Full state, here we wait for middle of next bit to shift the data in. 
            WAIT_FULL:
            begin
                if (timePassed == 10416)
                begin
                    ns = SHIFT;
                    clrTim = 1;     // Clear timer before shift so it starts first count on shift
                    incCnt = 1;     // Increase bit count before shift state because we will shift no matter what then check count
                end
                else
                    ns = WAIT_FULL;
            end
            
            // Shift state, here we shift in the new data
            SHIFT:
            begin
                shift = 1;
                if (cntDone)
                    ns = SEND_DATA;
                else
                    ns = WAIT_FULL;
            end
            
            // Send Data state, tell host data is ready and wait for acknowledgement
            SEND_DATA:
            begin
                req = 1;
                if (~ack)
                    ns = SEND_DATA;
                else
                    ns = INIT;
            end
        endcase
        
        if (clrReceive)
                ns = INIT;
    end
    
    always @(posedge clk)
        cs <= ns;
    
endmodule
