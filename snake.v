module snake(hex3_d,hex2_d,hex1_d,hex0_d,p,sw,button,clk);
//hex3_d,hex2_d,hex1_d,hex0_d
output [6:0]hex0_d;
output [6:0]hex1_d;
output [6:0]hex2_d;
output [6:0]hex3_d;
reg [2:0]hex_d[11:0];
output [3:0]p;
input clk;
input [3:0]sw;
input [2:0]button;
reg [21:0]clkcount;
//clk,rst,hold,p,led,hex1_d,hex0_d
assign p[3]=sw[3];
assign p[2]=sw[2];
assign p[1]=sw[1];
assign p[0]=sw[0];

assign hex0_d[0]=hex_d[11][0];
assign hex0_d[1]=hex_d[10][2];
assign hex0_d[2]=hex_d[9][2];
assign hex0_d[3]=hex_d[9][0];
assign hex0_d[4]=hex_d[9][1];
assign hex0_d[5]=hex_d[10][1];
assign hex0_d[6]=hex_d[10][0];
always
begin
hex_d[11][0]=0;
hex_d[10][2]=1;
hex_d[10][1]=0;
hex_d[10][0]=0;
hex_d[9][2]=0;
hex_d[9][1]=1;
hex_d[9][0]=0;
end
/*
hex0_d[0]=hex_d[2][0];
hex0_d[0]=hex_d[2][0];
hex0_d[0]=hex_d[2][0];
hex0_d[0]=hex_d[2][0];
hex0_d[0]=hex_d[2][0];*/
endmodule 