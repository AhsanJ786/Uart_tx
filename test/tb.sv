`timescale 1ns / 1ps

module tb_uart_system_top;

    // Testbench signals
    reg clk;
    reg rst;
    reg [7:0] data_in;
    reg transfer_byte;
    reg byte_ready;
    reg load_data_reg;
    wire serial_out;

    // Instantiate the top-level module
    uart_system_top uut(
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .transfer_byte(transfer_byte),
        .byte_ready(byte_ready),
        .load_data_reg(load_data_reg),
        .serial_out(serial_out)
    );

    // Clock generation
    always #50 clk = ~clk; // Generate a 100 MHz system clock

    // Initial block for simulation
    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        data_in = 8'h00;
        transfer_byte = 0;
        byte_ready = 0;
        load_data_reg = 0;

        // Setup simulation
        $dumpfile("uart_system_top.vcd");
        $dumpvars(0, tb_uart_system_top);

        // Reset sequence
        #20 rst = 0;
        #10 rst = 1;
        #30;

        // Test: Sending a byte
        data_in = 8'hA5;         // Example data byte
        load_data_reg = 1;       // Load the data into the data register
        //#10 load_data_reg = 0;
        #10 
        #10 
        #10 transfer_byte = 1;   // Start the transmission
       // #10 transfer_byte = 0;
        #20 byte_ready = 1;
        #1800 data_in = 8'h88;

        // Allow time for transmission to complete
        #9000;

        // End of simulation
        $finish;
    end

endmodule
