// tb.v
// Testbench for ALU (Task 5)

module tb;

    reg  [3:0] t_a;
    reg  [3:0] t_b;
    reg        t_op;
    wire [3:0] t_result;

    // Instantiate DUT
    alu DUT (
        .a(t_a),
        .b(t_b),
        .op(t_op),
        .result(t_result)
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
        // Test 1: Addition (op = 0)
        t_a = 4'd5; t_b = 4'd3; t_op = 1'b0; #5; // Expected: 8

        // Test 2: Subtraction (op = 1) with same inputs (tests sensitivity to op)
        t_op = 1'b1; #5;                        // Expected: 2

        // Test 3: Subtraction with negative result wrapping
        t_a = 4'd2; t_b = 4'd5; t_op = 1'b1; #5; // Expected: 13 (-3 in 4-bit)

        // Test 4: Addition
        t_a = 4'd7; t_b = 4'd8; t_op = 1'b0; #5; // Expected: 15

        $finish;
    end

    initial
        $monitor($time, " a=%0d b=%0d op=%b | result=%0d", t_a, t_b, t_op, t_result);

endmodule