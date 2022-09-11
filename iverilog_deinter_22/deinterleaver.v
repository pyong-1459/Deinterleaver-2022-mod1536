module deinterleaver(
    output [13:0] ADDR,
    output en_out, NWRT, NCE,
    input clk, rst, en_in
);

wire [2:0] index;
wire [7:0] MSB [0:7];

reg load_AtoH, NWRT_r;
reg [4:0] AtoH [0:7];
reg [8:0] LSB; // LSB 7bit

assign NWRT = NWRT_r;
assign NCE = ~load_AtoH;
assign index = LSB[2:0];

assign MSB[0] = AtoH[0];
assign MSB[1] = ~NWRT_r ? ({3'b0, AtoH[1]} + 8'd24)  : (AtoH[0] + 8'd24);
assign MSB[2] = ~NWRT_r ? ({3'b0, AtoH[2]} + 8'd48)  : (AtoH[0] + 8'd48);
assign MSB[3] = ~NWRT_r ? ({3'b0, AtoH[3]} + 8'd72)  : (AtoH[0] + 8'd72);
assign MSB[4] = ~NWRT_r ? ({3'b0, AtoH[4]} + 8'd96)  : (AtoH[0] + 8'd96);
assign MSB[5] = ~NWRT_r ? ({3'b0, AtoH[5]} + 8'd120) : (AtoH[0] + 8'd120);
assign MSB[6] = ~NWRT_r ? ({3'b0, AtoH[6]} + 8'd144) : (AtoH[0] + 8'd144);
assign MSB[7] = ~NWRT_r ? ({3'b0, AtoH[7]} + 8'd168) : (AtoH[0] + 8'd168);

assign ADDR[13 -: 8] = MSB[index];
assign ADDR[0  +: 6] = LSB[8 -: 6];

always @ (posedge clk) begin
    if (rst) begin
        load_AtoH <= 1'b0;
        AtoH[0]   <= 5'b0;
        AtoH[1]   <= 5'b0;
        AtoH[2]   <= 5'b0;
        AtoH[3]   <= 5'b0;
        AtoH[4]   <= 5'b0;
        AtoH[5]   <= 5'b0;
        AtoH[6]   <= 5'b0;
        AtoH[7]   <= 5'b0;
        LSB       <= 9'b0;
        NWRT_r    <= 1'b0;
    end
    else if (load_AtoH) begin
        NWRT_r <= ~NWRT_r;

        if (LSB == 9'h1ff && NWRT_r) begin
            LSB <= 9'b0;

            if (AtoH[0] == 5'd23) begin
                AtoH[0] <= 4'b0;
            end
            else begin
                AtoH[0] <= AtoH[0] + 4'b1;
            end

            if (AtoH[1] == 5'd23) begin
                AtoH[1] <= 4'b0;
            end
            else begin
                AtoH[1] <= AtoH[1] + 4'b1;
            end

            if (AtoH[2] == 5'd23) begin
                AtoH[2] <= 4'b0;
            end
            else begin
                AtoH[2] <= AtoH[2] + 4'b1;
            end

            if (AtoH[3] == 5'd23) begin
                AtoH[3] <= 4'b0;
            end
            else begin
                AtoH[3] <= AtoH[3] + 4'b1;
            end

            if (AtoH[4] == 5'd23) begin
                AtoH[4] <= 4'b0;
            end
            else begin
                AtoH[4] <= AtoH[4] + 4'b1;
            end

            if (AtoH[5] == 5'd23) begin
                AtoH[5] <= 4'b0;
            end
            else begin
                AtoH[5] <= AtoH[5] + 4'b1;
            end

            if (AtoH[6] == 5'd23) begin
                AtoH[6] <= 4'b0;
            end
            else begin
                AtoH[6] <= AtoH[6] + 4'b1;
            end

            if (AtoH[7] == 5'd23) begin
                AtoH[7] <= 4'b0;
            end
            else begin
                AtoH[7] <= AtoH[7] + 4'b1;
            end
        end
        else if (NWRT_r) begin
            LSB <= LSB + 9'b1;
        end
    end
    else if (en_in) begin
        load_AtoH <= 1'b1;
        AtoH[0] <= 5'd0;    // 0
        AtoH[1] <= 5'd12;   // =768/64
        AtoH[2] <= 5'd6;    // =384/64
        AtoH[3] <= 5'd18;   // =1152/64
        AtoH[4] <= 5'd21;   // =1344/64
        AtoH[5] <= 5'd3;    // =192/64
        AtoH[6] <= 5'd15;   // =960/64
        AtoH[7] <= 5'd9;    // =576/64
    end
    else begin
        load_AtoH <= 1'b0;
        AtoH[0]   <= 5'b0;
        AtoH[1]   <= 5'b0;
        AtoH[2]   <= 5'b0;
        AtoH[3]   <= 5'b0;
        AtoH[4]   <= 5'b0;
        AtoH[5]   <= 5'b0;
        AtoH[6]   <= 5'b0;
        AtoH[7]   <= 5'b0;
        LSB       <= 10'b0;
    end
end

endmodule