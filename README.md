# UART Module Project

This project implements a UART (Universal Asynchronous Receiver/Transmitter) module in SystemVerilog. The project consists of three main components: a baud rate generator, a UART transmitter, and a top-level module to integrate these components.

## Files

- `baud_rate_gen.sv`: Baud rate generator module
- `uart_trans.sv`: UART transmitter module
- `uart_top.sv`: Top-level module integrating the baud rate generator and the UART transmitter

## Module Descriptions

### Baud Rate Generator (`baud_rate_gen.sv`)

This module generates a tick signal based on the input clock and the divisor value to achieve the desired baud rate.

#### Ports:
- `input logic clk`: System clock
- `input logic rst`: Active-high reset signal
- `input logic [31:0] dvsr`: Divisor value for baud rate generation
- `output logic tick`: Tick signal for baud rate

#### Functionality:
- The module counts clock cycles up to the divisor value and then generates a tick signal. The counter resets after reaching the divisor value.

### UART Transmitter (`uart_trans.sv`)

This module handles the transmission of data through the UART protocol.

#### Ports:
- `input wire [7:0] data_in`: Data input for UART transmitter
- `input wire transfer_byte`: Signal to start data transmission
- `input wire clk`: System clock
- `input wire byte_ready`: Signal indicating data byte is ready
- `input wire load_data_reg`: Signal to load data into the shift register
- `input wire rst`: Active-low reset signal
- `output reg serial_out`: Serial output from UART transmitter

#### Functionality:
- The module implements a state machine with states for idle, load, transmit, and stop bit. It shifts out data bits sequentially at the baud rate tick.

### Top-Level Module (`uart_top.sv`)

This module integrates the baud rate generator and the UART transmitter.

#### Ports:
- `input wire clk`: System clock
- `input wire rst`: Active-high system reset
- `input wire [7:0] data_in`: Data input for UART transmitter
- `input wire transfer_byte`: Data transmission signal
- `input wire byte_ready`: Data register to shift register load enable
- `input wire load_data_reg`: Load data into data register from data bus
- `output wire serial_out`: Serial output from UART transmitter

#### Functionality:
- Instantiates the baud rate generator and UART transmitter modules.
- Connects the tick signal from the baud rate generator to drive the UART clock.

## Usage

1. **Simulation**: You can simulate the UART modules using your preferred SystemVerilog simulator to verify their functionality.
2. **Synthesis**: The modules are synthesizable and can be implemented on FPGAs. Ensure to configure the `dvsr` parameter correctly to achieve the desired baud rate.



