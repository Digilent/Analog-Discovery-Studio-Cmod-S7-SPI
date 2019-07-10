`timescale 1ns / 1ps

module counter #(
    parameter MAX_COUNT=255,
    parameter WIDTH=8
) (
    input wire clk,
    input wire reset,
    input wire en,
    output reg tc,
    output reg [WIDTH-1:0] count = 0
);
    always@(posedge clk) begin
        if (reset) begin
            count <= 'b0;
        end else if (en) begin
            if (tc)
                count <= 'b0;
            else
                count <= count + 1;
        end
    end
    
    always@(reset, en, count) begin
        if (reset) begin
            tc = 0;
        end else if (!en) begin
            tc = 0;
        end else if (count >= MAX_COUNT) begin
            tc = 1;
        end else begin
            tc = 0;
        end
    end
endmodule

module dff #(parameter WIDTH=1) (
    input wire clk,
    input wire reset,
    input wire set,
    input wire [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout = 0
);
    always@(posedge clk) begin
        if (reset) begin
            dout <= 'b0;
        end else if (set) begin
            dout <= din;
        end
    end
endmodule

module spi_master #(
    parameter HALF_SCK_CLK_DIV=12,
    parameter HALF_SCK_CLK_DIV_CLOG2=4,
    parameter BITS_PER_WORD = 8,
    parameter BITS_PER_WORD_CLOG2 = 3
) (
    input clk,
    input reset,
    input enable,
    
    input valid,
    input [BITS_PER_WORD-1:0] data,
    output ready,
    
    input spi_cpol,
    input spi_cpha,
    
    output spi_cs,
    output spi_mosi,
    input  spi_miso,
    output spi_sck
);
    localparam SCK_CLK_DIV = 2 * HALF_SCK_CLK_DIV;
    localparam SCK_CLK_DIV_CLOG2 = 1 + HALF_SCK_CLK_DIV_CLOG2;
    
    wire n_cs;
    
    wire [BITS_PER_WORD-1:0] data_reg;
    dff #(BITS_PER_WORD) register_data (clk, reset | !enable, valid & ready, data, data_reg);
    
    wire sck_toggle;
    counter #(HALF_SCK_CLK_DIV-1, HALF_SCK_CLK_DIV_CLOG2) sck_counter (clk, reset, n_cs & enable, sck_toggle, );
    
    wire sck_inactive_edge;
    wire sck_cpha0;
    counter #(1, 1) sck_gen (clk, reset, sck_toggle, sck_inactive_edge, sck_cpha0);
    
    wire end_of_byte;
    wire [BITS_PER_WORD_CLOG2-1:0] bit_select;
    counter #(BITS_PER_WORD-1, BITS_PER_WORD_CLOG2) bit_counter (clk, reset, sck_inactive_edge, end_of_byte, bit_select);
    
    assign ready = end_of_byte | ~n_cs;
    
    dff #(1) get_active (clk, reset | !enable, end_of_byte | valid, valid, n_cs);
    
    wire sck_cpol0 = n_cs ? (spi_cpha ^ sck_cpha0) : 1'b0;
    assign spi_sck = spi_cpol ^ sck_cpol0;
    assign spi_mosi = n_cs ? data[~bit_select] : 1'b0;
    assign spi_cs = ~n_cs;
endmodule


module spi_tb;
    reg clk = 0;
    initial begin
        #1 clk = 1;
        forever #0.5 clk = ~clk;
    end
    reg reset = 0;
    reg enable = 1;
    reg valid = 1;
    initial #100 valid = 0;
    reg [15:0] data = 16'hDEAD;
    wire ready;
    spi_master #(100, 7, 16, 4) spi_inst (
        clk,
        reset, enable,
        valid, data, ready,
        0, 0,
        , , , 
    );
endmodule
