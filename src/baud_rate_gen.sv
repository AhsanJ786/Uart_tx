module baud_rate_gen (clk,rst,dvsr,tick);
input logic clk,rst;
output logic tick;
input logic [31:0] dvsr;
// assigning internal wires
logic [31:0] r_reg;
logic [31:0] r_next;
always_ff @( posedge clk or negedge rst ) begin 
    if ( !rst)
    r_reg <= 0;
    else
    r_reg <= r_next;   
end
assign r_next = (r_reg == dvsr) ? 0: r_reg+1;
assign tick = (r_reg == 1);

    
endmodule