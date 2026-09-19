// and_beh_before.v
// Behavioral AND gate with delay before statement execution (#5 y = ...)

module and_beh_before (
    input      a,
    input      b,
    output reg y
);

always @(*) begin
    #5 y = a & b;
end

endmodule