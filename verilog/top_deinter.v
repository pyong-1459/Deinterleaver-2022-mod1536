module top_deinter(
    output [10:0] deleav_data,
    input  clk, rst,
    input  [10:0] data_in,
    input  en_in     //
);

wire [8:0] data_sram;
wire [13:0] addr;
wire [10-1:0] RA;
wire [4-1:0] CA;
wire NCE, NWRT;

assign RA = addr[13 -: 10];
assign CA = addr[0 +: 4];

SRAM MEM(
    .NWRT(NWRT),
    .DIN(data_in),
    .RA(RA),
    .CA(CA),
    .NCE(NCE),
    .CK(clk),
    .DO(deleav_data) 
);

deinterleaver DEINTER(
    .ADDR(addr),
    .en_out(en_i),
    .NWRT(NWRT),
    .NCE(NCE),
    .clk(clk),
    .rst(rst),
    .en_in(en_in)
);

endmodule
