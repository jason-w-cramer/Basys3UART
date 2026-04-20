`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2026 10:39:56 PM
// Design Name: 
// Module Name: top
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


module top(
        input logic [6:0] sw,
        input logic clk,
        output logic UART
    );
    // ===================================================
    // Double latching input to avoid metastability
    // ===================================================
    logic[6:0] data, nextData;
    always_ff @(posedge clk)
    begin
        data <= nextData;
        nextData <= sw;
    end   
    
    
    // =====================================================
    // Declare transmitter and link signals
    // =====================================================
    logic clr, req, ack;
    
    transmitter_top tm( 
            .data(data), 
            .clk(clk), 
            .serialOut(UART), 
            .ack(ack), 
            .clr(clr), 
            .req(req)
        ); 
        
    
    // =========================================================
    // Assert clr to clear transmitter state before starting
    // ==========================================================
    logic [3:0] reset_cnt = 0;
    always_ff @(posedge clk) begin
        if (reset_cnt < 4'd10) begin
            reset_cnt <= reset_cnt + 1;
            clr <= 1'b1;   // hold reset
        end else begin
            clr <= 1'b0;   // release reset
        end
    end
    
    
    // ============================================================
    // Basic statemachine to handle setting and clearing req bit 
    // ============================================================  
    typedef enum logic [1:0] {
        IDLE,
        WAIT_ACK,
        GAP
    } state_t;

    state_t state;

    logic [15:0] gap_cnt;
    
    always_ff @(posedge clk) begin
        if (clr) begin
            state   <= IDLE;
            req     <= 0;
            gap_cnt <= 0;
        end else begin
        case (state)
            IDLE: begin
                req   <= 1;
                state <= WAIT_ACK;
            end
    
            WAIT_ACK: begin
                if (ack) begin
                    req     <= 0;
                    gap_cnt <= 0;
                    state   <= GAP;
                end
            end
    
            GAP: begin
                gap_cnt <= gap_cnt + 1;
    
                if (gap_cnt == 50000) begin  // adjust for your clk
                    state <= IDLE;
                end
            end

        endcase
        end
    end  
endmodule
