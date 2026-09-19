// tb.v
// Starter testbench template -- YOU complete this file.

module tb;

  parameter WIDTH = 8;
    parameter DEPTH = 4;

    // TODO: declare the inputs and outputs
    reg  [$clog2(DEPTH)-1:0] sel;
    wire [WIDTH-1:0]        dout;

    // TODO: instantiate DUT here (named DUT to match $dumpvars)
    lut #(
        .WIDTH(WIDTH),
        .DEPTH(DEPTH)
    ) DUT (
        .sel(sel),
        .dout(dout)
    );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT);
    end
  end

  initial begin
   sel = 0; #5;
        sel = 1; #5;
        sel = 2; #5;
        sel = 3; #5;
        $finish;

  end

  initial
    $monitor($time, " sel=%0d | dout=%0d", sel, dout);

endmodule
