module alu_8bit (
    input  wire [7:0] A,
    input  wire [7:0] B,
    input  wire [2:0] opcode,
    output reg  [7:0] result,
    output reg        carry,
    output reg        overflow,
    output wire       zero
);

    localparam ADD = 3'b000;
    localparam SUB = 3'b001;
    localparam AND_OP = 3'b010;
    localparam OR_OP  = 3'b011;
    localparam XOR_OP = 3'b100;
    localparam NOT_OP = 3'b101;
    localparam SHL = 3'b110;
    localparam SHR = 3'b111;

    reg [8:0] temp;

    always @(*) begin
        result   = 8'b00000000;
        carry    = 1'b0;
        overflow = 1'b0;
        temp     = 9'b000000000;

        case (opcode)
            ADD: begin
                temp = {1'b0, A} + {1'b0, B};
                result = temp[7:0];
                carry = temp[8];
                overflow = (~(A[7] ^ B[7])) & (result[7] ^ A[7]);
            end

            SUB: begin
                result = A - B;
                overflow = (A[7] ^ B[7]) & (result[7] ^ A[7]);
            end

            AND_OP: result = A & B;
            OR_OP:  result = A | B;
            XOR_OP: result = A ^ B;
            NOT_OP: result = ~A;
            SHL:    result = A << 1;
            SHR:    result = A >> 1;

            default: result = 8'b00000000;
        endcase
    end

    assign zero = (result == 8'b00000000);

endmodule
