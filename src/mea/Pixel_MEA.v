module Pixel_MEA(
	input rst,
	input clk,
	input clk100_en,
	
	output reg SRAM_WE,
	output reg SRAM_D1,
	output reg SRAM_D2
);

reg [3:0] cnt;

always @(posedge clk or posedge rst)
	if(rst)
		cnt <= 3'b1;
  else
  	if (clk100_en)
			if(cnt)
				cnt <= cnt + 3'b1;
			else
				cnt <= 3'b0;

always@(posedge clk or posedge rst)
begin
	if(rst)
			SRAM_WE <= 1'b0;
  else
  	if (clk100_en)
			if(cnt == 4'd2)
					SRAM_WE <= 1'b1;
			else if(cnt == 4'd8)
					SRAM_WE <= 1'b0;
			else
					SRAM_WE <= SRAM_WE;
end


always@(posedge clk or posedge rst)
begin
	if(rst)
			SRAM_D2 <= 1'b0;
	else
  	if (clk100_en)
			if(cnt == 4'd2)
					SRAM_D2 <= 1'b1;
			else if(cnt == 4'd6)
					SRAM_D2 <= 1'b0;
			else
					SRAM_D2 <= SRAM_D2;
end

always@(posedge clk or posedge rst)
begin
	if(rst)
			SRAM_D1 <= 1'b0;
	else
		if (clk100_en)
			if(cnt == 4'd1)
					SRAM_D1 <= 1'b1;
			else if(cnt == 4'd4)
					SRAM_D1 <= 1'b0; 
			else
					SRAM_D1 <= SRAM_D1;
end

endmodule
