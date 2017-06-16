module snake(hex3_d,hex2_d,hex1_d,hex0_d,p,sw,button,clk,rst);
//hex3_d,hex2_d,hex1_d,hex0_d
output [6:0]hex0_d;
output [6:0]hex1_d;
output [6:0]hex2_d;
output [6:0]hex3_d;
input rst;
//output testled;
reg [2:0]hex_d[11:0];
reg  [6:0]record[30:0];   // delete is 7'b11111   record every seg of snake
reg [3:0]x;
reg [2:0]y;
reg [3:0]regp=3'b000;
integer length=0;  //start from 0   length 0 actually is 1
//reg [4:0]headx=5'd9;
//reg [2:0]heady=3'd1;
integer initheadx=7;
integer initheady=0;
integer headx;
integer heady;
integer tempheadx;
integer tempheady;
integer lasttailx;
integer lasttaily;
integer secondtailx;
integer secondtaily;
reg [1:0]tempdirection=2'b11;
reg [1:0]direction=2'b11;
//integer direction=0;
reg blockdirection=1'b0;
output [3:0]p;
input clk;
input [3:0]sw;
input [2:0]button;
reg [26:0]clkcount;
reg cycle;
reg error=1'b0;
reg delete;
integer i;
integer j;
//clk,rst,hold,p,led,hex1_d,hex0_d
/*switch control point*/
/*initialization*/
initial begin
	for (i = 0; i < 12; i = i + 1)
	begin
		hex_d[i]=3'b111;
	end
	for (i = 0; i < 31; i = i + 1)
	begin
		record[i]=7'b1111111;
	end
	hex_d[initheadx][initheady]=1'b0;
	headx=initheadx;
	heady=initheady;
	x=headx;	
	y=heady;	
	record[length]={x,y};
	//direction;
	//lasttailx=headx;
	//lasttaily=heady;

end
/*end*/
/*
assign p[3]=!sw[3];
assign p[2]=!sw[2];
assign p[1]=!sw[1];
assign p[0]=!sw[0];*/
assign p[3]=!regp[3];
assign p[2]=!regp[2];
assign p[1]=!regp[1];
assign p[0]=!regp[0];
/*
always@(*)
begin
headx = 10;
heady = 2;
hex_d[headx][heady]<=1'b0;
end
*/
//reset

/*clk*/
always@(posedge clk)
begin
clkcount<=clkcount+1'b1;
cycle=clkcount[25];
end
/*direction*/
/*
always
begin
	if(button[2]==1'b0)
	begin
		if(button[1]==1'b1&&button[0]==1'b0)
		begin
			direction=2'b11;
		end
		if(button[1]==1'b0&&button[0]==1'b1)
		begin
			direction=2'b01;
		end
		else
		begin
			direction=2'b00;
			//p[0]=1'b0;
			//$display("!!!");
		end
	end
	else
	begin
		direction=2'b10;
	end
	direction=2'b00;
end
*/
always@(posedge cycle)
begin
	delete=1'b1;
	if(sw[0])
		regp[0]=1'b1;
	if(sw[1])
		regp[1]=1'b1;
	if(sw[2])
		regp[2]=1'b1;
	if(sw[3])
		regp[3]=1'b1;
	delete=1'b1;
	tempheadx=headx;
	tempheady=heady;
	//direction
	if(button[2]==1'b1)
	begin
		if(button[1]==1'b0&&button[0]==1'b1)
		begin
			direction=2'b11;
		end
		else if(button[1]==1'b1&&button[0]==1'b0)
		begin
			direction=2'b01;
		end
		else
		begin
			direction=2'b00;
		end
	end
	else
	begin
		direction=2'b10;
	end
	/*
	if((tempdirection==2'b00&&direction==2'b10)
	||(tempdirection==2'b01&&direction==2'b11)
	||(tempdirection==2'b10&&direction==2'b00)
	||(tempdirection==2'b11&&direction==2'b01))
	begin
		//direction=tempdirection;
		//error=1'b1;
	end*/
	tempdirection=direction;
	
	if(error==1'b0)
	begin
		/*point*/
		if(headx==0&&heady==0&&direction==2'b01)
		begin
			regp[3]=1'b0;
			delete=1'b0;
		end
		if(headx==0&&heady==0&&direction==2'b11)
		begin
			regp[0]=1'b0;
			delete=1'b0;
		end
		if(headx==3&&heady==0&&direction==2'b01)
		begin
			regp[2]=1'b0;
			delete=1'b0;
		end
		if(headx==3&&heady==0&&direction==2'b11)
		begin
			regp[3]=1'b0;
			delete=1'b0;
		end
		if(headx==6&&heady==0&&direction==2'b01)
		begin
			regp[1]=1'b0;
			delete=1'b0;
		end
		if(headx==6&&heady==0&&direction==2'b11)
		begin
			regp[2]=1'b0;
			delete=1'b0;
		end
		if(headx==9&&heady==0&&direction==2'b11)
		begin
			regp[1]=1'b0;
			delete=1'b0;
		end
		if(headx==9&&heady==0&&direction==2'b01)
		begin
			regp[0]=1'b0;
			delete=1'b0;
		end
	end
////
	if(rst==1'b0)
	begin
		delete=1'b1;
		error=1'b0;
		tempdirection=2'b11;
		direction=2'b11;
		blockdirection=1'b0;
		//
		for (i = 0; i < 12; i = i + 1)
		begin
			hex_d[i]=3'b111;
		end
		for (i = 0; i < 31; i = i + 1)
		begin
			record[i]=7'b1111111;
		end
		hex_d[initheadx][initheady]=1'b0;
		headx=initheadx;
		heady=initheady;
		x=headx;	
		y=heady;	
		record[length]={x,y};
		//
		length=0;
		hex_d[0][0]=1'b1;
		hex_d[0][1]=1'b1;
		hex_d[0][2]=1'b1;
		hex_d[1][0]=1'b1;
		hex_d[1][1]=1'b1;
		hex_d[1][2]=1'b1;
		hex_d[2][0]=1'b1;
		hex_d[3][0]=1'b1;
		hex_d[3][1]=1'b1;
		hex_d[3][2]=1'b1;
		hex_d[4][0]=1'b1;
		hex_d[4][1]=1'b1;
		hex_d[4][2]=1'b1;
		hex_d[5][0]=1'b1;
		hex_d[6][0]=1'b1;
		hex_d[6][1]=1'b1;
		hex_d[6][2]=1'b1;
		hex_d[7][0]=1'b1;
		hex_d[7][1]=1'b1;
		hex_d[7][2]=1'b1;
		hex_d[8][0]=1'b1;
		hex_d[9][0]=1'b1;
		hex_d[9][1]=1'b1;
		hex_d[9][2]=1'b1;
		hex_d[10][0]=1'b1;
		hex_d[10][1]=1'b1;
		hex_d[10][2]=1'b1;
		hex_d[11][0]=1'b1;
		hex_d[7][0]=1'b0;
	end
	////
	
	else if(error==1'b0)
	begin

	if(headx==initheadx&&initheady==0)
		tempdirection=direction;
		
	
	//direction=2'b11;
	//direction=2'b00;
	//dirrectionmove
	case(direction)
	2'b00:
	begin
		if(heady==0)
		begin
			if(blockdirection==1'b0)
			begin
				heady=heady+1;
			end
			else if(blockdirection==1'b1)
			begin
				heady=heady+2;
			end
			if(headx==2||headx==5||headx==8||headx==11)
			begin
				headx=headx-2;
			end
			blockdirection=1'b0;
		end
		else
		begin
			headx=headx+1;
		end
		blockdirection=1'b0;
	end
	2'b01:
	begin
		if(heady!=0)
		begin
			if(blockdirection==1'b1)
			begin			
				if(heady==2)
					headx=headx+3;
				heady=0;
			end
			else if(blockdirection==1'b0)
			begin			
				headx=headx+1;
				blockdirection=1'b1;
				if(heady==2)
					headx=headx+3;
				heady=0;
			end
		end
		else
		begin
			headx=headx+3;
		end
		blockdirection=1'b1;

	end
	2'b10:
	begin
		if(heady==0)
		begin
			if(blockdirection==1'b0)
			begin
				heady=heady+1;
				headx=headx-1;
			end
			else if(blockdirection==1'b1)
			begin
				heady=heady+2;
				headx=headx-1;
			end
		end
		else
		begin
			headx=headx-1;
		end
		blockdirection=1'b1;
	end
	2'b11:
	begin
		if(heady!=0)
		begin
			if(blockdirection==1'b1)
			begin			
				if(heady==1)
					headx=headx-3;
				heady=0;
			end
			else if(blockdirection==1'b0)
			begin			
				headx=headx+1;
				blockdirection=1'b0;
				if(heady==1)
					headx=headx-3;
				heady=0;
			end
		end
		else
		begin
			headx=headx-3;
		end
		blockdirection=1'b0;
	end
	/*
	default:
	begin
		hex_d[6][1]=1'b0;
	end*/
	endcase
	
	
	//check over range
	//up range
	if(tempheadx==10&&headx==11&&direction==2'b00)
	begin
		headx=9;
	end
	else if(tempheadx==7&&headx==8&&direction==2'b00)
	begin
		headx=6;
	end
	else if(tempheadx==4&&headx==5&&direction==2'b00)
	begin
		headx=3;
	end
	else if(tempheadx==1&&headx==2&&direction==2'b00)
	begin
		headx=0;
	end
	//down range
	else if(tempheadx==0&&headx==-1)
	begin
		headx=1;
	end
	else if(tempheadx==3&&headx==2)
	begin
		headx=4;
	end
	else if(tempheadx==6&&headx==5)
	begin
		headx=7;
	end
	else if(tempheadx==9&&headx==8)
	begin
		headx=10;
	end
	//left range
	else if(headx==-1)
	begin
		headx=11;
	end
	else if(headx==-2)
	begin
		headx=10;
	end
	else if(headx==-3)
	begin
		headx=9;
	end
	//right rnage
	else if(headx==14)
	begin
		headx=2;
	end
	else if(headx==13)
	begin
		headx=1;
	end
	else if(headx==12)
	begin
		headx=0;
	end

/*
	//detect eat and get longer
	if((headx==0&&heady==0&&blockdirection==1'b1)
		&&(headx==9&&heady==0&&blockdirection==1'b0)
		&&(headx==0&&heady==2&&blockdirection==1'b1)
		&&(headx==3&&heady==2&&blockdirection==1'b1)
		&&(headx==6&&heady==2&&blockdirection==1'b1)
		&&(headx==3&&heady==0)
		&&(headx==6&&heady==0)
		)
		begin
			delete=1'b0;
		end
	//delete
	if(delete==1'b1)
	begin
		
	end*/
	//error detect2
	if(hex_d[headx][heady]==1'b0)
		error=1'b1;
		/*
	//up range
	if(tempheadx==10&&headx==11&&direction==2'b00)
	begin
		error=1'b1;
	end
	else if(tempheadx==7&&headx==8&&direction==2'b00)
	begin
		error=1'b1;
	end
	else if(tempheadx==4&&headx==5&&direction==2'b00)
	begin
		error=1'b1;
	end
	else if(tempheadx==1&&headx==2&&direction==2'b00)
	begin
		error=1'b1;
	end
	//down range
	else if(tempheadx==0&&headx==-1)
	begin
		error=1'b1;
	end
	else if(tempheadx==3&&headx==2)
	begin
		error=1'b1;
	end
	else if(tempheadx==6&&headx==5)
	begin
		error=1'b1;
	end
	*/
	//print and delete tail
	if(error==1'b0)
	begin
		//print
		hex_d[headx][heady]=1'b0;
		length=length+1;
		x=headx;
		y=heady;
		record[length]={x,y};
		if(delete==1'b1)
		begin
			y={record[0][2],record[0][1],record[0][0]};
			x={record[0][6],record[0][5],record[0][4],record[0][3]};
			hex_d[x][y]=1'b1;	
			for(i=0;i<30;i=i+1)
			begin
				record[i]=record[i+1];
			end
			length=length-1;
		end
	end
	
	//hex_d[tempheadx][tempheady]=1'b1;
	end
	//error print
	else if(error==1'b1)
	begin
		hex_d[0][0]=1'b0;
		hex_d[0][1]=1'b0;
		hex_d[0][2]=1'b1;
		hex_d[1][0]=1'b0;
		hex_d[1][1]=1'b0;
		hex_d[1][2]=1'b1;
		hex_d[2][0]=1'b0;
		hex_d[3][0]=1'b1;
		hex_d[3][1]=1'b0;
		hex_d[3][2]=1'b0;
		hex_d[4][0]=1'b0;
		hex_d[4][1]=1'b0;
		hex_d[4][2]=1'b0;
		hex_d[5][0]=1'b0;
		hex_d[6][0]=1'b1;
		hex_d[6][1]=1'b0;
		hex_d[6][2]=1'b0;
		hex_d[7][0]=1'b0;
		hex_d[7][1]=1'b0;
		hex_d[7][2]=1'b0;
		hex_d[8][0]=1'b0;
		hex_d[9][0]=1'b0;
		hex_d[9][1]=1'b1;
		hex_d[9][2]=1'b1;
		hex_d[10][0]=1'b1;
		hex_d[10][1]=1'b1;
		hex_d[10][2]=1'b1;
		hex_d[11][0]=1'b1;
	end
	//hex_d[10][1]=1'b0;
	//headx=5'd11;
	//heady=3'd1;
	
	//[4:0]headx=5'd11;
	
	//[2:0]heady=3'd0;
end

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