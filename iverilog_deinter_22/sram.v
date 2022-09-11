module SRAM
#(parameter WORDSIZE = 11)
(
    input NWRT,
    input [WORDSIZE-1:0] DIN,
    input [10-1:0] RA,
    input [4-1:0] CA,
    input NCE,
    input CK,
    output [WORDSIZE-1:0] DO 
);

syncRAM MEM(DIN, DO, {RA, CA}, ~NCE, ~NWRT, NWRT, CK);

endmodule

module syncRAM( dataIn,
                dataOut,
                Addr, 
                CS, 
                WE, 
                RD, 
                Clk
);

// parameters for the width 

parameter ADR   = 14;
parameter DAT   = 11;
parameter DPTH  = 12288;

//ports
input   [DAT-1:0]  dataIn;
output reg [DAT-1:0]  dataOut;
input   [ADR-1:0]  Addr;
input CS, 
      WE, 
      RD, 
      Clk;

      

//internal variables

reg [DAT-1:0] SRAM [0:DPTH-1];


always @ (posedge Clk)
begin

 if (CS == 1'b1) begin

  if (WE == 1'b1 && RD == 1'b0) begin

   SRAM [Addr] <= dataIn;

  end

  else if (RD == 1'b1 && WE == 1'b0) begin

   dataOut <= SRAM [Addr]; 

  end

  else;

 end

 else;

end

endmodule