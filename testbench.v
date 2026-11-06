module tb_alu_8bit;

reg [7:0] A, B;
reg [2:0] opcode;
wire [7:0] result;
wire carry, overflow, zero;

integer passed;
integer failed;

alu_8bit uut (
    .A(A), .B(B), .opcode(opcode),
    .result(result), .carry(carry),
    .overflow(overflow), .zero(zero)
);

task check;
    input [7:0] x, y;
    input [2:0] op;
    input [7:0] expected_result;
    input expected_carry, expected_overflow, expected_zero;
    begin
        A = x;
        B = y;
        opcode = op;
        #10;

        if (result === expected_result &&
            carry === expected_carry &&
            overflow === expected_overflow &&
            zero === expected_zero) begin
            $display("PASS: OP=%b A=%h B=%h RESULT=%h",
                     opcode, A, B, result);
            passed = passed + 1;
        end else begin
            $display("FAIL: OP=%b A=%h B=%h EXPECTED=%h ACTUAL=%h",
                     opcode, A, B, expected_result, result);
            failed = failed + 1;
        end
    end
endtask

initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_alu_8bit);

    passed = 0;
    failed = 0;

    $display("8-BIT ALU SELF-CHECKING TESTBENCH");
    $display("----------------------------------------");

    check(10, 5, 3'b000, 15, 0, 0, 0);
    check(10, 5, 3'b001, 5,  0, 0, 0);
    check(10, 5, 3'b010, 0,  0, 0, 1);
    check(10, 5, 3'b011, 15, 0, 0, 0);
    check(10, 5, 3'b100, 15, 0, 0, 0);
    check(10, 5, 3'b101, 245,0, 0, 0);
    check(10, 5, 3'b110, 20, 0, 0, 0);
    check(10, 5, 3'b111, 5,  0, 0, 0);

    // Boundary tests
    check(255, 1, 3'b000, 0,   1, 0, 1);
    check(127, 1, 3'b000, 128, 0, 1, 0);
    check(128, 1, 3'b001, 127, 0, 1, 0);

    $display("----------------------------------------");
    $display("TOTAL TESTS: %d", passed + failed);
    $display("PASSED:      %d", passed);
    $display("FAILED:      %d", failed);
    if (failed == 0)
        $display("ALL TESTS PASSED!");
    else
        $display("SOME TESTS FAILED!");
    $display("----------------------------------------");
    $finish;
end

endmodule
