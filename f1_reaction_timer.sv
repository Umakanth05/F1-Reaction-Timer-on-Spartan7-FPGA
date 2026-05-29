//====================================================
// FILE: f1_reaction_timer.v
//====================================================

module f1_reaction_timer(

    input clk,
    input start,
    input stop,
    input clear,

    output reg [4:0] leds,

    output [6:0] seg,
    output [3:0] an

);

//====================================================
// STATES
//====================================================

parameter IDLE   = 4'd0;
parameter L1     = 4'd1;
parameter L2     = 4'd2;
parameter L3     = 4'd3;
parameter L4     = 4'd4;
parameter L5     = 4'd5;
parameter BLINK  = 4'd6;
parameter TIMING = 4'd7;
parameter DONE   = 4'd8;

reg [3:0] state;

//====================================================
// COUNTERS
//====================================================

reg [31:0] delay_counter;
reg [16:0] ms_counter;

reg [13:0] reaction_time;

//====================================================
// DISPLAY DIGITS
//====================================================

reg [3:0] d0;
reg [3:0] d1;
reg [3:0] d2;
reg [3:0] d3;

integer temp;

//====================================================
// PARAMETERS
//====================================================

// FOR FPGA
parameter LIGHT_DELAY = 50000000;

// FOR FAST SIMULATION
// parameter LIGHT_DELAY = 50;

//====================================================
// MAIN FSM
//====================================================

always @(posedge clk or posedge clear)
begin

    if(clear)
    begin

        state <= IDLE;

        leds <= 5'b00000;

        delay_counter <= 0;
        ms_counter <= 0;

        reaction_time <= 0;

    end

    else
    begin

        case(state)

        //================================================
        // IDLE
        //================================================

        IDLE:
        begin

            leds <= 5'b00000;

            reaction_time <= 0;

            ms_counter <= 0;

            if(start)
            begin

                delay_counter <= 0;

                state <= L1;

            end

        end

        //================================================
        // L1
        //================================================

        L1:
        begin

            leds <= 5'b00001;

            if(stop)
            begin

                reaction_time <= 9999;

                state <= DONE;

            end

            else if(delay_counter < LIGHT_DELAY)
            begin

                delay_counter <= delay_counter + 1;

            end

            else
            begin

                delay_counter <= 0;

                state <= L2;

            end

        end

        //================================================
        // L2
        //================================================

        L2:
        begin

            leds <= 5'b00011;

            if(stop)
            begin

                reaction_time <= 9999;

                state <= DONE;

            end

            else if(delay_counter < LIGHT_DELAY)
            begin

                delay_counter <= delay_counter + 1;

            end

            else
            begin

                delay_counter <= 0;

                state <= L3;

            end

        end

        //================================================
        // L3
        //================================================

        L3:
        begin

            leds <= 5'b00111;

            if(stop)
            begin

                reaction_time <= 9999;

                state <= DONE;

            end

            else if(delay_counter < LIGHT_DELAY)
            begin

                delay_counter <= delay_counter + 1;

            end

            else
            begin

                delay_counter <= 0;

                state <= L4;

            end

        end

        //================================================
        // L4
        //================================================

        L4:
        begin

            leds <= 5'b01111;

            if(stop)
            begin

                reaction_time <= 9999;

                state <= DONE;

            end

            else if(delay_counter < LIGHT_DELAY)
            begin

                delay_counter <= delay_counter + 1;

            end

            else
            begin

                delay_counter <= 0;

                state <= L5;

            end

        end

        //================================================
        // L5
        //================================================

        L5:
        begin

            leds <= 5'b11111;

            if(stop)
            begin

                reaction_time <= 9999;

                state <= DONE;

            end

            else if(delay_counter < LIGHT_DELAY)
            begin

                delay_counter <= delay_counter + 1;

            end

            else
            begin

                delay_counter <= 0;

                state <= BLINK;

            end

        end

        //================================================
        // BLINK
        // AFTER 5TH LED:
        // ALL LEDs OFF 20ms
        // ALL LEDs ON 20ms
        // TIMER STARTS
        //================================================

        BLINK:
        begin

            // OFF FOR 20ms

            if(delay_counter < 25000000)
            begin

                leds <= 5'b00000;

                delay_counter <= delay_counter + 1;

            end

            // ON FOR 20ms

            else if(delay_counter < 50000000)
            begin

                leds <= 5'b11111;

                delay_counter <= delay_counter + 1;

            end

            // START TIMER

            else
            begin

                leds <= 5'b00000;

                delay_counter <= 0;

                ms_counter <= 0;

                reaction_time <= 0;

                state <= TIMING;

            end

        end

        //================================================
        // TIMING
        //================================================

        TIMING:
        begin

            leds <= 5'b00000;

            if(ms_counter < 99999)
            begin

                ms_counter <= ms_counter + 1;

            end

            else
            begin

                ms_counter <= 0;

                if(reaction_time < 9999)
                begin

                    reaction_time <= reaction_time + 1;

                end

            end

            if(stop)
            begin

                state <= DONE;

            end

        end

        //================================================
        // DONE
        //================================================

        DONE:
        begin

            leds <= 5'b00000;

        end

        endcase

    end

end

//====================================================
// BINARY TO BCD
//====================================================

always @(*)
begin

    temp = reaction_time;

    d0 = temp % 10;
    temp = temp / 10;

    d1 = temp % 10;
    temp = temp / 10;

    d2 = temp % 10;
    temp = temp / 10;

    d3 = temp % 10;

end

//====================================================
// SEVEN SEGMENT INSTANCE
//====================================================

seven_segment_display SSD(

    .clk(clk),

    .digit3(d3),
    .digit2(d2),
    .digit1(d1),
    .digit0(d0),

    .seg(seg),
    .an(an)

);

endmodule