module uart_system_top(
    input wire clk,       // System clock
    input wire rst,           // Active-high system reset
    input wire [7:0] data_in, // Data input for UART transmitter
    input wire transfer_byte, // Start transmission signal
    input wire byte_ready,    // Data register to shift register load enable
    input wire load_data_reg, // Load data into data register from data bus
    output wire serial_out    // Serial output from UART transmitter
);

    // Signals for UART and Baud Rate Generator
    logic tick;               // Tick from baud rate generator
    logic clk_uart;           // UART clock driven by baud rate tick

    // Instance of baud rate generator
    baud_rate_gen baud_gen(
        .clk(clk),
        .rst(rst),
        .dvsr(32'd5), // Example divisor for 9600 baud rate from a 50MHz clock
        .tick(tick)
    );

    // Generate UART clock from baud tick
    assign clk_uart = tick;

    // Instance of UART transmitter
    uart_transmitter uart_tx(
        .data_in(data_in),
        .transfer_byte(transfer_byte),
        .clk(clk_uart),       // Driven by baud rate tick
        .byte_ready(byte_ready),
        .load_data_reg(load_data_reg),
        .rst(rst),         // Convert active-high reset to active-low for UART
        .serial_out(serial_out)
    );

endmodule
