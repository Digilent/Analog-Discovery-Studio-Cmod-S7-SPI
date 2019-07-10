`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2019 02:34:40 PM
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

module top (
    input  wire clk12MHz,
    output wire [7:0] ja,
    input  wire vaux5_p,
    input  wire vaux5_n,
    input  wire vaux12_p,
    input  wire vaux12_n,
    input  wire vp_in,
    input  wire vn_in,
    inout  wire [7:0] pio
);
    wire clk;
    clk_wiz_0 clk_wiz_inst (
        .clk_in1(clk12MHz),
        .clk_out1(clk)
    );
    
    wire spi_sck, spi_miso, spi_mosi, spi_cs;
    wire reset, enable, spi_cpol, spi_cpha;
    assign reset    = pio[7];
    assign enable   = pio[6];
    assign spi_cpol = pio[5];
    assign spi_cpha = pio[4];
    assign pio[3]   = spi_sck;
    assign spi_miso = pio[2];
    assign pio[1]   = spi_mosi;
    assign pio[0]   = spi_cs;
    
    wire [15:0] data;
    wire valid;
    wire ready;
    wire last;
    
    xadc xadc_inst (
        clk,
        valid, data, last, ready,
        vaux5_p, vaux5_n, vaux12_p, vaux12_n, vp_in, vn_in
    );
    
    spi_master #(25, $clog2(25), 16, $clog2(16)) spi_inst (
        clk,
        reset, enable,
        valid, data, ready,
        spi_cpol, spi_cpha,
        spi_cs, spi_mosi, spi_miso, spi_sck
    );
    assign ja = data[15:8];
endmodule