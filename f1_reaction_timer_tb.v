`timescale 1ns / 1ps

module f1_reaction_timer_tb;

reg clk;
reg start;
reg stop;
reg clear;

wire [4:0] leds;

wire [6:0] seg;
wire [3:0] an;

//====================================================
// DUT
//====================================================

f1_reaction_timer DUT(

    .clk(clk),
    .start(start),
    .stop(stop),
    .clear(clear),

    .leds(leds),

    .seg(seg),
    .an(an)

);

//====================================================
// CLOCK
//====================================================

always #5 clk = ~clk;

//====================================================
// TEST
//====================================================

initial
begin

    clk = 0;
    start = 0;
    stop = 0;
    clear = 1;

    // RESET

    #100;

    clear = 0;

    // START

    #100;

    start = 1;

    #20;

    start = 0;

    // WAIT FOR TIMER START

    #850000000;

    // USER REACTION

    #250000000;

    stop = 1;

    #20;

    stop = 0;

    // WAIT

    #10000000;

    $finish;

end

endmodule