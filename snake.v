module snake(hex3_d,hex2_d,hex1_d,hex0_d,p,sw,button,clk);
output [6:0]hex0_d;
output [6:0]hex1_d;
output [6:0]hex2_d;
output [6:0]hex3_d;
output [3:0]p;
input clk;
input [3:0]sw;
input [2:0]button
reg [21:0]clkcount;
//clk,rst,hold,p,led,hex1_d,hex0_d
assign p[3]=sw[3];
assign p[2]=sw[2];
assign p[1]=sw[1];
assign p[0]=sw[0];
endmodule 