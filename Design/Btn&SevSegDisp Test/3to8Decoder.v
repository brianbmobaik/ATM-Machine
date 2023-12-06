`timescale 1ns / 1ps

module 3to8Decoder (
    input wire a, b, c,
    output reg [7:0] enable
    );

    wire abar, bbar, cbar;

    not (abar, a), (bbar, b), (cbar, c);

    and (enable[0], abar, bbar, cbar);
    and (enable[1], abar, bbar,    c);
    and (enable[2], abar,    b, cbar);
    and (enable[3], abar,    b,    c);
    and (enable[4],    a, bbar, cbar);
    and (enable[5],    a, bbar,    c);
    and (enable[6],    a,    b, cbar);
    and (enable[7],    a,    b,    c);

endmodule