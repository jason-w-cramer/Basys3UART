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
        input logic clk, UARTrx,
        output logic UARTtx,
        output logic [7:0] led
    );
    
    logic clr;
    
    // ===================================================
    // Double latching inputs to avoid metastability
    // ===================================================
    logic[6:0] data, nextData;
    logic serialIn, nextSerial;
    always_ff @(posedge clk)
    begin
        // Switches
        data <= nextData;
        nextData <= sw;
        
        // UART Rx input
        nextSerial <= UARTrx;
        serialIn <= nextSerial;
    end   
    
    
    // =====================================================
    // Declare transmitter and link signals
    // =====================================================
    logic reqTx, ackTx;
    
    transmitter_top tm( 
            .data(data), 
            .clk(clk), 
            .serialOut(UARTtx), 
            .ack(ackTx), 
            .clr(clr), 
            .req(reqTx)
        ); 
        
    // =====================================================
    // Declare receiver and link signals
    // =====================================================
    logic reqRx, ackRx;
    receiver_top rm(
        .ack(ackRx), 
        .clk(clk), 
        .clrReceive(clr), 
        .serialIn(serialIn),
        .req(reqRx), 
        .readErr(led[7]), 
        .data(led[6:0])
    );
    
    // ==========================================================
    // Assert clr to clear transmitter/receiver state before starting
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
    // Basic statemachine to handle setting and clearing reqTx bit 
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
            reqTx   <= 0;
            gap_cnt <= 0;
        end else begin
        case (state)
            IDLE: begin
                reqTx <= 1;
                state <= WAIT_ACK;
            end
    
            WAIT_ACK: begin
                if (ackTx) begin
                    reqTx   <= 0;
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
    
    // ============================================================
    // Basic logic to handle setting and clearing ackRx bit 
    // ============================================================ 
    always_ff @(posedge clk) begin
        if (clr) begin
            ackRx <= 1'b0;
        end else begin
            // Assert ack when request is seen
            if (reqRx)
                ackRx <= 1'b1;
            // Deassert ack once request is released
            else
                ackRx <= 1'b0;
        end
    end

endmodule
