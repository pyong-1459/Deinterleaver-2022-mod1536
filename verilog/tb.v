`timescale 1ns/1ps

module tb();

reg clk, rst, en_in;
reg [10:0] data [0:12288-1]; 
reg [10:0] in_data;
wire [10:0] deleav_data;
wire NWRT, en_out;

// deinterleaver TEST(ADDR, en_out, NWRT, clk, rst, en_in);
top_deinter TEST(deleav_data, clk, rst, in_data, en_in);

initial begin
    rst <= 1;
    clk <= 1;
    en_in <= 0;
    #10
    rst <= 0;
    #10
    en_in <= 1;
    #491520         // 1536 * 8 * 10 * 2 * 2
    $finish;
end

integer i, j;

initial begin
    $readmemb("vector1.txt", data);
    #20
    for (i=0;i<12288;i=i+1) begin
        in_data <= data[i];
        #(20);
    end
    for (j=0;j<12288;j=j+1) begin
        in_data <= data[j];
        #(20);
    end
end

always #5 clk <= ~clk;

endmodule