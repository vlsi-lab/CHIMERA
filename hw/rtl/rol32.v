module rol32(
    input  wire [31:0] high,
    input  wire [31:0] low,
    input  wire [2:0]  op,          // Operation selector
    output reg  [31:0] result1,     // MSB (upper 32 bits)
    output reg  [31:0] result2      // LSB (lower 32 bits)
);

    reg [63:0] ab;                  // Concatenated 64-bit value
    reg [63:0] result_n1, result_n2;
    reg [63:0] result;

    always @(*) begin
        // Concatenate `high` and `low` to form a 64-bit value
        ab = {high, low};

        // Perform the rotation based on op
        case (op)
            3'b100: begin
                result_n1 = (ab >> 8'd19) | (ab << 8'd45); // 64 - 19 = 45
                result_n2 = (ab >> 8'd28) | (ab << 8'd36); // 64 - 28 = 36
            end
            3'b110: begin
                result_n1 = (ab >> 8'd61) | (ab << 8'd3);  // 64 - 61 = 3
                result_n2 = (ab >> 8'd39) | (ab << 8'd25); // 64 - 39 = 25
            end
            3'b111: begin
                result_n1 = (ab >> 8'd1)  | (ab << 8'd63); // 64 - 1 = 63
                result_n2 = (ab >> 8'd6)  | (ab << 8'd58); // 64 - 6 = 58
            end
            3'b000: begin
                result_n1 = (ab >> 8'd10) | (ab << 8'd54); // 64 - 10 = 54
                result_n2 = (ab >> 8'd17) | (ab << 8'd47); // 64 - 17 = 47
            end
            3'b001: begin
                result_n1 = (ab >> 8'd7)  | (ab << 8'd57); // 64 - 7 = 57
                result_n2 = (ab >> 8'd41) | (ab << 8'd23); // 64 - 41 = 23
            end
            default: begin
                result_n1 = ab; // Default case: no shift
                result_n2 = ab; // Default case: no shift
            end
        endcase

        // Combine the results
        result = result_n1 ^ result_n2 ^ ab;

        // Extract the upper and lower 32 bits of the result
        result1 = result[63:32];    // Upper 32 bits
        result2 = result[31:0];     // Lower 32 bits
    end
endmodule