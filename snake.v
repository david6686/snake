module snake(hex3_d,hex2_d,hex1_d,hex0_d,p,sw,button,clk);
//hex3_d,hex2_d,hex1_d,hex0_d
output [6:0]hex0_d;
output [6:0]hex1_d;
output [6:0]hex2_d;
output [6:0]hex3_d;
reg [2:0]hex_d[11:0];
reg [4:0]headx;
reg [2:0]heady;
reg direction;
output [3:0]p;
input clk;
input [3:0]sw;
input [2:0]button;
reg [21:0]clkcount;
//clk,rst,hold,p,led,hex1_d,hex0_d
/*switch control point*/
assign p[3]=sw[3];
assign p[2]=sw[2];
assign p[1]=sw[1];
assign p[0]=sw[0];
/*end*/
/*hex0_d  (left 1 7seg)*/
assign hex0_d[0]=hex_d[2][0];
assign hex0_d[1]=hex_d[1][2];
assign hex0_d[2]=hex_d[0][2];
assign hex0_d[3]=hex_d[0][0];
assign hex0_d[4]=hex_d[0][1];
assign hex0_d[5]=hex_d[1][1];
assign hex0_d[6]=hex_d[1][0];
/*end*/
/*hex1_d  (left 1 7seg)*/
assign hex1_d[0]=hex_d[5][0];
assign hex1_d[1]=hex_d[4][2];
assign hex1_d[2]=hex_d[3][2];
assign hex1_d[3]=hex_d[3][0];
assign hex1_d[4]=hex_d[3][1];
assign hex1_d[5]=hex_d[4][1];
assign hex1_d[6]=hex_d[4][0];
/*end*/
/*hex2_d  (left 1 7seg)*/
assign hex2_d[0]=hex_d[8][0];
assign hex2_d[1]=hex_d[7][2];
assign hex2_d[2]=hex_d[6][2];
assign hex2_d[3]=hex_d[6][0];
assign hex2_d[4]=hex_d[6][1];
assign hex2_d[5]=hex_d[7][1];
assign hex2_d[6]=hex_d[7][0];
/*end*/
/*hex3_d  (left 1 7seg)*/
assign hex3_d[0]=hex_d[11][0];
assign hex3_d[1]=hex_d[10][2];
assign hex3_d[2]=hex_d[9][2];
assign hex3_d[3]=hex_d[9][0];
assign hex3_d[4]=hex_d[9][1];
assign hex3_d[5]=hex_d[10][1];
assign hex3_d[6]=hex_d[10][0];
/*end*/
/*test*/
/*
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
*/
/*test*/

endmodule 