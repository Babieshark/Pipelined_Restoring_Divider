`define N(n)                       [(n)-1:0]
`define FFx(signal,bits)           always @ (posedge clk or posedge rst) if (rst) signal <= bits; else

`define PERIOD 10
`define XLEN   32
`define DEL     2

module tb;

    reg clk = 0;
    always #(`PERIOD/2) clk = ~clk;

    reg rst = 1;
    initial #(`PERIOD) rst = 0;

    reg  `N(`XLEN) dividend, divisor, expected_quo, expected_rem;
    reg            vld = 0;

    wire `N(`XLEN) quo, rem;
    wire           ack;

    localparam STAGE_LIST = 32'h0101_0101;

    function `N($clog2(`XLEN+1)) bitcount(input `N(`XLEN) n);
        integer i;
        begin
            bitcount = 0;
            for (i = 0; i < `XLEN; i = i + 1)
                bitcount = bitcount + n[i];
        end
    endfunction

    wire `N($clog2(`XLEN+1)) stage_num = bitcount(STAGE_LIST);

    divfunc #(
        .XLEN(`XLEN),
        .STAGE_LIST(STAGE_LIST)
    ) i_div (
        .clk(clk),
        .rst(rst),
        .a(dividend),
        .b(divisor),
        .vld(vld),
        .quo(quo),
        .rem(rem),
        .ack(ack)
    );

    task one_div_operation(input [31:0] a, b);
        begin
            @(posedge clk);
            dividend = a;
            divisor  = b;
            expected_quo = a / b;
            expected_rem = a % b;

            #`DEL vld = 1;
            @(posedge clk);
            #`DEL vld = 0;

            repeat (stage_num) @(posedge clk);

            if (!(quo == expected_quo && rem == expected_rem)) begin
                $display("ERROR");
                $stop;
            end
        end
    endtask

    initial begin
        @(negedge rst);
        one_div_operation(625, 5);
        $display("Test completed");
        $stop;
    end

endmodule
