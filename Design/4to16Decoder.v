`timescale 1ns / 1ps

module 4to16Decoder (
    input A, B, C, D;
    output [15:0] sel_out
    );

    wire Abar, Bbar, Cbar, Dbar;

    not (Dbar, D);
    not (Cbar, C);
    not (Bbar, B);
    not (Abar, A);

    and (sel_out[ 0], Abar, Bbar, Cbar, Dbar);
    and (sel_out[ 1], Abar, Bbar, Cbar, D   );
    and (sel_out[ 2], Abar, Bbar, C   , Dbar);
    and (sel_out[ 3], Abar, Bbar, C   , D   );
    and (sel_out[ 4], Abar, B   , Cbar, Dbar);
    and (sel_out[ 5], Abar, B   , Cbar, D   );
    and (sel_out[ 6], Abar, B   , C   , Dbar);
    and (sel_out[ 7], Abar, B   , C   , D   );
    and (sel_out[ 8], A   , Bbar, Cbar, Dbar);
    and (sel_out[ 9], A   , Bbar, Cbar, D   );
    and (sel_out[10], A   , Bbar, C   , Dbar);
    and (sel_out[11], A   , Bbar, C   , D   );
    and (sel_out[12], A   , B   , Cbar, Dbar);
    and (sel_out[13], A   , B   , Cbar, D   );
    and (sel_out[14], A   , B   , C   , Dbar);
    and (sel_out[15], A   , B   , C   , D   );
    
endmodule