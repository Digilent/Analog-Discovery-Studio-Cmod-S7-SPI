`timescale 1ns / 1ps

module xadc (
    input wire clk,
    
    output reg valid = 0,
    output reg [15:0] data = 0,
    output reg last = 0,
    input wire ready,
    
    input wire vaux5_p,
    input wire vaux5_n,
    input wire vaux12_p,
    input wire vaux12_n,
    input wire vp_in,
    input wire vn_in
);
    wire den_in;
    wire drdy_out;
    wire [15:0] do_out;
    reg [6:0] daddr_in = 7'h15;
    wire [4:0] channel_out;
    
    always@(posedge clk) begin
        if ((~valid | (valid & ready)) & drdy_out) begin
            data <= do_out;
            valid <= 1;
            last <= (channel_out == 5'h1C) ? 1'b1 : 1'b0;
        end else if (valid & ready) begin
            valid <= 0;
        end
    end
    
    xadc_wiz_0 xadc_wiz_inst (
        // s_drp
        .daddr_in(daddr_in),
        .den_in(den_in),
        .di_in('b0),
        .do_out(do_out),
        .drdy_out(drdy_out),
        .dwe_in('b0),
        // Vp_Vn
        .vp_in(vp_in),
        .vn_in(vn_in),
        // Vaux5
        .vauxp5(vaux5_p),
        .vauxn5(vaux5_n),
        // Vaux12
        .vauxp12(vaux12_p),
        .vauxn12(vaux12_n),
        // OTHERS
        .dclk_in(clk),
        .channel_out(channel_out),
        .eoc_out(den_in),
        .alarm_out(),
        .eos_out(),
        .busy_out()
    );
    
    always@(posedge clk) begin
        if (den_in) begin
            case (daddr_in)
            7'h1C: daddr_in <= 7'h15;
            7'h15: daddr_in <= 7'h1C;
            default: daddr_in <= 7'h15;
            endcase
        end
    end
endmodule
