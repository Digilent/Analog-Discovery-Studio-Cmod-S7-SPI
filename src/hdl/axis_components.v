`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2019 02:38:37 PM
// Design Name: 
// Module Name: axis_average
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


module axis_average(
    input wire clk,
    input wire s_valid,
    input wire [15:0] s_data,
    input wire s_last,
    output wire s_ready,
    output reg m_valid,
    output reg [15:0] m_data,
    input wire m_ready
);
    reg [15:0] data_reg = 0;
    assign s_ready = m_ready;
    always@(posedge clk) begin
        if ((~m_valid || (m_valid && m_ready)) && (s_valid && s_ready)) begin
            if (s_last) begin
                m_data <= ({1'b0, data_reg} + {1'b0, s_data}) >> 1;
                m_valid <= 1;
            end else begin
                data_reg <= s_data;
            end
        end else if (m_valid && m_ready) begin
            m_valid <= 0;
        end
    end
endmodule
