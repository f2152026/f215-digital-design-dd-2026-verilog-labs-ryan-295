// tb.v
// Self-checking testbench for 2-bit unsigned magnitude comparator

module tb;

    reg  [1:0] t_a;
    reg  [1:0] t_b;
    wire       t_gt;
    wire       t_lt;
    wire       t_eq;

    integer i, j;
    integer errors = 0;

    // Instantiate DUT
    comp2 DUT (
        .A(t_a),
        .B(t_b),
        .GT(t_gt),
        .LT(t_lt),
        .EQ(t_eq)
    );

    // Waveform dump configuration
    string vcd_file;
    initial begin
        if ($value$plusargs("vcd=%s", vcd_file)) begin
            $dumpfile(vcd_file);
            $dumpvars(0, DUT);
        end
    end

    initial begin
        for (i = 0; i < 4; i = i + 1) begin
            for (j = 0; j < 4; j = j + 1) begin
                t_a = i;
                t_b = j;
                #5;

                // Self-checking assertions
                if (t_gt !== (i > j) || t_lt !== (i < j) || t_eq !== (i == j)) begin
                    $display("ERROR at time %0t: A=%d, B=%d | GT=%b (expected %b), LT=%b (expected %b), EQ=%b (expected %b)",
                             $time, t_a, t_b, t_gt, (i > j), t_lt, (i < j), t_eq, (i == j));
                    errors = errors + 1;
                end
            end
        end

        if (errors == 0) begin
            $display("ALL TESTS PASSED SUCCESSFULLY!");
        end else begin
            $display("TEST FAILED with %0d error(s).", errors);
        end

        $finish;
    end

endmodule