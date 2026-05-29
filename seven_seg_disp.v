module seven_segment_display(

    input clk,

    input [3:0] digit3,
    input [3:0] digit2,
    input [3:0] digit1,
    input [3:0] digit0,

    output reg [6:0] seg,
    output reg [3:0] an

);

reg [19:0] refresh_counter;

reg [3:0] digit;

wire [1:0] refresh_select;

//====================================================
// REFRESH COUNTER
//====================================================

always @(posedge clk)
begin

    refresh_counter <= refresh_counter + 1;

end

assign refresh_select = refresh_counter[19:18];

//====================================================
// DIGIT SELECT
//====================================================

always @(*)
begin

    case(refresh_select)

    2'b00:
    begin

        an = 4'b1110;

        digit = digit0;

    end

    2'b01:
    begin

        an = 4'b1101;

        digit = digit1;

    end

    2'b10:
    begin

        an = 4'b1011;

        digit = digit2;

    end

    2'b11:
    begin

        an = 4'b0111;

        digit = digit3;

    end

    endcase

end

//====================================================
// BCD TO 7 SEGMENT
//====================================================

always @(*)
begin

    case(digit)

    4'd0: seg = 7'b1000000;
    4'd1: seg = 7'b1111001;
    4'd2: seg = 7'b0100100;
    4'd3: seg = 7'b0110000;
    4'd4: seg = 7'b0011001;
    4'd5: seg = 7'b0010010;
    4'd6: seg = 7'b0000010;
    4'd7: seg = 7'b1111000;
    4'd8: seg = 7'b0000000;
    4'd9: seg = 7'b0010000;

    default: seg = 7'b1111111;

    endcase

end

endmodule